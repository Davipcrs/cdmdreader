// List the recently opened files
import 'package:flutter_riverpod/flutter_riverpod.dart';

final markdownDataProvider =
    AsyncNotifierProvider.autoDispose<MarkdownDataNotifier, String>(
      MarkdownDataNotifier.new,
    );

class MarkdownDataNotifier extends AsyncNotifier<String> {
  @override
  build() async {
    return '';
  }

  Future<void> changeString({required String newString}) async {
    state = AsyncData(newString);
  }
}
