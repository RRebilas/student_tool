import 'package:flutter/material.dart';
import '../widgets/AuthForm.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black54, Colors.purpleAccent, Colors.purple.shade200],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          tileMode: TileMode.clamp,
        ),
      ),
      child: AuthForm(),
    );
  }
}
