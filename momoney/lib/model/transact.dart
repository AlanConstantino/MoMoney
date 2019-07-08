class Transact {
  // attributes
  int _id;
  double _expenseAmount;
  String _description;
  String _category;
  String _dateAdded;

  // constructors
  Transact(
      this._id,
      this._expenseAmount,
      this._description,
      this._category,
      this._dateAdded,
      );

  Transact.withoutID(
      this._expenseAmount,
      this._description,
      this._category,
      this._dateAdded,
      );

  // getters
  int get id => _id;
  double get expenseAmount => _expenseAmount;
  String get description => _description;
  String get category => _category;
  String get dateAdded => _dateAdded;

  // setters
  set expenseAmount(double newExpenseAmount) =>
      this._expenseAmount = newExpenseAmount;
  set description(String newDescription) => this._description = newDescription;
  set category(String newCategory) => this._category = newCategory;

  // converting a map into an Expense object
  Transact.fromMap(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._expenseAmount = map['amount'];
    this._description = map['description'];
    this._category = map['category'];
    this._dateAdded = map['dateAdded'];
  }

  // converting an Expense object into a map
  Map<String, dynamic> toMap() => {
    '_id': _id,
    'amount': _expenseAmount,
    'description': _description,
    'category': _category,
    'dateAdded': _dateAdded,
  };
}
