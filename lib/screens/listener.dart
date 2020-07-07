import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenttool/models/user.dart';
import 'package:studenttool/screens/auth_page.dart';

import 'AppScreen.dart';

class AuthListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    return (user == null) ? AuthPage() : AppScreen();
  }
}
