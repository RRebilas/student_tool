import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenttool/screens/RegisterPage.dart';
import 'package:studenttool/widgets/common_widgets.dart';

import '../authenticate/authenticate.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Authentication _auth = Authentication();
  final _key = GlobalKey<FormState>();

  String _error = "";

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: appGradient(),
        ),
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _key,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 10),
                    ],
                  ),
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text('Log in to keep your data saved online'),
                        ),
                        SizedBox(height: 30),
                        formField('Email', (email) {
                          return (EmailValidator.validate(email))
                              ? null
                              : "Email jest nieprawidłowy";
                        }, controller: _email),
                        formField('Password', (password) {
                          return (password.isEmpty) ? "Błąd" : null;
                        }, controller: _password, password: true),
                        SizedBox(height: 10),
                        actionButton(
                          'Zaloguj',
                          context,
                          icon: FontAwesomeIcons.envelope,
                          function: () async {
                            if (_key.currentState.validate()) {
                              await EmailAuth()
                                  .loginWithEmailAndPassword(
                                      _email.text, _password.text)
                                  .catchError((e) => errorHandling(e));
                            }
                          },
                        ),
                        actionButton(
                          'Zaloguj przez Google',
                          context,
                          color: Colors.red,
                          icon: FontAwesomeIcons.google,
                          function: () async {
                            await GoogleAuth()
                                .handleSignIn()
                                .catchError((e) => errorHandling(e));
                          },
                        ),
                        actionButton(
                          'Zaloguj jako gość',
                          context,
                          color: Colors.grey,
                          icon: FontAwesomeIcons.user,
                          function: () async {
                            await _auth
                                .anonymous()
                                .catchError((e) => errorHandling(e));
                          },
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Container(
                              height: 20, child: Text('Nie masz konta?')),
                        ),
                        errorContainer(_error),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void errorHandling(error) {
    setState(() {
      _error = (error is PlatformException)
          ? error.message
          : "Something went wrong. Try again";
    });
  }

  Widget actionButton(String title, context,
      {Function function, color, fontColor, IconData icon}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: color ??= Colors.deepOrange.shade400,
        onPressed: function ?? () {},
        child: Row(
          children: <Widget>[
            FaIcon(
              icon,
              color: Colors.white60,
            ),
            SizedBox(width: 10),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: fontColor ??= Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
