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
        firstName: json["firstName"],
        lastName: json["lastName"],
        goal: json["goal"],
        monthlyIncome: json["monthlyIncome"],
        monthlyExpense: json["monthlyExpense"],
      );

  // converting User object into map
  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "goal": goal,
        "monthlyIncome": monthlyIncome,
        "monthlyExpense": monthlyExpense,
      };

  // only for debugging
  save() {
    print('saving to database...');
  }
}
