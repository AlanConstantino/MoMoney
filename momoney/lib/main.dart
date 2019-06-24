import 'package:flutter/material.dart';
import './pages/dashboard.dart';
import './pages/login.dart';
import './pages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: Login(),
      routes: {
        '/dashboard': (_) => Dashboard(),
        '/login': (_) => Login(),
        '/signup': (_) => Signup(),
      }
    );
  }
}

// _read() async {
//   DatabaseHelper helper = DatabaseHelper.instance;
//   int rowId = 1;
//   Word word = await helper.queryWord(rowId);
//   if (word == null) {
//     print('read row $rowId: empty');
//   } else {
//     print('read row $rowId: ${word.word} ${word.frequency}');
//   }
// }

// _save() async {
//   Word word = Word();
//   word.word = 'hello';
//   word.frequency = 15;
//   DatabaseHelper helper = DatabaseHelper.instance;
//   int id = await helper.insert(word);
//   print('inserted row: $id');
// }
