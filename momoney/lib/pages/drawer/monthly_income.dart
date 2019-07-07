import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/income.dart';

class MonthlyIncome extends StatefulWidget {
  @override
  _MonthlyIncomeState createState() => _MonthlyIncomeState();
}

class _MonthlyIncomeState extends State<MonthlyIncome> {
  final dbHelper = DatabaseHelper.instance;

  Future _getIncomeData() async {
    var data = await dbHelper.queryAllRows('income');
    List<Income> list = [];

    for (var map in data) {
      list.add(Income.fromMap(map));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Income'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getIncomeData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      dbHelper.delete('income', snapshot.data[index].id);
                      snapshot.data.removeAt(index);
                    });
                  },
                  background: Container(
                    padding: EdgeInsets.only(left: 28.0),
                    alignment: AlignmentDirectional.centerStart,
                    color: Colors.red,
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                          title: Text('\$' +
                              snapshot.data[index].incomeAmount.toString()),
                          trailing: Text(snapshot.data[index].dateAdded),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Income',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    'Amount: \$' +
                                        snapshot.data[index].incomeAmount
                                            .toString() +
                                        '\n' +
                                        'Date: ' +
                                        snapshot.data[index].dateAdded,
                                    textAlign: TextAlign.left,
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
