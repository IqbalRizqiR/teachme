import { z } from 'zod';

export const createBookingBody = z.object({
  slotId: z.string(),
  subjectId: z.string(),
  note: z.string().optional(),
});

export type CreateBookingBody = z.infer<typeof createBookingBody>;

export const rejectBody = z.object({
  reason: z.string().optional(),
});

export type RejectBody = z.infer<typeof rejectBody>;

export const gradeBody = z.object({
  score: z.number().min(0).max(100),
  note: z.string().min(1).max(1000),
});

export type GradeBody = z.infer<typeof gradeBody>;

export const reviewBody = z.object({
  rating: z.number().int().min(1).max(5),
  comment: z.string().optional(),
});

export type ReviewBody = z.infer<typeof reviewBody>;

export const listBookingsQuery = z.object({
  status: z.string().optional(),
  cursor: z.string().optional(),
  limit: z.coerce.number().default(20),
});

export type ListBookingsQuery = z.infer<typeof listBookingsQuery>;
