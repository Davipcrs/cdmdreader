// Window Control Buttons using window_manager
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomWindowButtons extends StatelessWidget {
  const CustomWindowButtons({super.key});
  // Custom behavior for the minimize, maximize and close buttons

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 16, color: Colors.white),
          onPressed: () => windowManager.minimize(),
        ),
        IconButton(
          icon: const Icon(Icons.crop_square, size: 16, color: Colors.white),
          onPressed: () async {
            if (await windowManager.isMaximized()) {
              windowManager.unmaximize();
            } else {
              windowManager.maximize();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 16, color: Colors.white),
          hoverColor: Colors.red,
          onPressed: () => windowManager.close(),
        ),
      ],
    );
  }
}
