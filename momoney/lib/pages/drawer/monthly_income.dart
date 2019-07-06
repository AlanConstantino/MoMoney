import 'package:flutter/material.dart';
import 'package:momoney/data/database_helper.dart';
import 'package:momoney/model/income.dart';

class MonthlyIncome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MonthlyIncomeState();
}

class _MonthlyIncomeState extends State<MonthlyIncome> {
  final dbHelper = DatabaseHelper.instance;

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
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return ListView.builder(
              itemCount: snapshot?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Text('${snapshot.data[index].id.toString()}'),
                        title: Text(
                            'Amount: \$${snapshot.data[index].incomeAmount.toString()}'),
                        subtitle: Text('${snapshot.data[index].dateAdded}'),
                        onTap: () {},
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
