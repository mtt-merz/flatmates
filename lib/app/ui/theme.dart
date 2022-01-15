import 'package:flutter/material.dart';

class CustomThemeData {
  final _scaffoldBackground = Colors.blueGrey[50];
  final _primary = ThemeData.light().primaryColor;

  final _radius = 14.0;
  final _horizontalPadding = 12.0;

  /// Text
  final _text = const TextTheme(
    headline4: TextStyle(
      fontWeight: FontWeight.w500,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    headline6: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    subtitle1: TextStyle(
      fontSize: 15,
    ),
    // bodyText2: const TextStyle(
    //   fontSize: 16.0,
    //   fontWeight: FontWeight.w500,
    // ),
    button: TextStyle(
      fontWeight: FontWeight.bold,
    ),
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(_radius))),
        alignment: Alignment.bottomCenter,
      );

  /// Card
  get _card => CardTheme(
        color: Colors.white,
        elevation: 0.0,
        margin: EdgeInsets.symmetric(horizontal: _horizontalPadding)
            .add(const EdgeInsets.only(top: 12.0)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(_radius))),
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
  get _textButton => const TextButtonThemeData(style: ButtonStyle());

  /// BottomSheet
  get _bottomSheet => const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      );

  /// InputDecoration
  get _inputDecoration {
    final border = OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(_radius)));

    return InputDecorationTheme(
      isCollapsed: false,
      border: border,
      focusedBorder: border,
      disabledBorder: border,
      enabledBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      filled: true,
      fillColor: _scaffoldBackground,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
        showSelectedLabels: false,
        selectedItemColor: _primary,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedItemColor: _primary.withAlpha(150),
      );

  ThemeData get theme => ThemeData(
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
