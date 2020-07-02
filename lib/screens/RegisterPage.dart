import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

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
                key: _registerFormKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                          child: Text('Zarejestruj się przy użyciu e-mail'),
                        ),
                        SizedBox(height: 30),
                        formField("Email", (email) {
                          return (EmailValidator.validate(email))
                              ? null
                              : "Email jest nieprawidłowy";
                        }, false),
                        formField("Hasło", (password) {
                          return (password.length >= 3)
                              ? null
                              : "Hasło jest za krótkie";
                        }, true),
                        RaisedButton(
                          child: Text("Zarejestruj"),
                          onPressed: () async {
                            if (_registerFormKey.currentState.validate()) {
                              print("Processing");
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('Powrót do strony logowania'),
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

  Widget formField(String label, Function validator, bool password) {
    return Column(
      children: <Widget>[
        TextFormField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              labelText: label,
              contentPadding: const EdgeInsets.all(0),
              errorStyle: TextStyle(color: Colors.red)),
          validator: validator,
          obscureText: password,
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
