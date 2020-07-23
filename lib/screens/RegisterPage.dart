import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studenttool/authenticate/authenticate.dart';
import 'package:studenttool/widgets/common_widgets.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailAuth = EmailAuth();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            gradient: appGradient(),
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
                    height: 500,
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
                            //TODO: change way of checking email from after submit to after leaving textfield
                            return (EmailValidator.validate(email))
                                ? null
                                : "Email jest nieprawidłowy";
                          }, controller: _email),
                          formField("Hasło", (password) {
                            if (password.length >= 6) {
                              return null;
                            }
                            return "Hasło jest za krótkie(min. 6 znaków)";
                          }, password: true, controller: _password),
                          formField("Powtórz hasło", (password) {
                            return (password == _password.text)
                                ? null
                                : "Hasła się nie zgadzają";
                          }, password: true),
                          RaisedButton(
                            child: Text("Zarejestruj"),
                            onPressed: () async {
                              if (_registerFormKey.currentState.validate()) {
                                await _emailAuth
                                    .registerWithEmailAndPassword(
                                        _email.text, _password.text)
                                    .catchError(
                                  (e) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "${(e is PlatformException) ? e.message : "Something went wrong."}"),
                                    ));
                                  },
                                ).then((value) {
                                  if (value != null) Navigator.pop(context);
                                });
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
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
