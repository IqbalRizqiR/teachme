import crypto from 'crypto';
import fs from 'fs';
import path from 'path';
import db from '../../lib/db';
import { env } from '../../config/env';
import { notFound, forbidden, badRequest } from '../../lib/errors';
import { createNotification } from '../notification/service';

const PDFDocument = require('pdfkit');

export async function getProgress(
  studentUserId: string,
  enrollmentId?: string,
) {
  const student = await db.studentProfile.findUnique({
    where: { userId: studentUserId },
  });
  if (!student) throw notFound('Student profile not found');

  const where: Record<string, unknown> = {
    booking: {
      enrollment: {
        studentId: student.id,
        ...(enrollmentId ? { id: enrollmentId } : {}),
      },
    },
  };

  const entries = await db.progressEntry.findMany({
    where,
    orderBy: { createdAt: 'desc' },
    include: {
      booking: {
        include: {
          slot: true,
          enrollment: {
            include: {
              tutorSubject: {
                include: {
                  subject: true,
                  tutor: {
                    include: { user: { select: { name: true } } },
                  },
                },
              },
            },
          },
        },
      },
    },
  });

  const enrollment = enrollmentId
    ? await db.enrollment.findFirst({
        where: { id: enrollmentId, studentId: student.id },
      })
    : null;

  const scores = entries.map((e) => e.score);
  const average =
    scores.length > 0
      ? Math.round(scores.reduce((a, b) => a + b, 0) / scores.length)
      : 0;

  return {
    entries: entries.map((e, i) => ({
      id: e.id,
      sessionNo: entries.length - i,
      date: e.createdAt,
      score: e.score,
      note: e.note,
      subjectName: e.booking.enrollment.tutorSubject.subject.name,
      tutorName: e.booking.enrollment.tutorSubject.tutor.user.name,
    })),
    summary: {
      targetScore: enrollment?.targetScore ?? null,
      minSessions: enrollment?.minSessions ?? null,
      completedSessions: entries.length,
      average,
    },
  };
}

export async function getEnrollments(studentUserId: string) {
  const student = await db.studentProfile.findUnique({
    where: { userId: studentUserId },
  });
  if (!student) throw notFound('Student profile not found');

  const enrollments = await db.enrollment.findMany({
    where: { studentId: student.id },
    include: {
      tutorSubject: {
        include: {
          subject: true,
          tutor: {
            include: { user: { select: { name: true } } },
          },
        },
      },
      bookings: {
        where: { status: 'COMPLETED' },
        include: { progress: true },
      },
      certificate: true,
    },
  });

  return enrollments.map((e) => {
    const completedBookings = e.bookings.filter((b) => b.progress);
    const scores = completedBookings
      .map((b) => b.progress!.score)
      .filter((s): s is number => s !== null);
    const average =
      scores.length > 0
        ? Math.round(scores.reduce((a, b) => a + b, 0) / scores.length)
        : 0;

    return {
      id: e.id,
      subjectName: e.tutorSubject.subject.name,
      tutorName: e.tutorSubject.tutor.user.name,
      targetScore: e.targetScore,
      minSessions: e.minSessions,
      completedSessions: completedBookings.length,
      averageScore: average,
      hasCertificate: e.certificate !== null,
      certificateId: e.certificate?.id ?? null,
    };
  });
}

export async function updateTarget(
  studentUserId: string,
  enrollmentId: string,
  data: { targetScore?: number; minSessions?: number },
) {
  const student = await db.studentProfile.findUnique({
    where: { userId: studentUserId },
  });
  if (!student) throw notFound('Student profile not found');

  const enrollment = await db.enrollment.findFirst({
    where: { id: enrollmentId, studentId: student.id },
  });
  if (!enrollment) throw notFound('Enrollment not found');

  return db.enrollment.update({
    where: { id: enrollmentId },
    data: {
      ...(data.targetScore !== undefined && { targetScore: data.targetScore }),
      ...(data.minSessions !== undefined && { minSessions: data.minSessions }),
    },
  });
}

