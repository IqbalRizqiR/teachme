import pino from 'pino';

const isDev = process.env.NODE_ENV === 'development';

const logger = pino(
  isDev
    ? {
        level: 'debug',
        transport: { target: 'pino-pretty' },
      }
    : { level: 'info' },
);

export default logger;
