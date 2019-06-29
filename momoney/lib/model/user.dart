class User {
  // attributes
  int id;
  String firstName;
  String lastName;
  String goalTitle;
  int goalAmount;
  double monthlyIncome;
  double monthlyExpense;

  // constructor
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.goalTitle,
    this.goalAmount,
    this.monthlyIncome,
    this.monthlyExpense,
  });

  // converting User map into object
  factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        goalTitle: json["goalTitle"],
        goalAmount: json["goalAmount"],
        monthlyIncome: json["monthlyIncome"],
        monthlyExpense: json["monthlyExpense"],
      );

  // converting User object into map
  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "goalTitle": goalTitle,
        "goalAmount": goalAmount,
        "monthlyIncome": monthlyIncome,
        "monthlyExpense": monthlyExpense,
      };

  // only for debugging
  save() {
    print('saving to database...');
  }
}
