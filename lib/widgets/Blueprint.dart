import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Blueprint extends StatelessWidget {
  final String title;
  final Widget body;

  Blueprint({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.deepPurple.shade900,
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.pacifico(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.5),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                ),
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
