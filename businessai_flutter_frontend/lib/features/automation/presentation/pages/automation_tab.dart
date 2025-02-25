import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controllers/automation_controller.dart';
import '../widgets/automation_card.dart';

class AutomationTab extends StatelessWidget {
  final AutomationController controller = Get.put(AutomationController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Automation',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _buildSectionHeader('Communication'),
          AutomationCard(title: 'AI Chat Bot', description: 'Configure automated responses', icon: Icons.chat, color: Colors.blue, index: 0),
          AutomationCard(title: 'AI Call System', description: 'Set up virtual receptionist', icon: Icons.phone, color: Colors.green, index: 1),
          _buildSectionHeader('Sales & Inventory'),
          AutomationCard(title: 'Sales Tracking', description: 'AI analysis of sales', icon: Icons.trending_up, color: Colors.purple, index: 2),
          AutomationCard(title: 'Inventory Management', description: 'Stock monitoring', icon: Icons.inventory, color: Colors.amber, index: 3),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
