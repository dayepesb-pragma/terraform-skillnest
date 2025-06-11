import { Message } from '../../domain/models/Message';
import { messageSchema } from '../../domain/schemas/messageSchema';


export class MessageProcessor {
  public async validateMessage(messageBody: unknown): Promise<Message> {
    const validation = messageSchema.validate(messageBody);

    if (validation.error) {
      throw new Error(`Validation error: ${validation.error.message}`);
    }

    return validation.value;
  }

  public async processMessage(message: Message): Promise<void> {
    // Here you can add business logic for processing the message
    console.log('Processing validated message:', message);
  }
}
