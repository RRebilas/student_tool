import 'package:flutter/material.dart';
import 'package:studenttool/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            //TODO: add globalKey<formstate>
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
                        icon: FontAwesomeIcons.user),
                    actionButton(
                      'zaloguj przez Facebook',
                      context,
                      color: Color.fromRGBO(59, 80, 152, 1),
                      icon: FontAwesomeIcons.facebook,
                    ),
                    actionButton(
                      'Zaloguj przez Google',
                      context,
                      icon: FontAwesomeIcons.google,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formField(String label,
      {TextEditingController controller, bool password}) {
    return TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.all(0),
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
        color: color ??= Colors.purple.shade300,
        onPressed: () async {},
        child: Row(
          children: <Widget>[
            FaIcon(
              icon,
              color: Colors.white60,
            ),
            SizedBox(
              width: 10,
            ),
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
