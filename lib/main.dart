import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'models/user.dart';
import 'screens/listener.dart';

void main() => runApp(StudentTool());

class StudentTool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Authentication().userStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurple.shade900,
          brightness: Brightness.light,
        ),
        home: AuthListener(),
      ),
    );
  }
}
