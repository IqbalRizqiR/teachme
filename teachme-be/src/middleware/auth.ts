import { Request, Response, NextFunction } from 'express';
import { verifyAccessToken } from '../lib/security';
import { unauthenticated } from '../lib/errors';

declare global {
  namespace Express {
    interface Request {
      user?: { sub: string; role: string };
    }
  }
}

export function authenticate(req: Request, _res: Response, next: NextFunction): void {
  const header = req.headers.authorization;

  if (!header || !header.startsWith('Bearer ')) {
    throw unauthenticated();
  }

  const token = header.slice(7);

  try {
    req.user = verifyAccessToken(token);
  } catch {
    throw unauthenticated();
  }

  next();
}
