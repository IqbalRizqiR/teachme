import { Router } from 'express';
import multer from 'multer';
import path from 'path';
import { authenticate } from '../../middleware/auth';
import { updateAvatar } from './service';
import { env } from '../../config/env';
import { Request, Response } from 'express';

const upload = multer({
  dest: path.join(env.STORAGE_DIR, 'avatars'),
});

const router = Router();

router.post(
  '/me/avatar',
  authenticate,
  upload.single('avatar'),
  async (req: Request, res: Response) => {
    const file = req.file;
    if (!file) {
      res.status(400).json({ message: 'No file uploaded' });
      return;
    }

    const user = await updateAvatar(req.user!.sub, file.path);
    res.status(200).json({ avatarPath: user.avatarPath });
  },
);

export default router;
