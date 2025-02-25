import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ai_chat/domain/controllers/chat_controller.dart';

class AIChatAssistant extends StatelessWidget {
  final ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildHeader(context),
          Divider(),
          _buildChatMessages(),
          Divider(),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('AI Assistant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
      ],
    );
  }

  Widget _buildChatMessages() {
    return Expanded(
      child: Obx(() => ListView.builder(
            itemCount: chatController.messages.length,
            itemBuilder: (context, index) {
              final message = chatController.messages[index];
              return _buildMessageBubble(message);
            },
          )),
    );
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    bool isUser = message['role'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message['text'] ?? "",
          style: TextStyle(color: isUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: chatController.textController,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
        Obx(() => chatController.isLoading.value
            ? CircularProgressIndicator()
            : IconButton(icon: Icon(Icons.send), color: Colors.blue, onPressed: chatController.sendMessage)),
      ],
    );
  }
}
