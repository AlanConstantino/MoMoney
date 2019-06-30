import 'package:flutter/material.dart';
import 'package:momoney/data/database.dart';
import 'package:momoney/model/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var userPercentages = ['5', '10', '15', '20'];
  String currentValue = '5'; //default

  // variables to use later for creation of user object
  String firstName;
  String lastName;
  double monthlyIncome;
  double monthlyExpense;
  int percentageToSaveMonthly;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Set Up')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() => this.firstName = value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() => this.lastName = value);
                    },
                  ),
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      labelText: 'Monthly Income',
                      prefixText: '\$',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your monthly income';
                      }
                      if (!(double.parse(value) is double)) {
                        return 'Value is not a decimal';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() => this.monthlyIncome = double.parse(value));
                    },
                  ),
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      labelText: 'Monthly Expenses',
                      prefixText: '\$',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your monthly expenses';
                      }
                      if (!(double.parse(value) is double)) {
                        return 'Value is not a decimal';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() => this.monthlyExpense = double.parse(value));
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('Percentage you would like to save each month'),
                  ),
                  DropdownButton<String>(
                    items: userPercentages.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        this.currentValue = newValue;
                        percentageToSaveMonthly = int.parse(newValue);
                      });
                    },
                    value: currentValue,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: RaisedButton(
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              print(percentageToSaveMonthly);
                              print(firstName);
                              print(lastName);
                              print(monthlyIncome);
                              print(monthlyExpense);
                              print(percentageToSaveMonthly);
                              final user = User.withoutID(
                                  firstName,
                                  lastName,
                                  monthlyIncome,
                                  monthlyExpense,
                                  percentageToSaveMonthly);
                              print('The following will be saved in the database\n ${user.toMap()}');
                              // DBProvider.db.addUserToDatabase(user);
                              _showDialog(context);
                              Navigator.pushNamed(context, "/dashboard");
                            }
                          },
                          child: Text('Save'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
