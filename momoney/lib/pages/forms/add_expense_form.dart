import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/expense.dart';

class AddExpenseForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  double _expenseAmount;
  String _description;
  String _selectedRadioFromList;

  setSelectedRadioFromList(String value) {
    setState(() {
      _selectedRadioFromList = value;
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
          groupValue: _selectedRadioFromList,
          title: Text(value),
          onChanged: (String current) {
            setSelectedRadioFromList(current);
          },
          selected: _selectedRadioFromList == value,
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      enableInteractiveSelection: false, // disbales copy/paste
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
                        return null;
                      },
                      onSaved: (String value) {
                        setState(
                          () => this._expenseAmount = double.parse(value),
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a short description about your expense';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        setState(
                          () => this._description = value,
                        );
                      },
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
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Save',
        label: Text('Save'),
        icon: Icon(Icons.save_alt),
        onPressed: () async {
          final form = _formKey.currentState;
          if (form.validate()) {
            form.save();
            String formattedDate =
                DateFormat('EEE M/d/y h:mm a').format(DateTime.now());

            // saves expense object to database as a map
            final dbHelper = DatabaseHelper.instance;
            Expense expense = Expense.withoutID(_expenseAmount, _description,
                _selectedRadioFromList, formattedDate);
            dbHelper.insert('expense', expense.toMap());

            // uncomment the following to see all the rows within the income table

            // final allRows = await dbHelper.queryAllRows('expense');
            // print('query all rows:');
            // allRows.forEach((row) => print(row));

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
