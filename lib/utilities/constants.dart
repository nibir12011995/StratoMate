import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
  color: Colors.white,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

var kTextStyle = GoogleFonts.dosis(
  fontSize: 21.0,
  color: Colors.blueGrey[900],
  fontWeight: FontWeight.w500,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 60.0,
);

const kInputField = InputDecoration(
  hintText: 'Enter Your City Name',
  hintStyle: TextStyle(
    color: Colors.black45,
  ),
  filled: true,
  fillColor: Colors.white60,
  hoverColor: Colors.white,
  focusColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
);
