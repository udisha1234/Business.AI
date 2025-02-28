import 'package:flutter/material.dart';
import '../../../ai_chat/presentation/pages/ai_chat_assistant.dart';
import '../../../ai_chat/presentation/pages/enhanced_ai_chatting.dart';
import 'quick_action_card.dart';

class QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        QuickActionCard(
          icon: Icons.message,
          label: 'AI Chat Bot',
          color: Colors.blue[700]!,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EnhancedAIChatAssistant()),
            );
          },
          // onTap: () => _showAIChatBot(context),
        ),
        QuickActionCard(
          icon: Icons.phone,
          label: 'AI Call',
          color: Colors.green[600]!,
          onTap: () {},
        ),
        QuickActionCard(
          icon: Icons.email,
          label: 'Send Email',
          color: Colors.orange[600]!,
          onTap: () {},
        ),
        QuickActionCard(
          icon: Icons.qr_code,
          label: 'Barcode',
          color: Colors.purple[600]!,
          onTap: () {},
        ),
        QuickActionCard(
          icon: Icons.receipt,
          label: 'Invoice',
          color: Colors.red[600]!,
          onTap: () {},
        ),
        QuickActionCard(
          icon: Icons.payments,
          label: 'Payment',
          color: Colors.teal[600]!,
          onTap: () {},
        ),
      ],
    );
  }

  void _showAIChatBot(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return AIChatAssistant();
      },
    );
  }
}
