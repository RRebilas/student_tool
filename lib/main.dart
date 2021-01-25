import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'models/user.dart';
import 'screens/listener.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(StudentTool());
}

class StudentTool extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Text(
              'Something went wrong',
              textDirection: TextDirection.ltr,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<AppUser>.value(
            value: Authentication().userStream,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.deepPurple.shade900,
                brightness: Brightness.light,
              ),
              home: AuthListener(),
              builder: EasyLoading.init(),
            ),
          );
        }
        return Container(
          child: Text('Loading', textDirection: TextDirection.ltr),
          alignment: Alignment.center,
        );
      },
    );
  }
}
