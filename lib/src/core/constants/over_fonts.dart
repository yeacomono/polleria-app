import 'package:flutter/material.dart';

abstract class OverFonts {
  static const TextStyle whiteLoginInputLabel = TextStyle(
    color: Color(0xFFffffff),
    fontFamily: 'arial',
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.0,
  );
  static const TextStyle whiteLoginInput = TextStyle(
    color: Colors.white,
    fontFamily: 'arial',
    fontSize: 17.0,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle blueLoginButton = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.7),
    fontFamily: 'arial',
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle whiteTitle = TextStyle(
    color: Color(0xFFffffff),
    fontFamily: 'arial',
    fontSize: 17.0,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle blueListMenuSubItem = TextStyle(
    color: Colors.blueAccent,
    fontFamily: 'arial',
    fontSize: 15.0,
  );
  static const TextStyle blackDrawerItem = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.7),
    fontFamily: 'arial',
    fontSize: 15.0,
    fontWeight: FontWeight.w800,
  );
}
