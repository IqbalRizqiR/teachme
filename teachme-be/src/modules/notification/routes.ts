import { Router, Request, Response } from 'express';
import { authenticate } from '../../middleware/auth';
import * as notificationService from './service';

const router = Router();

router.use(authenticate);

router.get('/', async (req: Request, res: Response) => {
  const cursor = req.query.cursor as string | undefined;
  const limit = req.query.limit ? Number(req.query.limit) : undefined;
  const [result, unreadCount] = await Promise.all([
    notificationService.getNotifications(req.user!.sub, cursor, limit),
    notificationService.getUnreadCount(req.user!.sub),
  ]);
  res.json({ ...result, unreadCount });
});

router.post('/:id/read', async (req: Request, res: Response) => {
  const result = await notificationService.markRead(req.user!.sub, req.params.id as string);
  res.json(result);
});

router.post('/read-all', async (req: Request, res: Response) => {
  await notificationService.markAllRead(req.user!.sub);
  res.status(204).end();
});

export default router;
