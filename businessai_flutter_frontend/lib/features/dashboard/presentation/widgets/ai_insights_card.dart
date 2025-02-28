import 'package:flutter/material.dart';

class AIInsightsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'AI Insights',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildListItem(Icons.trending_up, 'Sales are up 15% from last month', 'Tap to see detailed analysis', Colors.orange),
            Divider(),
            _buildListItem(Icons.people, '5 customers need follow-up', 'Tap to view customer list', Colors.green),
            Divider(),
            _buildListItem(Icons.inventory, 'Inventory alert: 3 items low on stock', 'Tap to manage inventory', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {},
    );
  }
}
