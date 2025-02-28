import 'package:flutter/material.dart';
import '../../../ai_chat/presentation/pages/ai_chat_assistant.dart';
import '../widgets/business_overview_card.dart';
import '../widgets/ai_insights_card.dart';
import '../widgets/quick_actions_grid.dart';
// import '../../ai_chat/presentation/pages/ai_chat_assistant.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BusinessOverviewCard(),
            SizedBox(height: 20),
            AIInsightsCard(),
            SizedBox(height: 20),
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            QuickActionsGrid(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat),
        onPressed: () => _showAIChatBot(context),
        tooltip: 'AI Assistant',
      ),
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
