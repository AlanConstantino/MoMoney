import 'package:flutter/material.dart';

class AddExpenseForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseFormState();
  }
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add An Expense'),
      ),
      body: Text('Place form stuff here'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
