import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:businessai_flutter_frontend/features/ai_chat/domain/controllers/chat_controller.dart';
import '../widgets/chat_bubble.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'AI Assistant',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return Expanded(
      child: Obx(() => ListView.builder(
            reverse: false, // ✅ Fix: Messages will appear in correct order
            itemCount: chatController.messages.length,
            itemBuilder: (context, index) {
              final message = chatController.messages[index]; // ✅ Correct order
              return ChatBubble(message: message);
            },
          )),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {
              // Implement voice input
            },
          ),
          Expanded(
            child: TextField(
              controller: chatController.textController, // ✅ Fix: Use textController
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              minLines: 1,
              maxLines: 5,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.blue,
            onPressed: chatController.sendMessage,
          ),
        ],
      ),
    );
  }
}
