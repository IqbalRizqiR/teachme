import { Request, Response, NextFunction } from 'express';
import { z, ZodError } from 'zod';
import { AppError } from '../lib/errors';

interface ValidationSchema {
  body?: z.ZodTypeAny;
  params?: z.ZodTypeAny;
  query?: z.ZodTypeAny;
}

function redefine(req: Request, key: 'params' | 'query', value: unknown): void {
  Object.defineProperty(req, key, {
    value,
    writable: true,
    enumerable: true,
    configurable: true,
  });
}

export function validate(schema: ValidationSchema) {
  return (req: Request, _res: Response, next: NextFunction): void => {
    try {
      if (schema.body) {
        req.body = schema.body.parse(req.body);
      }
      if (schema.params) {
        redefine(req, 'params', schema.params.parse(req.params));
      }
      if (schema.query) {
        redefine(req, 'query', schema.query.parse(req.query));
      }
    } catch (err) {
      if (err instanceof ZodError) {
        const fields: Record<string, string> = {};
        for (const issue of err.issues) {
          fields[issue.path.join('.')] = issue.message;
        }
        throw new AppError('VALIDATION_ERROR', 400, 'Validation failed', fields);
      }
      throw err;
    }

    next();
  };
}