import 'package:flutter/material.dart';
import '../widgets/sales_chart.dart';
import '../widgets/sales_card.dart';

class SalesOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SalesCard(
            title: 'Monthly Sales',
            child: SalesChart(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Top Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey.withOpacity(0.2),
                    child: Center(child: Text('P${index + 1}')),
                  ),
                  title: Text('Product ${index + 1}'),
                  subtitle: Text('${(100 - index * 12)}% growth'),
                  trailing: Text('\$${(1000 - index * 100)}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
