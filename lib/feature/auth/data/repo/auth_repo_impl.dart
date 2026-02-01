import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracing_app/feature/auth/data/models/user_model.dart';
import 'package:tracing_app/feature/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepoImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore;

  @override
  Future<Either<String, UserModel>> signUp({
    required UserModel userModel,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );
      final newUser = UserModel(
        uid: credential.user!.uid,
        username: userModel.username,
        email: userModel.email,
        userType: userModel.userType,
      );
      await _firebaseFirestore
          .collection('users')
          .doc(newUser.uid)
          .set(newUser.toMap());
      return Right(newUser);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseErrorToMessage(e.code));
    } catch (e) {
      return Left('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userDoc =
          await _firebaseFirestore
              .collection('users')
              .doc(credential.user!.uid)
              .get();
      if (!userDoc.exists) {
        return Left('بيانات المستخدم غير موجودة.');
      }
      final user = UserModel.fromFirestore(userDoc);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(_mapFirebaseErrorToMessage(e.code));
    } catch (e) {
      return Left('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, UserModel>> getCurrentUser() async {
    try {
      // 1. تحقق مما إذا كان هناك مستخدم مسجل دخوله حاليًا في Firebase Auth
      final firebaseUser = _firebaseAuth.currentUser;

      // 2. إذا لم يكن هناك مستخدم، أرجع خطأ
      if (firebaseUser == null) {
        return const Left('لا يوجد مستخدم مسجل دخوله حالياً.');
      }

      // 3. إذا كان هناك مستخدم، قم بجلب بياناته الكاملة من Firestore
      final userDoc =
          await _firebaseFirestore
              .collection('users')
              .doc(firebaseUser.uid)
              .get();

      // 4. تحقق مما إذا كانت بيانات المستخدم موجودة في Firestore
      if (!userDoc.exists) {
        // هذه حالة نادرة ولكنها ممكنة (مستخدم مسجل دخوله ولكن لا توجد بيانات له)
        return const Left('بيانات المستخدم غير موجودة في قاعدة البيانات.');
      }

      // 5. قم بتحويل المستند إلى UserModel وأرجعه
      final user = UserModel.fromFirestore(userDoc);
      return Right(user);
    } catch (e) {
      // في حالة حدوث أي خطأ أثناء جلب البيانات
      return Left('فشل جلب بيانات المستخدم: ${e.toString()}');
    }
  }

  String _mapFirebaseErrorToMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً.';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل.';
      case 'user-not-found':
        return 'لا يوجد مستخدم بهذا البريد الإلكتروني.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة.';
      default:
        return 'حدث خطأ: $code';
    }
  }
}
