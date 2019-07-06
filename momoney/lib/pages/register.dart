import 'package:flutter/material.dart';
import 'package:momoney/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var userPercentages = ['5', '10', '15', '20'];
  String currentValue = '5'; //default

  // variables to use later for creation of user object
  String _firstName;
  String _lastName;
  double _monthlyIncome;
  double _monthlyExpense;
  int _percentageToSaveMonthly;

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
                        onSaved: (String value) {
                          setState(() => this._firstName = value);
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
                        onSaved: (String value) {
                          setState(() => this._lastName = value);
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
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your monthly income';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          setState(
                              () => this._monthlyIncome = double.parse(value));
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
                          return null;
                        },
                        onSaved: (String value) {
                          setState(
                            () => this._monthlyExpense = double.parse(value),
                          );
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        alignment: Alignment.center,
                        child: Text(
                            'Percentage you would like to save each month'),
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
                            _percentageToSaveMonthly = int.parse(newValue);
                          });
                        },
                        value: currentValue,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: RaisedButton(
                              onPressed: () async {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();

                                  // save user data to shared preferences
                                  preferences.setString('firstName', _firstName);
                                  preferences.setString('lastName', _lastName);
                                  preferences.setDouble('monthlyIncome', _monthlyIncome);
                                  preferences.setDouble('monthlyExpense', _monthlyExpense);
                                  preferences.setInt('percentageToSaveMonthly',_percentageToSaveMonthly);

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
}
