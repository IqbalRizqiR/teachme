import { Request, Response } from 'express';
import db from '../../lib/db';
import { notFound } from '../../lib/errors';
import * as scheduleService from './service';
import type { CreateRuleBody, UpdateRuleBody, CreateExceptionBody } from './schemas';

async function getTutorProfileId(userId: string) {
  const tutor = await db.tutorProfile.findUnique({ where: { userId } });
  if (!tutor) throw notFound('Tutor profile not found');
  return tutor.id;
}

export async function getRules(req: Request, res: Response) {
  const profileId = await getTutorProfileId(req.user!.sub);
  const result = await scheduleService.getRules(profileId);
  res.json(result);
}

export async function createRule(req: Request, res: Response) {
  const profileId = await getTutorProfileId(req.user!.sub);
  const result = await scheduleService.createRule(profileId, req.body as CreateRuleBody);
  res.status(201).json(result);
}

export async function updateRule(req: Request, res: Response) {
  const profileId = await getTutorProfileId(req.user!.sub);
  const result = await scheduleService.updateRule(
    req.params.id as string,
    profileId,
    req.body as UpdateRuleBody,
  );
  res.json(result);
}

export async function deleteRule(req: Request, res: Response) {
  const profileId = await getTutorProfileId(req.user!.sub);
  await scheduleService.deleteRule(req.params.id as string, profileId);
  res.status(204).end();
}

export async function getExceptions(req: Request, res: Response) {
  const profileId = await getTutorProfileId(req.user!.sub);
  const result = await scheduleService.getExceptions(profileId);
  res.json(result);
}

export async function createException(req: Request, res: Response) {
  const profileId = await getTutorProfileId(req.user!.sub);
  const result = await scheduleService.createException(
    profileId,
    req.body as CreateExceptionBody,
  );
  res.status(201).json(result);
}

export async function deleteException(req: Request, res: Response) {
  const profileId = await getTutorProfileId(req.user!.sub);
  await scheduleService.deleteException(req.params.id as string, profileId);
  res.status(204).end();
}

export async function getSlots(req: Request, res: Response) {
  const profileId = await getTutorProfileId(req.user!.sub);
  const result = await scheduleService.getTutorSlots(profileId);
  res.json(result);
}
