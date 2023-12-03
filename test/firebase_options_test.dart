import 'package:flutter_test/flutter_test.dart';
import 'package:study_bud/firebase_options.dart';

void main() {
  test('DefaultFirebaseOptions - Web', () {
    final options = DefaultFirebaseOptions.currentPlatform;
    expect(options, isNotNull);
    expect(options.apiKey, 'your_web_api_key');
  });

  test('DefaultFirebaseOptions - Android', () {
    final options = DefaultFirebaseOptions.currentPlatform;
    expect(options, isNotNull);
    expect(options.apiKey, 'your_android_api_key');
  });

  test('DefaultFirebaseOptions - iOS', () {
    final options = DefaultFirebaseOptions.currentPlatform;
    expect(options, isNotNull);
    expect(options.apiKey, 'your_ios_api_key');
  });
}
