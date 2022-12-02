import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageFrave {
  final secureStorage = const FlutterSecureStorage();

  Future<void> persistenToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  Future<String?> readToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> persistenId(String token) async {
    await secureStorage.write(key: 'uuid', value: token);
  }

  Future<String?> readId() async {
    return await secureStorage.read(key: 'uuid');
  }

  Future<void> deleteSecureStorage() async {
    await secureStorage.delete(key: 'token');
    await secureStorage.delete(key: 'uuid');
    await secureStorage.deleteAll();
  }
}

final secureStorage = SecureStorageFrave();