export async function evaluateCertificate(enrollmentId: string) {
  const enrollment = await db.enrollment.findUnique({
    where: { id: enrollmentId },
    include: {
      student: {
        include: { user: { select: { id: true, name: true } } },
      },
      tutorSubject: {
        include: {
          subject: true,
          tutor: { include: { user: { select: { name: true } } } },
        },
      },
      bookings: {
        where: { status: 'COMPLETED' },
        include: { progress: true },
        orderBy: { createdAt: 'desc' },
      },
      certificate: true,
    },
  });

  if (!enrollment) throw notFound('Enrollment not found');
  if (enrollment.certificate) return { eligible: false, reason: 'already_issued' };
  if (!enrollment.targetScore || !enrollment.minSessions) {
    return { eligible: false, reason: 'targets_not_set' };
  }

  const completedWithGrades = enrollment.bookings.filter((b) => b.progress);
  if (completedWithGrades.length < enrollment.minSessions) {
    return { eligible: false, reason: 'insufficient_sessions' };
  }

  const lastThreeScores = completedWithGrades
    .slice(0, 3)
    .map((b) => b.progress!.score);
  const avgLastThree =
    lastThreeScores.reduce((a, b) => a + b, 0) / lastThreeScores.length;

  if (avgLastThree < enrollment.targetScore) {
    return { eligible: false, reason: 'score_below_target', avgLastThree };
  }

  const certCode = crypto.randomBytes(6).toString('hex').toUpperCase();
  const certDir = path.join(env.STORAGE_DIR, 'certificates');
  fs.mkdirSync(certDir, { recursive: true });
  const filePath = path.join(certDir, `${certCode}.pdf`);

  await new Promise<void>((resolve, reject) => {
    const doc = new PDFDocument({ size: 'A4', layout: 'landscape' });
    const stream = fs.createWriteStream(filePath);
    doc.pipe(stream);

    doc
      .fontSize(30)
      .text('CERTIFICATE OF COMPLETION', { align: 'center' })
      .moveDown(2);

    doc
      .fontSize(18)
      .text(`This certifies that`, { align: 'center' })
      .moveDown(0.5);

    doc
      .fontSize(24)
      .text(enrollment.student.user.name, { align: 'center' })
      .moveDown(1);

    doc
      .fontSize(14)
      .text(
        `has successfully completed the ${enrollment.tutorSubject.subject.name} program`,
        { align: 'center' },
      )
      .moveDown(0.5);

    doc
      .text(
        `with tutor ${enrollment.tutorSubject.tutor.user.name}`,
        { align: 'center' },
      )
      .moveDown(0.5);

    doc
      .text(
        `Average score: ${Math.round(avgLastThree)} | Sessions completed: ${completedWithGrades.length}`,
        { align: 'center' },
      )
      .moveDown(2);

    doc
      .fontSize(10)
      .text(`Certificate Code: ${certCode}`, { align: 'center' })
      .text(`Issued: ${new Date().toISOString().split('T')[0]}`, {
        align: 'center',
      });

    doc.end();
    stream.on('finish', resolve);
    stream.on('error', reject);
  });

  const certificate = await db.certificate.create({
    data: {
      enrollmentId,
      code: certCode,
      filePath,
    },
  });

  await createNotification(
    enrollment.student.user.id,
    'CERTIFICATE_ISSUED',
    'Certificate Issued',
    `Your certificate for ${enrollment.tutorSubject.subject.name} is ready!`,
    { certificateId: certificate.id, code: certCode },
  );

  return { eligible: true, certificate };
}

export async function downloadCertificate(
  studentUserId: string,
  certificateId: string,
) {
  const student = await db.studentProfile.findUnique({
    where: { userId: studentUserId },
  });
  if (!student) throw notFound('Student profile not found');

  const certificate = await db.certificate.findUnique({
    where: { id: certificateId },
    include: { enrollment: true },
  });
  if (!certificate) throw notFound('Certificate not found');

  if (certificate.enrollment.studentId !== student.id) {
    throw forbidden();
  }

  if (!fs.existsSync(certificate.filePath)) {
    throw notFound('Certificate file not found');
  }

  return certificate.filePath;
}

export async function verifyCertificate(code: string) {
  const certificate = await db.certificate.findUnique({
    where: { code },
    include: {
      enrollment: {
        include: {
          student: {
            include: { user: { select: { name: true } } },
          },
          tutorSubject: {
            include: {
              subject: true,
              tutor: { include: { user: { select: { name: true } } } },
            },
          },
        },
      },
    },
  });

  if (!certificate) throw notFound('Certificate not found');

  return {
    code: certificate.code,
    issuedAt: certificate.issuedAt,
    studentName: certificate.enrollment.student.user.name,
    subjectName: certificate.enrollment.tutorSubject.subject.name,
    tutorName: certificate.enrollment.tutorSubject.tutor.user.name,
  };
}
