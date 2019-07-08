class Transact {
  // attributes
  int _id;
  double _transactAmount;
  String _description;
  String _category;
  String _dateAdded;

  // constructors
  Transact(
      this._id,
      this._transactAmount,
      this._description,
      this._category,
      this._dateAdded,
      );

  Transact.withoutID(
      this._transactAmount,
      this._description,
      this._category,
      this._dateAdded,
      );

  // getters
  int get id => _id;
  double get transactAmount => _transactAmount;
  String get description => _description;
  String get category => _category;
  String get dateAdded => _dateAdded;

  // setters
  set transactAmount(double newTransactAmount) =>
      this._transactAmount = newTransactAmount;
  set description(String newDescription) => this._description = newDescription;
  set category(String newCategory) => this._category = newCategory;

  // converting a map into an transact object
  Transact.fromMap(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._transactAmount = map['amount'];
    this._description = map['description'];
    this._category = map['category'];
    this._dateAdded = map['dateAdded'];
  }

  // converting an transact object into a map
  Map<String, dynamic> toMap() => {
    '_id': _id,
    'amount': _transactAmount,
    'description': _description,
    'category': _category,
    'dateAdded': _dateAdded,
  };
}
