import 'package:cdmdreader/features/explorer/logic/load_file.dart';
import 'package:cdmdreader/features/explorer/logic/local_storage_string_generator.dart';
import 'package:cdmdreader/features/explorer/logic/recent_files_storage.dart';
import 'package:file_picker/file_picker.dart';

Future<List<String>> getPickedFile() async {
  final PlatformFile? file = await FilePicker.pickFile(
    allowedExtensions: ["md", "txt"],
  );

  if (file != null) {
    String fileName = file.name;
    String? filePath = file.path;

    // Validade if storageString is reversible
    // save storage string
    String storageString = genStorageString(
      fileName: fileName,
      filePath: filePath,
    );

    if (checkStorageString(
      storageString: storageString,
      fileName: fileName,
      filePath: filePath,
    )) {
      // Save to recent files
      SecureDocumentStorage.addStorageString(storageString: storageString);
    }

    List<String> returnData = List.empty(growable: true);
    returnData.add(await loadFile(filePath: filePath!));
    returnData.add(filePath);

    return returnData;
  } else {
    List<String> returnData = List.empty(growable: true);
    returnData.add("File not opened");
    returnData.add("No file open");
    return returnData;
  }
}
