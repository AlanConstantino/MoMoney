import 'package:flutter/material.dart';

class MonthlyIncome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MonthlyIncomeState();
  }
}

class _MonthlyIncomeState extends State<MonthlyIncome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Income'),
      ),
      body: Text('Monthly Income'),
    );
  }
}
