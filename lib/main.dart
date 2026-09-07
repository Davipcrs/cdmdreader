import 'package:cdmdreader/features/explorer/widgets/file_bar_widget.dart';
import 'package:cdmdreader/features/md/markdown_reader_widget.dart';
import 'package:cdmdreader/features/menu/custom_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_utils/mini_utils.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            CustomMenuBar(),
            // Main Content
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 1, child: FileBarWidget()),
                  Expanded(flex: 6, child: MarkdownReaderWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
      theme: cdevSuiteLightTheme,
      darkTheme: cdevSuiteDarkTheme,
    );
  }
}
