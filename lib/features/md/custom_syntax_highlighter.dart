// 1. Create a custom highlighter by extending SyntaxHighlighter
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class CustomSyntaxHighlighter extends SyntaxHighlighter {
  CustomSyntaxHighlighter({required this.defaultColor});

  final Color defaultColor;
  @override
  TextSpan format(String source) {
    final List<TextSpan> spans = [];
    final words = source.split(' ');

    for (final word in words) {
      // Highlight Dart keywords
      if ([
        'void',
        'main',
        'final',
        'const',
        'import',
        'class',
      ].contains(word)) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(color: defaultColor),
          ),
        );
      }
    }

    return TextSpan(children: spans);
  }
}
