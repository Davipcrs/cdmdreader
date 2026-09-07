import 'dart:io';

Future<String> loadFile({required String filePath}) async {
  try {
    final file = File(filePath);

    // Check if the file exists before attempting to read
    if (await file.exists()) {
      // Read contents as a UTF-8 encoded string
      String contents = await file.readAsString();
      return contents;
    } else {
      return ('File does not exist at path: $filePath');
    }
  } catch (e) {
    return ('Error reading file: $e');
  }
}
