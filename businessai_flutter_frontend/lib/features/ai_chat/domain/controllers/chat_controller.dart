import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/models/chat_message.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  TextEditingController textController = TextEditingController(); // ✅ Updated

  @override
  void onInit() {
    super.onInit();
    // Initialize with a welcome message
    messages.add(ChatMessage(
      text: "Hello! I'm your AI assistant. How can I help you with your business today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  void sendMessage() {
    if (textController.text.trim().isEmpty) return;

    messages.add(ChatMessage(
      text: textController.text, // ✅ Use the textController
      isUser: true,
      timestamp: DateTime.now(),
    ));

    // Clear input field
    textController.clear(); // ✅ Proper way to clear input

    // Simulate AI response
    Future.delayed(Duration(seconds: 1), () {
      messages.add(ChatMessage(
        text: "I'm processing your request. How else can I assist?",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }
}
