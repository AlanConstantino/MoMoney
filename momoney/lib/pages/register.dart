import 'package:flutter/material.dart';
import '../model/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();

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
                      },
                      onSaved: (val) => setState(() => _user.firstName = val),
                    ),
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Last name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your last name.';
                          }
                        },
                        onSaved: (val) => setState(() => _user.lastName = val)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0.00',
                        labelText: 'Monthly Income',
                        prefixText: '\$',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your monthly income';
                        }
                      },
                      onSaved: (val) =>
                          setState(() => _user.monthlyIncome = double.parse(val)),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0.00',
                        labelText: 'Monthly Expenses',
                        prefixText: '\$',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your monthly expenses';
                        }
                      },
                    onSaved: (val) =>
                          setState(() => _user.monthlyExpense = double.parse(val)),
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
