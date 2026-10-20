export class AppError extends Error {
  readonly code: string;
  readonly statusCode: number;
  readonly fields?: Record<string, string>;

  constructor(
    code: string,
    statusCode: number,
    message: string,
    fields?: Record<string, string>,
  ) {
    super(message);
    this.code = code;
    this.statusCode = statusCode;
    this.fields = fields;
    Object.setPrototypeOf(this, AppError.prototype);
  }
}

export const notFound = (msg = 'Resource not found') =>
  new AppError('NOT_FOUND', 404, msg);

export const forbidden = (msg = 'Forbidden') =>
  new AppError('FORBIDDEN', 403, msg);

export const conflict = (code: string, msg: string) =>
  new AppError(code, 409, msg);

export const badRequest = (
  code: string,
  msg: string,
  fields?: Record<string, string>,
) => new AppError(code, 400, msg, fields);

export const unauthenticated = (msg = 'Unauthenticated') =>
  new AppError('UNAUTHENTICATED', 401, msg);
