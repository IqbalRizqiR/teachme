import db from '../../lib/db';

export async function updateUser(
  userId: string,
  data: { name?: string; timezone?: string },
) {
  return db.user.update({
    where: { id: userId },
    data: {
      ...(data.name !== undefined && { name: data.name }),
      ...(data.timezone !== undefined && { timezone: data.timezone }),
    },
  });
}

export async function updateAvatar(userId: string, filePath: string) {
  return db.user.update({
    where: { id: userId },
    data: { avatarPath: filePath },
  });
}
