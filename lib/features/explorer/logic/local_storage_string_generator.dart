String genStorageString({required String fileName, required String? filePath}) {
  String storageString = "$fileName///${filePath!}";
  return storageString;
}

bool checkStorageString({
  required String storageString,
  required String fileName,
  required String? filePath,
}) {
  // The formatted string
  //String storageString = "document.pdf///path/to/file";

  // Split the string into components
  List<String> parts = storageString.split('///');

  String extractedFileName = parts[0];
  String extractedFilePath = parts[1];

  if (parts.length != 2) {
    return false;
  }

  bool isFileNameMatch = extractedFileName == fileName;
  bool isFilePathMatch = extractedFilePath == (filePath ?? '');

  return isFileNameMatch && isFilePathMatch;
}

List<String> reverseStorageString({required String storageString}) {
  List<String> returnData = storageString.split('///');
  return returnData;
}
