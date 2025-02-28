import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../ai_chat/domain/controllers/chat_controller.dart';
import '../widgets/model_selection.dart';

class EnhancedAIChatAssistant extends StatefulWidget {
  @override
  _EnhancedAIChatAssistantState createState() => _EnhancedAIChatAssistantState();
}

class _EnhancedAIChatAssistantState extends State<EnhancedAIChatAssistant> with SingleTickerProviderStateMixin {
  final ChatController chatController = Get.find<ChatController>();
  late AnimationController _animationController;
  late Animation<double> _animation;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToBottom = false;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    // Handle scroll to determine when to show scroll-to-bottom button
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent - _scrollController.offset > 200) {
        if (!_showScrollToBottom) {
          setState(() => _showScrollToBottom = true);
        }
      } else {
        if (_showScrollToBottom) {
          setState(() => _showScrollToBottom = false);
        }
      }
    });
    
    // Scroll to bottom when new messages arrive
    chatController.messages.listen((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Icon(Icons.assistant, color: Theme.of(context).primaryColor),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Assistant', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Obx(() => Text(
                  chatController.isLoading.value ? 'Typing...' : 'Online',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                )),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'New conversation',
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('New Conversation'),
                  content: Text('Are you sure you want to start a new conversation? All current messages will be cleared.'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Get.back(),
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () {
                        chatController.messages.clear();
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download, color: Colors.grey[700]),
                    SizedBox(width: 8),
                    Text('Export chat'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'theme',
                child: Row(
                  children: [
                    Icon(Icons.dark_mode, color: Colors.grey[700]),
                    SizedBox(width: 8),
                    Text('Toggle theme'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey[700]),
                    SizedBox(width: 8),
                    Text('Settings'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'export') {
                // Implement export functionality
              } else if (value == 'theme') {
                Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              } else if (value == 'settings') {
                // Navigate to settings
              }
            },
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            buildModelSelection(),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: buildChatMessages(),
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
      floatingActionButton: _showScrollToBottom
          ? FloatingActionButton(
              mini: true,
              child: Icon(Icons.arrow_downward),
              onPressed: _scrollToBottom,
            )
          : null,
    );
  }



  Widget buildChatMessages() {
    return Obx(() => chatController.messages.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            controller: _scrollController,
            itemCount: chatController.messages.length,
            padding: EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) {
              final message = chatController.messages[index];
              return _buildMessageBubble(message, index);
            },
          ));
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Start a conversation with your AI Assistant',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Text(
            'Try asking:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          _buildSuggestionChip('Explain quantum computing'),
          _buildSuggestionChip('Write a poem about space'),
          _buildSuggestionChip('Help me plan my day'),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return GestureDetector(
      onTap: () {
        chatController.textController.text = text;
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, String> message, int index) {
    bool isUser = message['role'] == 'user';
    bool isLastMessage = index == chatController.messages.length - 1;
    bool showTimestamp = index == 0 || 
        DateTime.parse(message['timestamp'] ?? DateTime.now().toString()).difference(
            DateTime.parse(chatController.messages[index - 1]['timestamp'] ?? DateTime.now().toString())
        ).inMinutes > 5;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showTimestamp)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              _formatMessageTime(message['timestamp'] ?? ''),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        Row(
          mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) ...[
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                radius: 16,
                child: Icon(Icons.assistant, size: 16, color: Theme.of(context).primaryColor),
              ),
              SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  left: isUser ? 50 : 0,
                  right: isUser ? 0 : 50,
                ),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUser 
                      ? Theme.of(context).primaryColor 
                      : Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[800] 
                          : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16).copyWith(
                    bottomRight: isUser ? Radius.circular(0) : Radius.circular(16),
                    bottomLeft: isUser ? Radius.circular(16) : Radius.circular(0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      message['text'] ?? "",
                      style: TextStyle(
                        color: isUser ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _formatTime(message['timestamp'] ?? ''),
                          style: TextStyle(
                            fontSize: 10,
                            color: isUser ? Colors.white.withOpacity(0.7) : Colors.grey[600],
                          ),
                        ),
                        if (!isUser) ...[
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: message['text'] ?? ""));
                              Get.snackbar(
                                'Copied', 
                                'Message copied to clipboard',
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.all(16),
                              );
                            },
                            child: Icon(
                              Icons.copy, 
                              size: 14, 
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isUser) ...[
              SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 16,
                child: Icon(Icons.person, size: 16, color: Colors.grey[700]),
              ),
            ],
          ],
        ),
        if (isLastMessage && chatController.isLoading.value)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 40),
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Generating response...',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey[800] 
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.grey[600]),
                        onPressed: () {
                          _showAttachmentOptions();
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: chatController.textController,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Message',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && !_animationController.isCompleted) {
                              _animationController.forward();
                            } else if (value.isEmpty && _animationController.isCompleted) {
                              _animationController.reverse();
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.mic, color: Colors.grey[600]),
                        onPressed: () {
                          // Implement voice input
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              Obx(() => chatController.isLoading.value
                  ? Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  : AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation.value * 0.5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                _animation.value > 0.5 ? Icons.send : Icons.mic,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (chatController.textController.text.isNotEmpty) {
                                  chatController.sendMessage();
                                } else {
                                  // Implement voice input
                                }
                              },
                            ),
                          ),
                        );
                      },
                    )),
            ],
          ),
          SizedBox(height: 8),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildActionChip(Icons.image, 'Create image'),
          _buildActionChip(Icons.text_fields, 'Summarize'),
          _buildActionChip(Icons.code, 'Write code'),
          _buildActionChip(Icons.edit, 'Proofread'),
          _buildActionChip(Icons.lightbulb_outline, 'Ideas'),
          _buildActionChip(Icons.translate, 'Translate'),
        ],
      ),
    );
  }

  Widget _buildActionChip(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        chatController.textController.text = "${chatController.textController.text} [$label]".trim();
        chatController.textController.selection = TextSelection.fromPosition(
          TextPosition(offset: chatController.textController.text.length),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark 
              ? Colors.grey[800] 
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: Theme.of(context).primaryColor),
            SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Attach',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAttachmentOption(Icons.image, 'Gallery', Colors.purple),
                _buildAttachmentOption(Icons.camera_alt, 'Camera', Colors.red),
                _buildAttachmentOption(Icons.description, 'Document', Colors.blue),
                _buildAttachmentOption(Icons.mic, 'Audio', Colors.orange),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  String _formatTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  String _formatMessageTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();

      if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
        return 'Today';
      } else if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day - 1) {
        return 'Yesterday';
      } else {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
    } catch (e) {
      return '';
    }
  }
}