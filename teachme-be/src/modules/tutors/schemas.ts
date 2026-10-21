import { z } from 'zod';

export const searchTutorsQuery = z.object({
  q: z.string().optional(),
  subjectId: z.string().optional(),
  minPrice: z.coerce.number().optional(),
  maxPrice: z.coerce.number().optional(),
  minRating: z.coerce.number().optional(),
  sort: z
    .enum(['rating', 'price_asc', 'price_desc', 'newest'])
    .optional(),
  cursor: z.string().optional(),
  limit: z.coerce.number().default(20),
});

export type SearchTutorsQuery = z.infer<typeof searchTutorsQuery>;

export const updateProfileBody = z.object({
  bio: z.string().nullish(),
  subjects: z
    .array(
      z.object({
        subjectId: z.string(),
        priceIdr: z.number(),
      }),
    )
    .optional(),
});

export type UpdateProfileBody = z.infer<typeof updateProfileBody>;

export const slotsQuery = z.object({
  from: z.string().datetime(),
  to: z.string().datetime(),
});

export type SlotsQuery = z.infer<typeof slotsQuery>;
