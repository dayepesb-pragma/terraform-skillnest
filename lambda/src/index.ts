import { Context, SQSEvent } from 'aws-lambda';
import { LambdaHandler } from './infrastructure/handlers/lambdaHandler';

const handler = new LambdaHandler();
export const handleMessage = async (event: SQSEvent, context: Context) => {
  return handler.handle(event, context);
};
