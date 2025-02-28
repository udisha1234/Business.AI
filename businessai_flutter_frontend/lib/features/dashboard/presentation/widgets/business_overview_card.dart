import 'package:flutter/material.dart';
import 'stat_item.dart';

class BusinessOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Business Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }
}
