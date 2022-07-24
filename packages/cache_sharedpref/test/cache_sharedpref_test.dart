import 'package:cache_sharedpref/cache_sharedpref.dart';
import 'package:flutter_test/flutter_test.dart';

Future main() async {
  var csf = CacheSharedPref();
  test('saving and load string', () async {
    expect(await csf.save<String>(key: 'email', value: 'test@email.com'), true);
    expect(await csf.load('email'), 'test@email.com');
  });
}
