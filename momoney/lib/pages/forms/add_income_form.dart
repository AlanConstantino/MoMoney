import 'package:flutter/material.dart';

class AddIncomeForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddIncomeFormState();
  }
}

class _AddIncomeFormState extends State<AddIncomeForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Extra Income'),
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
