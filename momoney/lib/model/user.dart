class User {
  // attributes
  int _id;
  String _firstName;
  String _lastName;
  double _monthlyIncome;
  double _monthlyExpense;
  int _percentageToSaveMonthly;

  // constructors
  User(
    this._id,
    this._firstName,
    this._lastName,
    this._monthlyIncome,
    this._monthlyExpense,
    this._percentageToSaveMonthly,
  );

  User.withoutID(
    this._firstName,
    this._lastName,
    this._monthlyIncome,
    this._monthlyExpense,
    this._percentageToSaveMonthly,
  );

  // getters
  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  double get monthlyIncome => _monthlyIncome;
  double get monthlyExpense => _monthlyExpense;
  int get percentageToSaveMonthly => _percentageToSaveMonthly;

  // setters
  // no setter for id because Database does that for us
  set firstName(String newFirstName) => this._firstName = newFirstName;
  set lastName(String newLastName) => this._lastName = newLastName;
  set monthlyIncome(double newMonthlyIncome) =>
      this._monthlyIncome = newMonthlyIncome;
  set monthlyExpense(double newMonthlyExpense) =>
      this._monthlyExpense = newMonthlyExpense;
  set percentageToSaveMonthly(int newPercentageToSaveMonthly) =>
      this._percentageToSaveMonthly = newPercentageToSaveMonthly;

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._monthlyIncome = map['monthlyIncome'];
    this._monthlyExpense = map['monthlyExpense'];
    this._percentageToSaveMonthly = map['percentageToSaveMonthly'];
  }

  // converting User object into map
  Map<String, dynamic> toMap() => {
        'id': _id,
        'firstName': _firstName,
        'lastName': _lastName,
        'monthlyIncome': _monthlyIncome,
        'monthlyExpense': _monthlyExpense,
        'percentageToSaveMonthly': _percentageToSaveMonthly,
      };
}
