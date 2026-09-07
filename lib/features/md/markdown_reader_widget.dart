import 'package:cdmdreader/features/md/custom_syntax_highlighter.dart';
import 'package:cdmdreader/states/markdown_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MarkdownReaderWidget extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markdownData = ref.watch(markdownDataProvider);

    return markdownData.when(
      data: (mdData) {
        return Markdown(
          selectable: true,
          data: mdData,
          syntaxHighlighter: CustomSyntaxHighlighter(
            defaultColor: Theme.of(context).colorScheme.onSurface,
          ),
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            h1: Theme.of(context).textTheme.headlineMedium,
            code: GoogleFonts.jetBrainsMono().copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            codeblockDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            blockquotePadding: const EdgeInsets.all(12),
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Center(child: Text("Error loading data"));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
