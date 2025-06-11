import { Context, SQSEvent, SQSHandler, SQSRecord } from 'aws-lambda';
import { MessageProcessor } from '../../application/useCases/MessageProcessor';

class LambdaHandler {
  private messageProcessor: MessageProcessor;

  constructor() {
    this.messageProcessor = new MessageProcessor();
  }

  private async processSQSRecord(record: SQSRecord): Promise<void> {
    try {
      const messageBody = JSON.parse(record.body);

      // Validate and process the message
      const validatedMessage = await this.messageProcessor.validateMessage(messageBody);
      await this.messageProcessor.processMessage(validatedMessage);

      console.log('Message processed successfully:', record.messageId);
    } catch (error) {
      console.error('Error processing message:', record.messageId, error);
      throw error; // This will send the message to DLQ if configured
    }
  }

  public async handler(event: SQSEvent, context: Context): Promise<void> {
    console.log('Processing SQS event:', JSON.stringify(event, null, 2));

    await Promise.all(
      event.Records.map((record: any) => this.processSQSRecord(record))
    );
  }
}

const lambdaHandler = new LambdaHandler();
export const handler: SQSHandler = lambdaHandler.handler.bind(lambdaHandler);
