import Joi from 'joi';
import { Message } from '../models/Message';

export const messageSchema = Joi.object<Message>({
  phone: Joi.string().required(),
  title: Joi.string().required(),
  message: Joi.string().required(),
});
