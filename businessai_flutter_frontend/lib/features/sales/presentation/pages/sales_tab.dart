import 'package:flutter/material.dart';
import 'sales_overview.dart';
import 'sales_transactions.dart';
import 'sales_analytics.dart';

class SalesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'OVERVIEW'),
              Tab(text: 'TRANSACTIONS'),
              Tab(text: 'ANALYTICS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SalesOverview(),
            SalesTransactions(),
            SalesAnalytics(),
          ],
        ),
      ),
    );
  }
}
