import 'package:flutter/material.dart';

class AppColors {
  // 🌞 الوضع النهاري (Light) - تم التعديل بالكامل للثيم الأزرق
  static const Color lightPrimary =
      Color(0xFF0A0A3C); // لون أزرق داكن مختلف للـ AppBar/FAB عشان يميز عن الخلفية

  static const Color lightBackground =
      Color.fromARGB(255, 93, 172, 196); // 🎨 الخلفية الزرقاء الداكنة التي طلبتها

  static const Color lightSurface =
      Color(0xFFFFFFFF); // 🎨 لون أبيض للكروت والأزرار

  static const Color lightBubbleSent =
      Color(0xFFFFFFFF); // نفس لون السطح (أبيض)

  static const Color lightText =
      Color(0xFFFFFFFF); // 🎨 النص الأساسي على الخلفية الزرقاء (أبيض)

  static const Color lightIcon =
      Color(0xFF8080FF); // 🎨 أيقونات بلون أزرق فاتح للظهور على الخلفية الزرقاء

  // 🌙 الوضع الليلي (Dark) - يمكنك إبقاؤه كما هو أو تعديله لاحقًا
  static const Color darkPrimary = Color(0xFF4D4DFF);
  static const Color darkBackground = Color(0xFF000022);
  static const Color darkSurface = Color(0xFF0A0A3C);
  static const Color darkBubbleSent = Color(0xFF2E33CC);
  static const Color darkText = Color(0xFFEDEEFF);
  static const Color darkIcon = Color(0xFFB5B8FF);

  // ❌ / ✅ حالات
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF4CAF50);
}