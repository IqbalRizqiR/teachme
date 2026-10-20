import { Prisma } from '@prisma/client';
import db from '../../lib/db';
import { notFound } from '../../lib/errors';

export async function getNotifications(
  userId: string,
  cursor?: string,
  limit = 20,
) {
  const take = limit + 1;

  const notifications = await db.notification.findMany({
    where: { userId },
    orderBy: { createdAt: 'desc' },
    take,
    ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
  });

  const hasMore = notifications.length > limit;
  const items = hasMore ? notifications.slice(0, limit) : notifications;
  const nextCursor = hasMore ? items[items.length - 1].id : undefined;

  return { items, nextCursor };
}

export async function getUnreadCount(userId: string) {
  return db.notification.count({
    where: { userId, readAt: null },
  });
}

export async function markRead(userId: string, notificationId: string) {
  const notification = await db.notification.findFirst({
    where: { id: notificationId, userId },
  });
  if (!notification) throw notFound('Notification not found');

  return db.notification.update({
    where: { id: notificationId },
    data: { readAt: new Date() },
  });
}

export async function markAllRead(userId: string) {
  return db.notification.updateMany({
    where: { userId, readAt: null },
    data: { readAt: new Date() },
  });
}

export async function createNotification(
  userId: string,
  type: string,
  title: string,
  body: string,
  data?: Record<string, unknown>,
) {
  return db.notification.create({
    data: {
      userId,
      type,
      title,
      body,
      ...(data !== undefined && { data: data as Prisma.InputJsonValue }),
    },
  });
}
