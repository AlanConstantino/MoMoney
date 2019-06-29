class User {
  // attributes
  int id;
  String firstName;
  String lastName;
  double monthlyIncome;
  double monthlyExpense;
  int percentageToSaveMonthly;

  // constructor
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.monthlyIncome,
    this.monthlyExpense,
    this.percentageToSaveMonthly,
  });

  // converting User map into object
  factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        monthlyIncome: json["monthlyIncome"],
        monthlyExpense: json["monthlyExpense"],
        percentageToSaveMonthly: json["percentageToSaveMonthly"],
      );

  // converting User object into map
  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "monthlyIncome": monthlyIncome,
        "monthlyExpense": monthlyExpense,
        "percentageToSaveMonthly": percentageToSaveMonthly,
      };

  // only for debugging
  save() {
    print('saving to database...');
  }
}
