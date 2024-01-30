import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/services/storage/storage_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late StorageServiceImpl storageService;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    storageService = StorageServiceImpl(sharedPreferences: sharedPreferences);
  });

  test('core/services/storage - get/setBool', () async {
    const key = 'key';
    const value = true;

    await storageService.setBool(key, value);
    final result = storageService.getBool(key);

    expect(result, value);
  });

  test('core/services/storage - get/setDouble', () async {
    const key = 'key';
    const value = 1.0;

    await storageService.setDouble(key, value);
    final result = storageService.getDouble(key);

    expect(result, value);
  });

  test('core/services/storage - get/setInt', () async {
    const key = 'key';
    const value = 1;

    await storageService.setInt(key, value);
    final result = storageService.getInt(key);

    expect(result, value);
  });

  test('core/services/storage - get/setString', () async {
    const key = 'key';
    const value = 'value';

    await storageService.setString(key, value);
    final result = storageService.getString(key);

    expect(result, value);
  });
}
