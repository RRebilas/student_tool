import 'package:flutter/material.dart';

Widget formField(String label, Function validator,
    {TextEditingController controller, bool password}) {
  return TextFormField(
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(0),
    ),
    validator: validator,
    controller: controller,
    obscureText: password ??= false,
  );
}

Widget errorContainer(String content) {
  return Container(
    color: Colors.red,
    child: Text(
      content,
      style: TextStyle(fontSize: 14, color: Colors.white),
    ),
  );
}
