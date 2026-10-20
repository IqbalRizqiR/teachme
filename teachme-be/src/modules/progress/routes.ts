import { Router, Request, Response } from 'express';
import fs from 'fs';
import { authenticate } from '../../middleware/auth';
import { requireRole } from '../../middleware/requireRole';
import * as progressService from './service';

const router = Router();

router.get(
  '/progress',
  authenticate,
  requireRole('STUDENT'),
  async (req: Request, res: Response) => {
    const enrollmentId = req.query.enrollmentId as string | undefined;
    const result = await progressService.getProgress(req.user!.sub, enrollmentId);
    res.json(result);
  },
);

router.get(
  '/enrollments',
  authenticate,
  requireRole('STUDENT'),
  async (req: Request, res: Response) => {
    const result = await progressService.getEnrollments(req.user!.sub);
    res.json(result);
  },
);

router.patch(
  '/enrollments/:id/target',
  authenticate,
  requireRole('STUDENT'),
  async (req: Request, res: Response) => {
    const result = await progressService.updateTarget(
      req.user!.sub,
      req.params.id as string,
      req.body,
    );
    res.json(result);
  },
);

router.get(
  '/certificates/:id/download',
  authenticate,
  requireRole('STUDENT'),
  async (req: Request, res: Response) => {
    const id = req.params.id as string;
    const filePath = await progressService.downloadCertificate(
      req.user!.sub,
      id,
    );
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader(
      'Content-Disposition',
      `attachment; filename="certificate-${id}.pdf"`,
    );
    const stream = fs.createReadStream(filePath);
    stream.pipe(res);
  },
);

router.get(
  '/certificates/verify/:code',
  async (req: Request, res: Response) => {
    const result = await progressService.verifyCertificate(req.params.code as string);
    res.json(result);
  },
);

export default router;
