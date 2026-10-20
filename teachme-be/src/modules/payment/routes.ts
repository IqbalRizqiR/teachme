import { Router } from 'express';
import * as controller from './controller';
import { authenticate } from '../../middleware/auth';
import { requireRole } from '../../middleware/requireRole';

const router = Router();

router.post(
  '/bookings/:id/pay',
  authenticate,
  requireRole('STUDENT'),
  controller.initiatePayment,
);

router.post(
  '/dev/payments/:orderId/settle',
  controller.settlePayment,
);

export default router;
