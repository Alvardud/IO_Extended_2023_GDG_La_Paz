import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_auth.dart';
import 'iauth.dart';

class Auth extends IAuth {
  final _auth = FirebaseAuth.instance;

  /// create account with Eamil and Password
  @override
  Future<String> createUserWithEmailAndPassword(UserAuth user,
      {bool verified = false}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      if (verified) {
        await userCredential.user?.sendEmailVerification();
      }
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw ArgumentError(e.code);
    }
  }

  @override
  Future<String> signInWithEmailAndPassword(UserAuth user,
      {bool verified = false}) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      // if (verified) {
      //   if (!userCredential.user!.emailVerified) {
      //     await userCredential.user!.sendEmailVerification();
      //     await _auth.signOut();
      //     throw 'Unverified email, please check your email for instructions.';
      //   }
      // }
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print('code: ${e.code}, message: ${e.message}');
      throw ArgumentError(e.code);
    }
  }

  @override
  Future<bool> isLogged() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  @override
  Future<void> reload() async {
    User? user = _auth.currentUser;
    await user?.reload();
  }

  @override
  User getUser() {
    return _auth.currentUser!;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// return true if email exist
  @override
  Future<bool> checkExistUser(String email) async {
    final response = await _auth.fetchSignInMethodsForEmail(email);
    return response.isNotEmpty;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ArgumentError(e.message);
    }
  }

  @override
  String? getUid() {
    User? user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  @override
  Future<void> updateEmail(String newEmail, String password) async {
    User? user = _auth.currentUser;
    try {
      final userCredential = await user!.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: user.email!, password: password));
      await userCredential.user!.updateEmail(newEmail);
      await userCredential.user!.sendEmailVerification();
      await reload();
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerify() async {
    final isVerified = _auth.currentUser!.emailVerified;
    if (!isVerified) {
      await _auth.currentUser!.reload();
      final verifiedCurrent = _auth.currentUser!.emailVerified;
      // if (!verifiedCurrent) _auth.currentUser!.sendEmailVerification();
      return verifiedCurrent;
    }
    return isVerified;
  }

  @override
  Future<void> deleteAuth() async {
    await _auth.currentUser!.delete();
  }

  @override
  Future<void> updatePassword(UserAuth user, String newPassword) async {
    final userAuth = _auth.currentUser;
    if (userAuth != null) {
      try {
        UserCredential userCredential = await userAuth
            .reauthenticateWithCredential(EmailAuthProvider.credential(
                email: user.email, password: user.password));
        await userCredential.user!.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        throw e.message!;
      }
    } else {
      throw 'Sign out and sign in again.';
    }
  }
}
