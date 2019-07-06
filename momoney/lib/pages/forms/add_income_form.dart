import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/income.dart';

class AddIncomeForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddIncomeFormState();
}

class _AddIncomeFormState extends State<AddIncomeForm> {
  final _formKey = GlobalKey<FormState>();
  double _incomeAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Extra Income'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      enableInteractiveSelection: false, // disables copy/paste
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        labelText: 'Income Amount',
                        prefixText: '\$',
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter an income amount';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        setState(
                          () => this._incomeAmount = double.parse(value),
                        );
                      },
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

            // gets current time
            String formattedDate =
                DateFormat('EEE M/d/y h:mm a').format(DateTime.now());

            // saves income object to database as a map
            final dbHelper = DatabaseHelper.instance;
            Income income = Income.withoutID(_incomeAmount, formattedDate);
            dbHelper.insert('income', income.toMap());

            // uncomment the following to see all the rows within the income table

            // final allRows = await dbHelper.queryAllRows('income');
            // print('query all rows:');
            // allRows.forEach((row) => print(row));

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
