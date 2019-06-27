class User {
  // attributes
  int id;
  String firstName;
  String lastName;
  String goal;
  double monthlyIncome;
  double monthlyExpense;

  // constructor
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.goal,
    this.monthlyIncome,
    this.monthlyExpense,
  });

  // converting User map into object
  factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        goal: json["goal"],
        monthlyIncome: json["monthly_income"],
        monthlyExpense: json["monthly_expense"],
      );

  // converting User object into map
  Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "goal": goal,
        "monthly_income": monthlyIncome,
        "monthly_expense": monthlyExpense,
      };

  // only for debugging
  save() {
    print('saving to database...');
  }
}
