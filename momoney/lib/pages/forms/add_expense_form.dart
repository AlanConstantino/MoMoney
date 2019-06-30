import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenseForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseFormState();
  }
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  String selectedRadioFromList;

  setSelectedRadioFromList(String value) {
    setState(() {
      selectedRadioFromList = value;
    });
  }

  List<Widget> createRadioList() {
    List<String> list = [
      'Clothing',
      'Entertainment',
      'Fee',
      'Food',
      'Fuel',
      'Gift',
      'Groceries',
      'Housing',
      'Insurance',
      'Medical',
      'Personal',
      'Parking',
      'Recreation',
      'Rent',
      'Saving',
      'Transportation',
      'Utility',
      'Other',
    ];
    List<Widget> widgets = [];
    for (String value in list) {
      widgets.add(
        RadioListTile(
          value: value,
          groupValue: selectedRadioFromList,
          title: Text(value),
          onChanged: (String current) {
            print('$current');
            setSelectedRadioFromList(current);
          },
          selected: selectedRadioFromList == value,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add An Expense'),
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
            child: ListView(
              children: <Widget>[
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    labelText: 'Expense Amount',
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a description about your expense';
                    }
                    return null;
                  },
                  onSaved: (String str) {},
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Center(child: Text('Select Category')),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: createRadioList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
