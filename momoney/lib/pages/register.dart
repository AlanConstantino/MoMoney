import 'package:flutter/material.dart';
import 'package:momoney/data/database.dart';
import 'package:momoney/model/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();
  double monthlyIncome;
  double monthlyExpense;
  var userPercentages = ['5%', '10%', '15%', '20%'];

  String currentValue = '5%'; //default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Set Up')),
      body: Container(
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
                    return '';
                  },
                  onSaved: (val) => setState(() => _user.firstName = val),
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Last name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return '';
                    },
                    onSaved: (val) => setState(() => _user.lastName = val)),
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
                    return '';
                  },
                  onSaved: (String val) =>
                      setState(() => _user.monthlyIncome = double.parse(val)),
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
                    return '';
                  },
                  onSaved: (String val) => setState(
                    () => _user.monthlyExpense = double.parse(val),
                  ),
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
                            form.save();
                            _user.save();
                            DBProvider.db.addUserToDatabase(_user);
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
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
