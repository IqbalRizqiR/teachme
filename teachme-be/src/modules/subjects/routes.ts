import { Router, Request, Response } from 'express';
import { authenticate } from '../../middleware/auth';
import db from '../../lib/db';

const router = Router();

router.get('/', authenticate, async (_req: Request, res: Response) => {
  const subjects = await db.subject.findMany({
    orderBy: { name: 'asc' },
  });
  res.json(subjects);
});

export default router;
