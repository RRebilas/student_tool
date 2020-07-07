import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:studenttool/authenticate/authenticate.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
                            return (EmailValidator.validate(email))
                                ? null
                                : "Email jest nieprawidłowy";
                          }, false, controller: _email),
                          formField("Hasło", (password) {
                            if (password.length >= 6) {
                              return null;
                            }
                            return "Hasło jest za krótkie(min. 6 znaków)";
                          }, true, controller: _password),
                          formField("Powtórz hasło", (password) {
                            return (password == _password.text)
                                ? null
                                : "Hasła się nie zgadzają";
                          }, true),
                          RaisedButton(
                            child: Text("Zarejestruj"),
                            onPressed: () async {
                              if (_registerFormKey.currentState.validate()) {
                                dynamic result = await EmailAuth()
                                    .registerWithEmailAndPassword(
                                        _email.text, _password.text);
                                if (result == null) {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Użyty email isntieje w bazie danych, użyj innego"),
                                    duration: Duration(seconds: 5),
                                  ));
                                }
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

  Widget formField(String label, Function validator, bool password,
      {TextEditingController controller}) {
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
          controller: controller ??= null,
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
