class Income {
  // attributes
  int _id;
  double _incomeAmount;

  // constructors
  Income(this._id, this._incomeAmount);
  Income.withoutID(this._incomeAmount);

  // getters
  int get id => _id;
  double get incomeAmount => _incomeAmount;

  // setter
  set incomeAmount(double newIncomeAmount) =>
      this._incomeAmount = newIncomeAmount;

  // converting a map into an Income object
  Income.fromMap(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._incomeAmount = map['incomeAmount'];
  }

  // converting an Income object into a map
  Map<String, dynamic> toMap() => {
        '_id': _id,
        'incomeAmount': _incomeAmount,
      };
}
