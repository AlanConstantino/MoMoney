import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/income.dart';

class MonthlyIncome extends StatefulWidget {
  @override
  _MonthlyIncomeState createState() => _MonthlyIncomeState();
}

class _MonthlyIncomeState extends State<MonthlyIncome> {
  final dbHelper = DatabaseHelper.instance;
  static List<Income> incomeList = [];

  Future<List<Income>> _getIncomeData() async {
    var data = await dbHelper.queryAllRowsByDescending('income');

    List<Income> list = [];

    for (var item in data) {
      Income income =
          Income(item['_id'], item['incomeAmount'], item['dateAdded']);
      list.add(income);
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
            // var item = _getIncomeData();
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return ListView.builder(
              itemCount: snapshot?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ObjectKey(snapshot.data[index].id),
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
                          // dense: true,
                          // isThreeLine: true,
                          leading: Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                          title: Text(
                              '\$' + snapshot.data[index].incomeAmount.toString()),
                          // subtitle: Text(''),
                          // subtitle: Text('${snapshot.data[index].dateAdded}'),
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
                                    'Amount: \$' + snapshot.data[index].incomeAmount.toString() + '\n' +
                                    'Date: ' + snapshot.data[index].dateAdded,
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
                  onDismissed: (direction) {
                    // print(index);
                    // print(snapshot.data[index].id);
                    // var item = snapshot.data;
                    // var oldData = snapshot.data[index].incomeAmount;
                    // setState(() {
                    //   item.removeAt(index);
                    //   dbHelper.delete('income', snapshot.data[index].id);
                    // });

                    // Scaffold.of(context).showSnackBar(
                    //     SnackBar(content: Text("Deleted \$$oldData of income")));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
