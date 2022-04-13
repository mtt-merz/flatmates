import 'package:flutter/material.dart';

class CustomThemeData {
  final _scaffoldBackground = Colors.blueGrey[50];
  final _primary = ThemeData.light().primaryColor;

  final _buttonRadius = 30.0;
  final _cardRadius = 15.0;
  final _horizontalPadding = 14.0;

  /// Text
  final _text = const TextTheme(
    headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black),
    headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
    subtitle1: TextStyle(fontSize: 15),
    bodyText1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800),
    bodyText2: TextStyle(fontSize: 14.0),
    button: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.25),
    // labelLarge: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1),
    labelMedium: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w800,
      letterSpacing: 1,
      color: Colors.black87,
    ),
  );

  /// AppBar
  get _appBar => AppBarTheme(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        titleTextStyle: _text.headline6!.copyWith(fontFamily: 'Mulish'),
        iconTheme: const IconThemeData(color: Colors.black87),
      );

  /// Dialog
  get _dialog => DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_buttonRadius)),
        ),
        alignment: Alignment.topCenter,
        elevation: 0,
      );

  /// Card
  get _card => CardTheme(
        color: Colors.white,
        elevation: 0.0,
        margin: const EdgeInsets.only(top: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_cardRadius))),
      );

  /// ListTile
  get _listTile => ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        horizontalTitleGap: 0,
      );

  /// Divider
  get _divider => const DividerThemeData(thickness: 1, color: Colors.black26, space: 1);

  /// OutlinedButton
  get _outlinedButton => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          // visualDensity: VisualDensity.comfortable,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          elevation: 0,
          side: BorderSide(color: _primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_buttonRadius)),
          minimumSize: const Size(100, 0),
          textStyle: _text.button,
        ),
      );

  /// ElevatedButton
  get _elevatedButton => ElevatedButtonThemeData(
          style: ButtonStyle(
        visualDensity: _outlinedButton.style!.visualDensity,
        padding: _outlinedButton.style!.padding,
        elevation: _outlinedButton.style!.elevation,
        shape: _outlinedButton.style!.shape,
        textStyle: MaterialStateProperty.all(_text.button!),
        minimumSize: _outlinedButton.style!.minimumSize,
      ));

  /// TextButton
  get _textButton => TextButtonThemeData(
          style: ButtonStyle(
        textStyle: MaterialStateProperty.all(_text.button?.copyWith(letterSpacing: .7)),
      ));

  /// BottomSheet
  get _bottomSheet => const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      );

  /// InputDecoration
  get _inputDecoration {
    return const InputDecorationTheme(
      isCollapsed: false,
      border: OutlineInputBorder(),
      focusColor: Colors.black54,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  /// Chip
  get _chip => ChipThemeData.fromDefaults(
        brightness: Brightness.light,
        secondaryColor: _primary,
        labelStyle: _text.subtitle1!,
      );

  /// BottomNavigationBar
  get _bottomNavigationBar => BottomNavigationBarThemeData(
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: _primary,
        selectedIconTheme: const IconThemeData(size: 25),
        unselectedIconTheme: const IconThemeData(size: 25),
        unselectedItemColor: Colors.black38,
      );

  get _snackBar => const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      );

  ThemeData get theme => ThemeData(
        fontFamily: 'Mulish',
        // useMaterial3: true,
        scaffoldBackgroundColor: _scaffoldBackground,
        textTheme: _text,
        appBarTheme: _appBar,
        dialogTheme: _dialog,
        cardTheme: _card,
        dividerTheme: _divider,
        listTileTheme: _listTile,
        elevatedButtonTheme: _elevatedButton,
        outlinedButtonTheme: _outlinedButton,
        textButtonTheme: _textButton,
        bottomSheetTheme: _bottomSheet,
        inputDecorationTheme: _inputDecoration,
        chipTheme: _chip,
        bottomNavigationBarTheme: _bottomNavigationBar,
        snackBarTheme: _snackBar,
      );
}
