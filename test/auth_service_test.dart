import 'package:flutter_test/flutter_test.dart';
import 'package:study_bud/auth_service.dart';

void main() {
  group('AuthService Tests', () {
    test('signIn - Successful', () async {
      final authService = AuthService();
      final user = await authService.signIn(
          email: 'test@example.com', password: 'password');
      expect(user, isNotNull);
    });

    test('signIn - Unsuccessful', () async {
      final authService = AuthService();
      final user = await authService.signIn(
          email: 'nonexistent@example.com', password: 'wrongpassword');
      expect(user, isNull);
    });

    test('signUp - Successful', () async {
      final authService = AuthService();
      final user = await authService.signUp(
          email: 'newuser@example.com', password: 'newpassword');
      expect(user, isNotNull);
    });

    test('signUp - Unsuccessful', () async {
      final authService = AuthService();
      final user = await authService.signUp(
          email: 'test@example.com', password: 'password');
      expect(user, isNull);
    });

    test('signOut', () async {
      final authService = AuthService();
      await authService.signOut();
      expect(authService.getCurrentUser(), isNull);
    });

    test('getCurrentUser', () {
      final authService = AuthService();
      final user = authService.getCurrentUser();
      expect(user, isNull);
    });
  });
}
