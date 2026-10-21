import { Request, Response } from 'express';
import * as bookingService from './service';

export async function createBooking(req: Request, res: Response) {
  const result = await bookingService.createBooking(req.user!.sub, req.body);
  res.status(201).json(result);
}

export async function listBookings(req: Request, res: Response) {
  const result = await bookingService.listBookings(
    req.user!.sub,
    req.user!.role,
    req.query as any,
  );
  res.status(200).json(result);
}

export async function getBooking(req: Request, res: Response) {
  const result = await bookingService.getBooking(
    req.user!.sub,
    req.user!.role,
    req.params.id as string,
  );
  res.status(200).json(result);
}

export async function acceptBooking(req: Request, res: Response) {
  const result = await bookingService.acceptBooking(req.user!.sub, req.params.id as string);
  res.status(200).json(result);
}

export async function rejectBooking(req: Request, res: Response) {
  const result = await bookingService.rejectBooking(
    req.user!.sub,
    req.params.id as string,
    req.body.reason,
  );
  res.status(200).json(result);
}

export async function cancelBooking(req: Request, res: Response) {
  const result = await bookingService.cancelBooking(
    req.user!.sub,
    req.params.id as string,
  );
  res.status(200).json(result);
}

export async function gradeBooking(req: Request, res: Response) {
  const result = await bookingService.gradeBooking(
    req.user!.sub,
    req.params.id as string,
    req.body,
  );
  res.status(200).json(result);
}

export async function reviewBooking(req: Request, res: Response) {
  await bookingService.reviewBooking(req.user!.sub, req.params.id as string, req.body);
  res.status(200).json({ message: 'Review submitted' });
}
