import { Request, Response } from 'express';
import * as paymentService from './service';

export async function initiatePayment(req: Request, res: Response) {
  const result = await paymentService.initiatePayment(req.user!.sub, req.params.id as string);
  res.status(200).json(result);
}

export async function settlePayment(req: Request, res: Response) {
  const result = await paymentService.settlePayment(req.params.orderId as string);
  res.status(200).json(result);
}
