import 'package:flutter/material.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String change;

  const StatItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPositive = change.startsWith('+');

    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 24),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 2),
        Text(
          change,
          style: TextStyle(
            fontSize: 12,
            color: isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
