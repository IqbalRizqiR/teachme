import { BookingStatus } from '@prisma/client';
import { AppError } from '../../lib/errors';

const transitions: Record<string, BookingStatus[]> = {
  PENDING: ['ACCEPTED', 'REJECTED', 'EXPIRED', 'CANCELLED'],
  ACCEPTED: ['PAID', 'EXPIRED', 'CANCELLED'],
  PAID: ['COMPLETED'],
};

export function assertTransition(from: BookingStatus, to: BookingStatus): void {
  const allowed = transitions[from];
  if (!allowed || !allowed.includes(to)) {
    throw new AppError(
      'INVALID_TRANSITION',
      409,
      `Cannot transition from ${from} to ${to}`,
    );
  }
}
