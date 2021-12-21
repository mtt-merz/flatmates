import 'package:flutter/material.dart';

class CustomThemeData {
  final _scaffoldBackground = Colors.blueGrey[50];
  final _radius = 20.0;
  final _primary = ThemeData.light().primaryColor;

  /// Text
  final _text = TextTheme(
    headline4: TextStyle(
      color: Colors.blueGrey[700],
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      fontSize: 18,
    ),
    // bodyText2: const TextStyle(
    //   fontSize: 16.0,
    //   fontWeight: FontWeight.w500,
    // ),
    button: const TextStyle(fontSize: 16.0),
  );

  /// AppBar
  get _appBar => AppBarTheme(
      // titleTextStyle: _text.headline4,
      // centerTitle: true,
      // color: Colors.transparent,
      // elevation: 0.0,
      // toolbarHeight: 80.0,
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
        margin: const EdgeInsets.symmetric(horizontal: 12.0)
            .add(const EdgeInsets.only(top: 12.0)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(_radius))),
      );

  /// ListTile
  get _listTile => const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        horizontalTitleGap: 12,
      );

  /// Divider
  get _divider => DividerThemeData(
        thickness: 1.5,
        color: _scaffoldBackground,
        space: 0.0,
        indent: 10.0,
        endIndent: 10.0,
      );

  /// OutlinedButton
  get _outlinedButton => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          // visualDensity: VisualDensity.comfortable,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          elevation: 0.0,
          side: BorderSide(color: _primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
          minimumSize: const Size(130.0, .0),
        ),
      );

  /// ElevatedButton
  get _elevatedButton => ElevatedButtonThemeData(
          style: ButtonStyle(
        visualDensity: _outlinedButton.style!.visualDensity,
        padding: _outlinedButton.style!.padding,
        elevation: _outlinedButton.style!.elevation,
        shape: _outlinedButton.style!.shape,
        textStyle: MaterialStateProperty.all(_text.button!.copyWith(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          letterSpacing: .5,
        )),
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
        borderRadius: BorderRadius.all(Radius.circular(_radius / 2)));

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

  ThemeData get theme => ThemeData(
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
      );
}
