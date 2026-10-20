import { z } from 'zod';

export const registerSchema = {
  body: z.object({
    name: z.string().min(1),
    email: z.string().email(),
    password: z
      .string()
      .min(8)
      .regex(/^(?=.*[a-zA-Z])(?=.*\d)/, 'Password must contain a letter and a number'),
    role: z.enum(['STUDENT', 'TUTOR']),
  }),
};

export const loginSchema = {
  body: z.object({
    email: z.string().email(),
    password: z.string().min(1),
  }),
};

export const refreshSchema = {
  body: z.object({
    refreshToken: z.string().min(1),
  }),
};
