import 'package:flutter_test/flutter_test.dart';
import 'package:mynotes/services/auth/auth_exeptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';

void main() {
  group("Authentication", () {
    final provider = MockAuthProvider();

    test("Sould not be initialized to begin with", () {
      expect(provider._initialized, false);
    });

    test("Cannot log out if not initialized", () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test("Should be able to initialize", () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test("User should be null after initialization", () {
      expect(provider.currentUser, null);
    });

    test("Should not be initialized in less than 2 seconds", () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));

    test("Create user should delegate to login function", () async {
      final badEmailUser = provider.createUser(
        email: "aryan.gholamiii@gmail.com",
        password: "123456",
      );
      expect(badEmailUser,
          throwsA(const TypeMatcher<InvalidCredentialAuthExeption>()));
      final badPasswordUser = provider.createUser(
        email: "madhi.gholami875@gmail.com",
        password: "aryangh11",
      );
      expect(badPasswordUser,
          throwsA(const TypeMatcher<InvalidCredentialAuthExeption>()));
      final user = await provider.createUser(
          email: "mahdi.gholami875@gmail.com", password: "12345");
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test("Logged in user should be able to get verified", () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test("Should be able to log out and log in again", () async {
      await provider.logOut();
      await provider.login(
        email: "email",
        password: "password",
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _initialized = false;
  bool get isInitialized => _initialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!_initialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return login(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _initialized = true;
  }

  @override
  Future<void> logOut() async {
    if (!_initialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthExeption();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) {
    if (!_initialized) throw NotInitializedException();
    if (email == "aryan.gholamiii@gmail.com" || password == "aryangh11") {
      throw InvalidCredentialAuthExeption();
    }
    const user = AuthUser(
      id: "my_id",
      isEmailVerified: false,
      email: "aryan.gholamiii@gmail.com",
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!_initialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthExeption();
    const newUser = AuthUser(
      id: "my_id",
      isEmailVerified: true,
      email: "aryan.gholamiii@gmail.com",
    );
    _user = newUser;
  }
}
