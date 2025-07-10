import 'package:flutter/material.dart';

import 'resources/colors.dart';

/// CreateDate: 2025/7/4 16:04
/// Author: Lee
/// Description:

const fontFamily = 'NoteScript-SemiBold';
const fontFamilyFallback = ['NoteScript-SemiBold', '青鸟华光繁仿宋'];

const kTFBorder = OutlineInputBorder(
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
  'NoteScript-SemiBold',
];

final lightTheme = ThemeData(
  fontFamily: fontFamily,
  fontFamilyFallback: fontFamilyFallback,
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
      borderSide: const BorderSide(color: MyColors.disableColor),
    ),
    disabledBorder: kTFBorder.copyWith(
      borderSide: const BorderSide(color: MyColors.disableColor),
    ),
    errorBorder: kTFBorder.copyWith(
      borderSide: const BorderSide(color: MyColors.errorColor),
    ),
    focusedErrorBorder: kTFBorder.copyWith(
      borderSide: const BorderSide(color: MyColors.errorColor),
    ),
    focusedBorder: kTFBorder,
    errorStyle: const TextStyle(color: MyColors.errorColor),
    counterStyle: const TextStyle(color: MyColors.defaultColor),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    displayMedium: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    displaySmall: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    headlineLarge: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    headlineMedium: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    headlineSmall: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    bodySmall: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    bodyMedium: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    bodyLarge: TextStyle(
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      color: MyColors.textColor,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
      ),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return BorderSide.none;
        }
        return const BorderSide(color: MyColors.defaultColor);
      }),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontSize: 14.0,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontWeight: FontWeight.w600,
        ),
      ),
      minimumSize: const WidgetStatePropertyAll(Size(.0, 40.0)),
      alignment: Alignment.center,
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 14.0),
      ),
      iconSize: const WidgetStatePropertyAll(16.0),
      backgroundColor: const WidgetStatePropertyAll(Colors.white),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.white),
      foregroundColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return MyColors.disableColor;
        }
        return Colors.white;
      }),
      elevation: const WidgetStatePropertyAll(4.0),
      shadowColor: const WidgetStatePropertyAll(MyColors.defaultColor),
      overlayColor: const WidgetStatePropertyAll(MyColors.defaultColor),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    elevation: 6.0,
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    ),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const TextStyle(
          color: MyColors.disableColor,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
        );
      }
      return const TextStyle(
        color: MyColors.defaultColor,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
      );
    }),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    menuStyle: MenuStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      backgroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
);
