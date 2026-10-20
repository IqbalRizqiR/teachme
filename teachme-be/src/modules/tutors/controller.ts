import { Request, Response } from 'express';
import * as tutorService from './service';
import type { SearchTutorsQuery, SlotsQuery, UpdateProfileBody } from './schemas';

export async function searchTutors(req: Request, res: Response) {
  const result = await tutorService.searchTutors(req.query as unknown as SearchTutorsQuery);
  res.json(result);
}

export async function getTutorDetail(req: Request, res: Response) {
  const result = await tutorService.getTutorDetail(req.params.id as string);
  res.json(result);
}

export async function getTutorSlots(req: Request, res: Response) {
  const query = req.query as unknown as SlotsQuery;
  const result = await tutorService.getTutorSlots(
    req.params.id as string,
    new Date(query.from),
    new Date(query.to),
  );
  res.json(result);
}

export async function getTutorReviews(req: Request, res: Response) {
  const cursor = req.query.cursor as string | undefined;
  const limit = req.query.limit ? Number(req.query.limit) : undefined;
  const result = await tutorService.getTutorReviews(req.params.id as string, cursor, limit);
  res.json(result);
}

export async function updateProfile(req: Request, res: Response) {
  const result = await tutorService.updateProfile(
    req.user!.sub,
    req.body as UpdateProfileBody,
  );
  res.json(result);
}
