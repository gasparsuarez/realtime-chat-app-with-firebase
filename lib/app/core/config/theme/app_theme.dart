import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';

///
/// App theme data configuration
///
ThemeData get appTheme => ThemeData(
      fontFamily: 'Lato',
      colorSchemeSeed: Colors.grey,
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kBlackColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kBlackColor,
          ),
        ),
        labelStyle: TextStyle(
          color: kBlackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
