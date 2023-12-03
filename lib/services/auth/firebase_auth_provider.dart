import 'package:firebase_auth/firebase_auth.dart' as fire_base;
import 'package:mynotes/services/auth/auth_exeptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await fire_base.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthExeption();
      }
    } on fire_base.FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw WeakPasswordAuthExeption();
      } else if (e.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthExeption();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthExeption();
      } else {
        throw GenericAuthExeption();
      }
    } catch (_) {
      throw GenericAuthExeption();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = fire_base.FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    final user = fire_base.FirebaseAuth.instance.currentUser;
    if (user != null) {
      await fire_base.FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthExeption();
    }
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      await fire_base.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw InvalidCredentialAuthExeption();
      }
    } on fire_base.FirebaseAuthException catch (e) {
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        throw InvalidEmailAuthExeption();
      } else {
        throw GenericAuthExeption();
      }
    } catch (_) {
      throw GenericAuthExeption();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = fire_base.FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthExeption();
    }
  }
}
