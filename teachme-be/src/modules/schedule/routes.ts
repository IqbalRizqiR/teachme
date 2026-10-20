import { Router } from 'express';
import { authenticate } from '../../middleware/auth';
import { requireRole } from '../../middleware/requireRole';
import { validate } from '../../middleware/validate';
import { createRuleBody, updateRuleBody, createExceptionBody } from './schemas';
import * as ctrl from './controller';

const router = Router();

router.use(authenticate, requireRole('TUTOR'));

router.get('/availability-rules', ctrl.getRules);

router.post(
  '/availability-rules',
  validate({ body: createRuleBody }),
  ctrl.createRule,
);

router.patch(
  '/availability-rules/:id',
  validate({ body: updateRuleBody }),
  ctrl.updateRule,
);

router.delete('/availability-rules/:id', ctrl.deleteRule);

router.get('/availability-exceptions', ctrl.getExceptions);

router.post(
  '/availability-exceptions',
  validate({ body: createExceptionBody }),
  ctrl.createException,
);

router.delete('/availability-exceptions/:id', ctrl.deleteException);

router.get('/slots', ctrl.getSlots);

export default router;
