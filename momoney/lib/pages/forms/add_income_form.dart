import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Save',
        label: Text('Save'),
        icon: Icon(Icons.save_alt),
        onPressed: () {
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('EEE M/d/y h:mm a').format(now);
          print(formattedDate);
          Navigator.pop(context);
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    labelText: 'Income Amount',
                    prefixText: '\$',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an expense amount';
                    }
                    if (!(double.parse(value) is double)) {
                      return 'Value is not a decimal';
                    }
                    return null;
                  },
                  onSaved: (String str) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
