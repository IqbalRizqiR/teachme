import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import pinoHttp from 'pino-http';
import logger from './lib/logger';
import { requestId } from './middleware/requestId';
import { generalLimiter, authLimiter } from './middleware/rateLimit';
import { errorHandler } from './middleware/errorHandler';
import { env } from './config/env';

import authRoutes from './modules/auth/routes';
import subjectRoutes from './modules/subjects/routes';
import tutorRoutes from './modules/tutors/routes';
import scheduleRoutes from './modules/schedule/routes';
import bookingRoutes from './modules/booking/routes';
import paymentRoutes from './modules/payment/routes';
import progressRoutes from './modules/progress/routes';
import notificationRoutes from './modules/notification/routes';
import dashboardRoutes from './modules/dashboard/routes';
import userRoutes from './modules/users/routes';

const app = express();

app.use(helmet());
app.use(cors());
app.use(express.json({ limit: '1mb' }));
app.use(pinoHttp({ logger }));
app.use(requestId);
app.use(generalLimiter);

app.use('/api/v1/auth', authLimiter, authRoutes);
app.use('/api/v1/subjects', subjectRoutes);
app.use('/api/v1/tutors', tutorRoutes);
app.use('/api/v1/tutor', scheduleRoutes);
app.use('/api/v1/tutor', dashboardRoutes);
app.use('/api/v1/bookings', bookingRoutes);
app.use('/api/v1', paymentRoutes);
app.use('/api/v1', progressRoutes);
app.use('/api/v1/notifications', notificationRoutes);
app.use('/api/v1', userRoutes);

if (env.NODE_ENV !== 'production') {
  app.use('/api/v1/dev/payments', paymentRoutes);
}

app.get('/api/v1/health', (_req, res) => {
  res.json({ status: 'ok' });
});

app.use((_req, res) => {
  res.status(404).json({
    error: { code: 'NOT_FOUND', message: 'Route not found' },
  });
});

app.use(errorHandler);

export default app;
