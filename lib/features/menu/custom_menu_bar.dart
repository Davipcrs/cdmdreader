import 'package:cdmdreader/features/explorer/widgets/open_file_picker.dart';
import 'package:cdmdreader/features/menu/custom_window_buttons.dart';
import 'package:cdmdreader/states/local_storage_state.dart';
import 'package:cdmdreader/states/markdown_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class CustomMenuBar extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String openedFilePath = ref.watch(currentSelectedPathProvider);
    return Container(
      height: 40,
      color: Colors.grey[900],
      child: Row(
        children: [
          // Native Flutter MenuBar
          MenuBar(
            style: const MenuStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              elevation: WidgetStatePropertyAll(0),
            ),
            children: [
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () async {
                      List<String> data = await getPickedFile();
                      ref
                          .read(markdownDataProvider.notifier)
                          .changeString(newString: data[0]);
                      ref.invalidate(localStorageListProvider);
                      ref
                          .read(currentSelectedPathProvider.notifier)
                          .setPath(newPath: data[1]);
                    },
                    child: const Text('Load File'),
                  ),
                  MenuItemButton(
                    onPressed: () => windowManager.close(),
                    child: const Text('Exit'),
                  ),
                ],
                child: const Text(
                  'File',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          // Draggable space taking up remaining width
          Expanded(
            child: DragToMoveArea(
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: Text(
                  openedFilePath,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            ),
          ),

          // Native Window Buttons
          const CustomWindowButtons(),
        ],
      ),
    );
  }
}
