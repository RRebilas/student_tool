import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studenttool/screens/RegisterPage.dart';

import '../authenticate/authenticate.dart';

class AuthPage extends StatelessWidget {
  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(245, 56, 3, 1),
              Color.fromRGBO(245, 208, 32, 1)
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            tileMode: TileMode.clamp,
          ),
        ),
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 10),
                    ],
                  ),
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text('Log in to keep your data saved online'),
                        ),
                        SizedBox(height: 30),
                        formField('Email'),
                        formField('Password', password: true),
                        SizedBox(height: 10),
                        actionButton('Zaloguj', context,
                            icon: FontAwesomeIcons.envelope),
                        actionButton(
                          'zaloguj przez Facebook',
                          context,
                          color: Color.fromRGBO(59, 80, 152, 1),
                          icon: FontAwesomeIcons.facebook,
                        ),
                        actionButton(
                          'Zaloguj przez Google',
                          context,
                          color: Colors.red,
                          icon: FontAwesomeIcons.google,
                        ),
                        actionButton('Zaloguj jako gość', context,
                            color: Colors.grey, function: () async {
                          dynamic result = await _auth.anonymous();
                          if (result == null) {
                            print('Error signing in');
                          } else {
                            print(result);
                          }
                        }, icon: FontAwesomeIcons.user),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text('Nie masz konta?'),
                        ),
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

  Widget formField(String label, {bool password}) {
    return TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.all(0),
      ),
      validator: (String value) {
        return (value.isEmpty) ? 'Please enter some text' : null;
      },
      obscureText: password ??= false,
    );
  }

  Widget actionButton(String title, context,
      {Function function, color, fontColor, IconData icon}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: color ??= Colors.deepOrange.shade400,
        onPressed: function ??= () {},
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
