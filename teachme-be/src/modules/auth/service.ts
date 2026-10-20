import db from '../../lib/db';
import {
  hashPassword,
  verifyPassword,
  generateAccessToken,
  generateRefreshToken,
  hashToken,
} from '../../lib/security';
import { AppError, unauthenticated } from '../../lib/errors';
import { env } from '../../config/env';
import { addDuration, parseDuration } from '../../lib/time';

function buildTokenResponse(
  accessToken: string,
  refreshToken: string,
  user: { id: string; name: string; email: string; role: string; avatarPath: string | null },
) {
  return {
    accessToken,
    refreshToken,
    expiresIn: parseDuration(env.ACCESS_TOKEN_TTL) / 1000,
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      avatarUrl: null,
    },
  };
}

async function createRefreshTokenForUser(userId: string) {
  const raw = generateRefreshToken();
  const hashed = hashToken(raw);
  const expiresAt = addDuration(new Date(), env.REFRESH_TOKEN_TTL);

  await db.refreshToken.create({
    data: {
      userId,
      tokenHash: hashed,
      expiresAt,
    },
  });

  return raw;
}

export async function register(input: {
  name: string;
  email: string;
  password: string;
  role: 'STUDENT' | 'TUTOR';
}) {
  const existing = await db.user.findUnique({ where: { email: input.email } });
  if (existing) {
    throw new AppError('EMAIL_TAKEN', 409, 'Email is already registered');
  }

  const passwordHash = await hashPassword(input.password);

  const user = await db.user.create({
    data: {
      email: input.email,
      passwordHash,
      name: input.name,
      role: input.role,
      ...(input.role === 'STUDENT'
        ? { student: { create: {} } }
        : { tutor: { create: {} } }),
    },
  });

  const accessToken = generateAccessToken({ sub: user.id, role: user.role });
  const refreshToken = await createRefreshTokenForUser(user.id);

  return buildTokenResponse(accessToken, refreshToken, user);
}

export async function login(input: { email: string; password: string }) {
  const user = await db.user.findUnique({ where: { email: input.email } });
  if (!user) {
    throw new AppError('INVALID_CREDENTIALS', 401, 'Invalid email or password');
  }

  const valid = await verifyPassword(user.passwordHash, input.password);
  if (!valid) {
    throw new AppError('INVALID_CREDENTIALS', 401, 'Invalid email or password');
  }

  const accessToken = generateAccessToken({ sub: user.id, role: user.role });
  const refreshToken = await createRefreshTokenForUser(user.id);

  return buildTokenResponse(accessToken, refreshToken, user);
}

export async function refresh(token: string) {
  const hashed = hashToken(token);

  const stored = await db.refreshToken.findUnique({
    where: { tokenHash: hashed },
    include: { user: true },
  });

  if (!stored) {
    throw unauthenticated();
  }

  if (stored.revokedAt) {
    await db.refreshToken.updateMany({
      where: { userId: stored.userId, revokedAt: null },
      data: { revokedAt: new Date() },
    });
    throw unauthenticated();
  }

  if (stored.expiresAt < new Date()) {
    throw unauthenticated();
  }

  await db.refreshToken.update({
    where: { id: stored.id },
    data: { revokedAt: new Date() },
  });

  const accessToken = generateAccessToken({
    sub: stored.user.id,
    role: stored.user.role,
  });
  const newRefreshToken = await createRefreshTokenForUser(stored.userId);

  return buildTokenResponse(accessToken, newRefreshToken, stored.user);
}

export async function logout(token: string) {
  const hashed = hashToken(token);

  await db.refreshToken.updateMany({
    where: { tokenHash: hashed, revokedAt: null },
    data: { revokedAt: new Date() },
  });
}

export async function getMe(userId: string) {
  const user = await db.user.findUniqueOrThrow({
    where: { id: userId },
    include: {
      student: true,
      tutor: true,
    },
  });

  return user;
}
