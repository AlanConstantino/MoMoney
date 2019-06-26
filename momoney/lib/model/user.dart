// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String firstName;
  String lastName;
  double monthlyIncome;
  double monthlyExpense;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.monthlyIncome,
    this.monthlyExpense,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        monthlyIncome: json["monthly_income"],
        monthlyExpense: json["monthly_expense"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "monthly_income": monthlyIncome,
        "monthly_expense": monthlyExpense,
      };

  // only for debugging
  save(){
    print('saving to database...');
  }
}
