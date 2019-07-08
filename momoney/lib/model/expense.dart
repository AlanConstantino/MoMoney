class Expense {
  // attributes
  int _id;
  double _expenseAmount;
  String _description;
  String _category;
  String _dateAdded;

  // constructors
  Expense(
    this._id,
    this._expenseAmount,
    this._description,
    this._category,
    this._dateAdded,
  );

  Expense.withoutID(
    this._expenseAmount,
    this._description,
    this._category,
    this._dateAdded,
  );

  void setID(int value){
    this._id = value;
  }

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
  Expense.fromMap(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._expenseAmount = map['expenseAmount'];
    this._description = map['description'];
    this._category = map['category'];
    this._dateAdded = map['dateAdded'];
  }

  // converting an Expense object into a map
  Map<String, dynamic> toMap() => {
        '_id': _id,
        'expenseAmount': _expenseAmount,
        'description': _description,
        'category': _category,
        'dateAdded': _dateAdded,
      };
}
