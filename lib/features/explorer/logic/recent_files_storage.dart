import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureDocumentStorage {
  static const _storage = FlutterSecureStorage();
  static const _storageKey = 'recent_documents_list';

  /// Read stored list directly
  static Future<List<String>> readList() async {
    final jsonString = await _storage.read(key: _storageKey);
    if (jsonString == null) return [];

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.cast<String>();
  }

  /// Add a string to the list dynamically
  static Future<void> addStorageString({required String storageString}) async {
    final currentList = await readList();

    // Prevent duplicates (optional)
    if (!currentList.contains(storageString)) {
      currentList.insert(0, storageString); // Add to top of list

      await _storage.write(key: _storageKey, value: jsonEncode(currentList));
    }
  }

  /// Remove a string by value
  static Future<void> removePath(String pathValue) async {
    final currentList = await readList();
    currentList.remove(pathValue);

    await _storage.write(key: _storageKey, value: jsonEncode(currentList));
  }
}
