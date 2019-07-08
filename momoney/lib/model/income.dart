import 'package:flutter/material.dart';

class Income {
  // attributes
  int _id;
  double _incomeAmount;
  String _dateAdded;

  // constructors
  Income(
    this._id,
    this._incomeAmount,
    this._dateAdded,
  );
  
  Income.withoutID(
    this._incomeAmount,
    this._dateAdded,
  );
  void setID(int value){
    this._id = value;
  }

  // getters
  int get id => _id;
  double get incomeAmount => _incomeAmount;
  String get dateAdded => _dateAdded;
  Key get key => ObjectKey(this);

  // setter
  set incomeAmount(double newIncomeAmount) =>
      this._incomeAmount = newIncomeAmount;

  // converting a map into an Income object
  Income.fromMap(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._incomeAmount = map['incomeAmount'];
    this._dateAdded = map['dateAdded'];
  }

  // converting an Income object into a map
  Map<String, dynamic> toMap() => {
        '_id': _id,
        'incomeAmount': _incomeAmount,
        'dateAdded': _dateAdded,
      };
}
