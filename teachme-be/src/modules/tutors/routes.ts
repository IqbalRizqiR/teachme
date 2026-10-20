import { Router } from 'express';
import { authenticate } from '../../middleware/auth';
import { requireRole } from '../../middleware/requireRole';
import { validate } from '../../middleware/validate';
import { searchTutorsQuery, slotsQuery, updateProfileBody } from './schemas';
import * as ctrl from './controller';

const router = Router();

router.get(
  '/',
  authenticate,
  requireRole('STUDENT'),
  validate({ query: searchTutorsQuery }),
  ctrl.searchTutors,
);

router.get('/:id', authenticate, ctrl.getTutorDetail);

router.get(
  '/:id/slots',
  authenticate,
  validate({ query: slotsQuery }),
  ctrl.getTutorSlots,
);

router.get('/:id/reviews', authenticate, ctrl.getTutorReviews);

router.put(
  '/tutor/profile',
  authenticate,
  requireRole('TUTOR'),
  validate({ body: updateProfileBody }),
  ctrl.updateProfile,
);

export default router;
