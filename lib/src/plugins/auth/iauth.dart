// import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_auth.dart';


/// Abstract class for all Auth type requests,
/// to handle dependency injection 
abstract class IAuth {
  /// Create account with email and password in Firebase Authentication.
  /// Return your id.
  Future<String> createUserWithEmailAndPassword(UserAuth user, {bool verified = false});
  /// Method to sign in with email and password
  Future<String> signInWithEmailAndPassword(UserAuth user, {bool verified = false});
  /// Check if the user is logged in
  Future<bool> isLogged();
  /// Refresh user when logged in
  Future<void> reload();
  /// Get uid user logged
  String? getUid();
  /// signOut
  Future<void> signOut();
  /// Check if an email is registered
  Future<bool> checkExistUser(String email);
  /// Reset password when forgotten
  Future<void> sendPasswordResetEmail(String email);
  /// Change email
  Future<void> updateEmail(String newEmail, String password);
  /// Send Email Verification
  Future<void> sendEmailVerification();
  /// Send Email Verification
  Future<void> deleteAuth();
  /// Check that the email is verified
  Future<bool> isEmailVerify();
  /// get User
  User getUser();

  Future<void> updatePassword(UserAuth user, String newPassword);
}
