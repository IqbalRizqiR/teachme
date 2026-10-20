import { Request, Response, NextFunction } from 'express';
import { forbidden, unauthenticated } from '../lib/errors';

export function requireRole(...roles: string[]) {
  return (req: Request, _res: Response, next: NextFunction): void => {
    if (!req.user) {
      throw unauthenticated();
    }

    if (!roles.includes(req.user.role)) {
      throw forbidden();
    }

    next();
  };
}
