import 'package:flutter/material.dart';

class SalesTransactions extends StatelessWidget {
  double random(int seed) {
    return ((seed * 9301 + 49297) % 233280) / 233280;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        bool isIncome = index % 3 != 0;
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: isIncome ? Colors.green[100] : Colors.red[100],
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
          title: Text('Transaction #${1000 + index}'),
          subtitle: Text('Feb ${10 + index % 18}, 2025'),
          trailing: Text(
            '${isIncome ? "+" : "-"}\$${(random(index) * 1000).toStringAsFixed(2)}',
            style: TextStyle(
              color: isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
