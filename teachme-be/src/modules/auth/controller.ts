import { Request, Response } from 'express';
import * as authService from './service';

export async function register(req: Request, res: Response) {
  const result = await authService.register(req.body);
  res.status(201).json(result);
}

export async function login(req: Request, res: Response) {
  const result = await authService.login(req.body);
  res.status(200).json(result);
}

export async function refresh(req: Request, res: Response) {
  const result = await authService.refresh(req.body.refreshToken);
  res.status(200).json(result);
}

export async function logout(req: Request, res: Response) {
  await authService.logout(req.body.refreshToken);
  res.status(204).send();
}

export async function getMe(req: Request, res: Response) {
  const user = await authService.getMe(req.user!.sub);
  res.status(200).json(user);
}

export async function updateMe(req: Request, res: Response) {
  const { updateUser } = await import('../users/service');
  const user = await updateUser(req.user!.sub, req.body);
  res.status(200).json(user);
}
