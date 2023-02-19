import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme=ThemeData(
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
    elevation: 5.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: mainColor,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: mainColor,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.black12,
      statusBarIconBrightness: Brightness.light,
    ),




  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: mainColor,
    type: BottomNavigationBarType.fixed,
    elevation: 0.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,

  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(),

    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      color: Colors.grey,
      fontSize: 12,
    ),
  ),
);
ThemeData darkTheme=ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primarySwatch: Colors.deepOrange,

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 10.0,
    iconTheme: IconThemeData(color: Colors.deepOrange),
    titleTextStyle: TextStyle(
      color: Colors.yellow,
      fontSize: 13,
      fontWeight: FontWeight.bold,

    ),

  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    elevation: 0.0,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
        color: Colors.deepOrange,
        fontSize: 12),
  ),
);