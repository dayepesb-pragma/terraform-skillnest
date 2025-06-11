"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handleMessage = void 0;
const lambdaHandler_1 = require("./infrastructure/handlers/lambdaHandler");
const handler = new lambdaHandler_1.LambdaHandler();
const handleMessage = async (event, context) => {
    return handler.handle(event, context);
};
exports.handleMessage = handleMessage;
