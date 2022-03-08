import 'package:flutter/material.dart';

class CustomThemeData {
  final _scaffoldBackground = Colors.blueGrey[50];
  final _primary = ThemeData.light().primaryColor;

  final _radius = 30.0;
  final _horizontalPadding = 12.0;

  /// Text
  final _text = const TextTheme(
    headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.black),
    headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
    subtitle1: TextStyle(fontSize: 15),
    bodyText1: TextStyle(fontSize: 18.0),
    bodyText2: TextStyle(fontSize: 14.0),
    button: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.25),
    labelMedium: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1),
  );

  /// AppBar
  get _appBar => AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        titleTextStyle: _text.headline6!.copyWith(color: Colors.black87),
        iconTheme: const IconThemeData(color: Colors.black87),
      );

  /// Dialog
  get _dialog => DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_radius))),
        alignment: Alignment.bottomCenter,
      );

  /// Card
  get _card => CardTheme(
        color: Colors.white,
        elevation: 0.0,
        margin: EdgeInsets.symmetric(horizontal: _horizontalPadding)
            .add(const EdgeInsets.only(top: 12.0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_radius))),
      );

  /// ListTile
  get _listTile => ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        horizontalTitleGap: 0,
      );

  /// Divider
  get _divider => DividerThemeData(
        thickness: 2,
        color: _scaffoldBackground,
        space: 18,
      );

  /// OutlinedButton
  get _outlinedButton => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          // visualDensity: VisualDensity.comfortable,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          elevation: 0,
          side: BorderSide(color: _primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
          minimumSize: const Size(100, 0),
          textStyle: _text.button!,
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
      border: OutlineInputBorder(
        borderSide: BorderSide(),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
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
        // type: BottomNavigationBarType.shifting,
        selectedItemColor: _primary,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedItemColor: _primary.withAlpha(150),
      );

  ThemeData get theme => ThemeData(
        fontFamily: 'Mulish',
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
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
      );
}
