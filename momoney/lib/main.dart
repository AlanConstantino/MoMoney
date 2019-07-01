import 'package:flutter/material.dart';

import 'package:momoney/pages/goals.dart';
import 'package:momoney/pages/register.dart';
import 'package:momoney/pages/dashboard.dart';
import 'package:momoney/pages/forms/add_expense_form.dart';
import 'package:momoney/pages/forms/add_income_form.dart';
import 'package:momoney/pages/drawer/profile.dart';
import 'package:momoney/pages/drawer/settings.dart';
import 'package:momoney/pages/drawer/monthly_expenses.dart';
import 'package:momoney/pages/drawer/monthly_income.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MoMoney',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF2196f3),
          accentColor: const Color(0xFF2196f3),
          canvasColor: const Color(0xFFfafafa),
        ),
        home: Dashboard(),
        routes: {
          '/dashboard': (_) => Dashboard(),
          '/register': (_) => Register(),
          '/settings': (_) => Settings(),
          '/profile': (_) => Profile(),
          '/goals': (_) => Goals(), // not currently being used
          '/monthly_expenses': (_) => MonthlyExpenses(),
          '/monthly_income': (_) => MonthlyIncome(),
          '/add_income_form': (_) => AddIncomeForm(),
          '/add_expense_form': (_) => AddExpenseForm(),
        });
  }
}
