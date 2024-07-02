import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ExternalJsonGenerator {
  static void saveJsonDataToDownloadsFolder(
       String jsonString, String fileName) async {
    try {
      // Get the Downloads directory
      Directory targetDirectory = await getTargetDirectory() ?? Directory('');

      log('${targetDirectory.path}/$fileName', name: 'Download directry');

      // // Create a File reference with the desired file name
      File file = File('${targetDirectory.path}/$fileName');

      // Convert the JSON data to a string
      // String jsonString = jsonEncode(jsonData);

      // Write the JSON data to the file
      await file.writeAsString(jsonString);

      print('File saved to: ${file.path}');
    } catch (e) {
      print('Error saving file: $e');
    }
  }

 static Future<Directory?> getTargetDirectory() async {
    // Get the Downloads directory on iOS
    if (Platform.isIOS) {
      return await getDownloadsDirectory();
    }
    // Get the external storage directory on Android
    else if (Platform.isAndroid) {
      return await getExternalStorageDirectory();
    }
    // Handle other platforms if necessary
    else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}