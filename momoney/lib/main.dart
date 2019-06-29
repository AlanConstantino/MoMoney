import 'package:flutter/material.dart';

import 'package:momoney/pages/dashboard.dart';
import 'package:momoney/pages/monthly_expenses.dart';
import 'package:momoney/pages/goals.dart';
import 'package:momoney/pages/register.dart';
import 'package:momoney/pages/monthly_income.dart';
import 'package:momoney/pages/settings.dart';
import 'package:momoney/pages/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
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
          // '/settings': (_) => Settings(),
          '/profile': (_) => Profile(),
          '/goals': (_) => Goals(),
          '/monthly_expenses': (_) => MonthlyExpenses(),
          '/monthly_income': (_) => MonthlyIncome(),
        });
  }
}
