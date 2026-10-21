import { PrismaClient } from '@prisma/client';

const db = new PrismaClient({
  transactionOptions: {
    maxWait: 15000,
    timeout: 30000,
  },
});

export default db;