import 'package:flutter/material.dart';

class AppTextStyles {
  // === الخط المستخدم (اختياري) ===
  // يمكنك استخدام خط مثل "Cairo" للتطبيقات العربية
  // تأكد من إضافته في ملف pubspec.yaml
  // static const String fontFamily = 'Cairo';

  // === أحجام الخطوط (Font Sizes) ===
  static const double displayLargeSize = 57.0;
  static const double displayMediumSize = 45.0;
  static const double displaySmallSize = 36.0;

  static const double headlineLargeSize = 32.0;
  static const double headlineMediumSize = 28.0;
  static const double headlineSmallSize = 24.0;

  static const double titleLargeSize = 22.0;  // عنوان AppBar
  static const double titleMediumSize = 16.0; // عنوان البطاقات والأقسام
  static const double titleSmallSize = 14.0;  // عناوين صغيرة

  static const double bodyLargeSize = 16.0;   // نصوص رئيسية
  static const double bodyMediumSize = 14.0;  // النص الاعتيادي
  static const double bodySmallSize = 12.0;   // نصوص توضيحية صغيرة

  static const double labelLargeSize = 14.0;  // نص داخل الأزرار
  static const double labelMediumSize = 12.0; // نص داخل الحقول (Label)
  static const double labelSmallSize = 11.0;  // نصوص صغيرة جدًا

  // === أوزان الخطوط (Font Weights) ===
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight regular = FontWeight.w400;

  // === أنماط النصوص الأساسية (بدون لون) ===
  // سنحدد اللون لاحقًا في الثيم

  static TextStyle get displayLarge => const TextStyle(
        fontSize: displayLargeSize,
        fontWeight: bold,
        // fontFamily: fontFamily,
        height: 1.2,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontSize: displayMediumSize,
        fontWeight: bold,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get displaySmall => const TextStyle(
        fontSize: displaySmallSize,
        fontWeight: semiBold,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get headlineLarge => const TextStyle(
        fontSize: headlineLargeSize,
        fontWeight: semiBold,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get headlineMedium => const TextStyle(
        fontSize: headlineMediumSize,
        fontWeight: semiBold,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get headlineSmall => const TextStyle(
        fontSize: headlineSmallSize,
        fontWeight: semiBold,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get titleLarge => const TextStyle(
        fontSize: titleLargeSize,
        fontWeight: bold,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontSize: titleMediumSize,
        fontWeight: bold,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontSize: titleSmallSize,
        fontWeight: medium,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontSize: bodyLargeSize,
        fontWeight: regular,
        // fontFamily: fontFamily,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: bodyMediumSize,
        fontWeight: regular,
        // fontFamily: fontFamily,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: bodySmallSize,
        fontWeight: regular,
        // fontFamily: fontFamily,
        height: 1.4,
      );

  static TextStyle get labelLarge => const TextStyle(
        fontSize: labelLargeSize,
        fontWeight: medium,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontSize: labelMediumSize,
        fontWeight: medium,
        // fontFamily: fontFamily,
        height: 1.3,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontSize: labelSmallSize,
        fontWeight: medium,
        // fontFamily: fontFamily,
        height: 1.3,
      );
}