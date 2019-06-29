import 'package:flutter/material.dart';

class MonthlyExpenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MonthlyExpensesState();
  }
}

class _MonthlyExpensesState extends State<MonthlyExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Expenses'),
      ),
      body: Text('Monthly Expenses'),
    );
  }
}
