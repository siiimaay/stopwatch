import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stopwatch/core/service/auth/i_auth_service.dart';
import 'package:stopwatch/features/auth/data/user.dart' as account;

class LoginService implements IAuthService {
  static LoginService? _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  LoginService._();

  factory LoginService() {
    return _instance ??= LoginService._();
  }

  @override
  Future<User?> signUp(
    String email,
    String password,
    String phoneNumber,
    String country,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userAccountInfo = account.User(
        username: email,
        phoneNumber: phoneNumber,
        countryCode: country,
      ).toJson();

      await _firebaseFirestore
          .collection('users')
          .doc(result.user!.uid)
          .set(userAccountInfo);
      return result.user;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
