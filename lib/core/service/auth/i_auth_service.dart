import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<User?> signUp(
    String email,
    String password,
    String phoneNumber,
    String country,
  );

  Future<void> signIn(String email, String password) async {}

  Future<void> signOut() async {}
}
