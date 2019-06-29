import 'package:flutter/material.dart';
import 'package:momoney/data/database.dart';
import 'package:momoney/model/user.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('My Profile'),
      ),
      body: Container(
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
                      Navigator.of(context).pop();
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
      ),
    );
  }
}
