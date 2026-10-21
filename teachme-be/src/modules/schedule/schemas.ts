import { z } from 'zod';

export const createRuleBody = z.object({
  weekday: z.number().int().min(0).max(6),
  startMinute: z.number().int().min(0).max(1439),
  endMinute: z.number().int().min(1).max(1440),
});

export type CreateRuleBody = z.infer<typeof createRuleBody>;

export const updateRuleBody = z.object({
  weekday: z.number().int().min(0).max(6).optional(),
  startMinute: z.number().int().min(0).max(1439).optional(),
  endMinute: z.number().int().min(1).max(1440).optional(),
});

export type UpdateRuleBody = z.infer<typeof updateRuleBody>;

export const createExceptionBody = z.object({
  date: z.string(),
  reason: z.string().nullish(),
});

export type CreateExceptionBody = z.infer<typeof createExceptionBody>;
