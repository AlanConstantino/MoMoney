import 'package:flutter/material.dart';
import 'package:momoney/pages/register.dart';
import 'package:momoney/pages/dashboard.dart';
import 'package:momoney/pages/forms/add_expense_form.dart';
import 'package:momoney/pages/forms/add_income_form.dart';
import 'package:momoney/pages/drawer/profile.dart';
import 'package:momoney/pages/drawer/settings.dart';
import 'package:momoney/pages/drawer/monthly_expenses.dart';
import 'package:momoney/pages/drawer/monthly_income.dart';
import 'package:momoney/pages/check_for_returning_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MoMoney',
        theme: ThemeData(
          brightness: Brightness.dark,
          hintColor: Colors.grey,
          textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
              title: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
          appBarTheme: AppBarTheme(
            color: Colors.black,
            iconTheme: IconThemeData(color: Colors.greenAccent),
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.greenAccent),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
            foregroundColor: Colors.greenAccent,
          ),
          dialogTheme: DialogTheme(
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          buttonColor: Colors.black,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => CheckIfReturningUser(),
          '/dashboard': (_) => Dashboard(),
          '/register': (_) => Register(),
          '/settings': (_) => Settings(),
          '/profile': (_) => Profile(),
          '/monthly_expenses': (_) => MonthlyExpenses(),
          '/monthly_income': (_) => MonthlyIncome(),
          '/add_income_form': (_) => AddIncomeForm(),
          '/add_expense_form': (_) => AddExpenseForm(),
        });
  }
}
