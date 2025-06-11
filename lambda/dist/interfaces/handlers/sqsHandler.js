"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = void 0;
const MessageProcessor_1 = require("../../application/useCases/MessageProcessor");
class LambdaHandler {
    constructor() {
        this.messageProcessor = new MessageProcessor_1.MessageProcessor();
    }
    async processSQSRecord(record) {
        try {
            const messageBody = JSON.parse(record.body);
            // Validate and process the message
            const validatedMessage = await this.messageProcessor.validateMessage(messageBody);
            await this.messageProcessor.processMessage(validatedMessage);
            console.log('Message processed successfully:', record.messageId);
        }
        catch (error) {
            console.error('Error processing message:', record.messageId, error);
            throw error; // This will send the message to DLQ if configured
        }
    }
    async handler(event, context) {
        console.log('Processing SQS event:', JSON.stringify(event, null, 2));
        await Promise.all(event.Records.map((record) => this.processSQSRecord(record)));
    }
}
const lambdaHandler = new LambdaHandler();
exports.handler = lambdaHandler.handler.bind(lambdaHandler);
