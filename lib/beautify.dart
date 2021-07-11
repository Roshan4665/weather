import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';

import 'package:weather/constants.dart';

class Beautify extends StatelessWidget {
  Beautify({@required this.data, this.scale});
  final scale;
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        textScaleFactor: scale,
        style: GoogleFonts.lobster(fontSize: 24, color: kTextColor1),
      ),
    );
  }
}
