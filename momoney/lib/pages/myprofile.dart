import 'package:flutter/material.dart';
import 'package:momoney/data/database.dart';
import 'package:momoney/model/user.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<User>>(
        future: DBProvider.db.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                User item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteUserWithId(item.id);
                  },
                  child: ListTile(
                    title: Text(item.firstName),
                    subtitle: Text(item.monthlyExpense.toString()),
                    leading: CircleAvatar(child: Text(item.id.toString())),
                    onTap: () {},
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
