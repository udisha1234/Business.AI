import 'package:flutter/material.dart';
import '../widgets/stat_item.dart';
import '../widgets/quick_action_card.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Business Overview Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatItem(
                        icon: Icons.attach_money,
                        label: 'Revenue',
                        value: '\$12,450',
                        change: '+8.2%',
                      ),
                      StatItem(
                        icon: Icons.people,
                        label: 'Customers',
                        value: '284',
                        change: '+12%',
                      ),
                      StatItem(
                        icon: Icons.shopping_cart,
                        label: 'Orders',
                        value: '86',
                        change: '+5.4%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // AI Insights Card
          Card(
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
          ),

          SizedBox(height: 20),

          // Quick Actions
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              QuickActionCard(icon: Icons.message, label: 'AI Chat Bot', color: Colors.blue[700]!),
              QuickActionCard(icon: Icons.phone, label: 'AI Call', color: Colors.green[600]!),
              QuickActionCard(icon: Icons.email, label: 'Send Email', color: Colors.orange[600]!),
              QuickActionCard(icon: Icons.qr_code, label: 'Barcode', color: Colors.purple[600]!),
              QuickActionCard(icon: Icons.receipt, label: 'Invoice', color: Colors.red[600]!),
              QuickActionCard(icon: Icons.payments, label: 'Payment', color: Colors.teal[600]!),
            ],
          ),
        ],
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
