import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String userType;

  const UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.userType,
  });

  // Factory لإنشاء UserModel من مستند Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id, // جلب الـ uid مباشرة من الـ Document ID
      username: data['username'] ?? 'بدون اسم', // قيمة افتراضية لو الحقل مفقود
      email: data['email'] ?? '',
      userType: data['userType'] ?? 'طالب', // قيمة افتراضية
    );
  }

  // لتحويل UserModel إلى Map لحفظه في Firestore
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'userType': userType,
      // ملاحظة: لا نحفظ الـ uid هنا لأنه هو Document ID
    };
  }

  // دالة copyWith لتحديث بيانات المستخدم بسهولة
  UserModel copyWith({String? username, String? userType}) {
    return UserModel(
      uid: this.uid, // الـ uid لا يتغير أبداً
      username: username ?? this.username,
      email: this.email, // البريد عادةً ما يُغير من مكان آخر
      userType: userType ?? this.userType,
    );
  }

  // لسهولة الطباعة والتصحيح
  @override
  String toString() =>
      'UserModel(uid: $uid, username: $username, userType: $userType)';

  // Equatable يحتاجها لمقارنة الكائنات
  @override
  List<Object> get props => [uid, username, email, userType];
}
