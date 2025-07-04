import 'package:flutter/material.dart';

import 'resources/colors.dart';

/// CreateDate: 2025/7/4 16:04
/// Author: Lee
/// Description:

const kZhDefaultFont = '青鸟华光繁仿宋';
const kEnDefaultFont = 'NoteScript-SemiBold';

const kTFBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(4.0)),
  borderSide: BorderSide(color: MyColors.defaultColor),
);

const fonts = [
  '汉仪篆书繁',
  '思源黑体',
  '青鸟华光繁仿宋',
  '鼎猎宋刻体',
  '鼎猎伙伴体',
  '周字方体',
  '鼎猎珠海体',
  '周字宋体',
  '猫啃忘形圆',
  '文鼎PL简报宋',
  '文鼎PL细上海宋',
  '小可奶酪体',
  '飞花宋体',
  '三极素纤简体',
];

final lightTheme = ThemeData(
  fontFamily: kEnDefaultFont,
  fontFamilyFallback: [kZhDefaultFont],
  colorScheme: ColorScheme.fromSeed(
    seedColor: MyColors.defaultColor,
    primary: MyColors.defaultColor,
    onPrimary: Colors.white,
    secondary: MyColors.defaultColor,
    onSecondary: Colors.white,
    error: MyColors.defaultColor,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      hoverColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      overlayColor: Colors.transparent,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFFFC2958);
      }
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(Colors.white),
    side: const BorderSide(color: Color(0xFFC8C9CB)),
    shape: const CircleBorder(),
    splashRadius: .0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent,
    isCollapsed: true,
    border: kTFBorder,
    isDense: true,
    labelStyle: const TextStyle(color: Color(0xFF95979C)),
    floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return const TextStyle(color: MyColors.defaultColor);
      }
      return const TextStyle(color: Color(0xFFC4C8D7));
    }),
    enabledBorder: kTFBorder.copyWith(
      borderSide: BorderSide(color: MyColors.disableColor),
    ),
    disabledBorder: kTFBorder.copyWith(
      borderSide: BorderSide(color: MyColors.disableColor),
    ),
    errorBorder: kTFBorder.copyWith(
      borderSide: BorderSide(color: MyColors.errorColor),
    ),
    focusedErrorBorder: kTFBorder.copyWith(
      borderSide: BorderSide(color: MyColors.errorColor),
    ),
    focusedBorder: kTFBorder,
    errorStyle: const TextStyle(color: MyColors.errorColor),
    counterStyle: const TextStyle(color: MyColors.defaultColor),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    displayMedium: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    displaySmall: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    headlineLarge: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    headlineMedium: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    headlineSmall: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    bodySmall: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    bodyMedium: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    bodyLarge: TextStyle(
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      color: MyColors.defaultColor,
      fontFamily: kEnDefaultFont,
      fontFamilyFallback: [kZhDefaultFont],
    ),
  ),
);
