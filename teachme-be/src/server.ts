import app from './app';
import { env } from './config/env';
import logger from './lib/logger';
import { startScheduler } from './jobs/scheduler';
import db from './lib/db';

const server = app.listen(env.PORT, env.HOST, () => {
  logger.info(`Server started on ${env.HOST}:${env.PORT}`);
});

startScheduler();

function gracefulShutdown(signal: string) {
  logger.info(`${signal} received, shutting down`);
  server.close(async () => {
    await db.$disconnect();
    process.exit(0);
  });
}

process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
process.on('SIGINT', () => gracefulShutdown('SIGINT'));
