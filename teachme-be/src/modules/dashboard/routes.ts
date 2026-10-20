import { Router, Request, Response } from 'express';
import { authenticate } from '../../middleware/auth';
import { requireRole } from '../../middleware/requireRole';
import * as dashboardService from './service';

const router = Router();

router.use(authenticate, requireRole('TUTOR'));

router.get('/dashboard', async (req: Request, res: Response) => {
  const result = await dashboardService.getTutorDashboard(req.user!.sub);
  res.json(result);
});

router.get('/earnings', async (req: Request, res: Response) => {
  const cursor = req.query.cursor as string | undefined;
  const limit = req.query.limit ? Number(req.query.limit) : undefined;
  const result = await dashboardService.getTutorEarnings(
    req.user!.sub,
    cursor,
    limit,
  );
  res.json(result);
});

export default router;
