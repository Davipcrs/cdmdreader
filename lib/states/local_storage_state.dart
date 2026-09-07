import 'package:cdmdreader/features/explorer/logic/recent_files_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// List the recently opened files
final localStorageListProvider =
    AsyncNotifierProvider.autoDispose<LocalStorageListNotifier, List<String>>(
      LocalStorageListNotifier.new,
    );

class LocalStorageListNotifier extends AsyncNotifier<List<String>> {
  @override
  build() async {
    return await SecureDocumentStorage.readList();
  }
}

final currentSelectedPathProvider =
    NotifierProvider.autoDispose<CurrentSelectPathNotifier, String>(
      CurrentSelectPathNotifier.new,
    );

class CurrentSelectPathNotifier extends Notifier<String> {
  @override
  String build() {
    return 'No file open';
  }

  void setPath({required String newPath}) {
    state = newPath;
  }
}
