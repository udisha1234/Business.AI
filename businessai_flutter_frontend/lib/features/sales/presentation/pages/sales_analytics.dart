import 'package:flutter/material.dart';
import '../widgets/sales_health_score.dart';
import '../widgets/sales_feedback_chart.dart';

class SalesAnalytics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SalesHealthScore(),
          const SizedBox(height: 20),
          SalesFeedbackChart(),
        ],
      ),
    );
  }
}
