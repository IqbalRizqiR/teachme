import { Router } from 'express';
import * as controller from './controller';
import { validate } from '../../middleware/validate';
import { authenticate } from '../../middleware/auth';
import { requireRole } from '../../middleware/requireRole';
import {
  createBookingBody,
  rejectBody,
  gradeBody,
  reviewBody,
  listBookingsQuery,
} from './schemas';

const router = Router();

router.use(authenticate);

router.post(
  '/',
  requireRole('STUDENT'),
  validate({ body: createBookingBody }),
  controller.createBooking,
);

router.get(
  '/',
  requireRole('STUDENT', 'TUTOR'),
  validate({ query: listBookingsQuery }),
  controller.listBookings,
);

router.get(
  '/:id',
  requireRole('STUDENT', 'TUTOR'),
  controller.getBooking,
);

router.post(
  '/:id/accept',
  requireRole('TUTOR'),
  controller.acceptBooking,
);

router.post(
  '/:id/reject',
  requireRole('TUTOR'),
  validate({ body: rejectBody }),
  controller.rejectBooking,
);

router.post(
  '/:id/cancel',
  requireRole('STUDENT'),
  controller.cancelBooking,
);

router.post(
  '/:id/grade',
  requireRole('TUTOR'),
  validate({ body: gradeBody }),
  controller.gradeBooking,
);

router.post(
  '/:id/review',
  requireRole('STUDENT'),
  validate({ body: reviewBody }),
  controller.reviewBooking,
);

export default router;
