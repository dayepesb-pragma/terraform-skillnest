"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MessageProcessor = void 0;
const messageSchema_1 = require("../../domain/schemas/messageSchema");
class MessageProcessor {
    async validateMessage(messageBody) {
        const validation = messageSchema_1.messageSchema.validate(messageBody);
        if (validation.error) {
            throw new Error(`Validation error: ${validation.error.message}`);
        }
        return validation.value;
    }
    async processMessage(message) {
        // Here you can add business logic for processing the message
        console.log('Processing validated message:', message);
    }
}
exports.MessageProcessor = MessageProcessor;
