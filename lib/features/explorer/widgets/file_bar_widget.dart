import 'package:cdmdreader/features/explorer/logic/load_file.dart';
import 'package:cdmdreader/features/explorer/logic/local_storage_string_generator.dart';
import 'package:cdmdreader/states/local_storage_state.dart';
import 'package:cdmdreader/states/markdown_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Converted
class FileBarWidget extends ConsumerWidget {
  const FileBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listData = ref.watch(localStorageListProvider);
    return listData.when(
      data: (listData) {
        if (listData.isEmpty) {
          return const Center(child: Text("No history"));
        }
        return ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            // Get the file name without the entire path
            final item = reverseStorageString(storageString: listData[index]);
            // Now display that inside a InkWell

            return Padding(
              padding: const EdgeInsets.all(8.0),

              child: InkWell(
                onTap: () async {
                  String path = item[1];
                  String fileData = await loadFile(filePath: path);
                  ref
                      .read(markdownDataProvider.notifier)
                      .changeString(newString: fileData);
                  ref
                      .read(currentSelectedPathProvider.notifier)
                      .setPath(newPath: path);
                },
                child: Text(
                  item[0], // Use [0] as the reverseStorageString also gets the path
                ),
              ),
            );
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return const Center(child: Text("Error loading history"));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
