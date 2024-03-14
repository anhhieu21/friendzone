import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';

class CompressFile {
  static Future<File> compressAndGetFile(File file, String targetPath) async {
    // Ensure targetPath is different from the source path
    if (targetPath == file.path) {
      // Append a different file name to the target directory
      String newFileName =
          'friendzone_${DateTime.now().millisecondsSinceEpoch}.jpg';
      targetPath = join(dirname(targetPath), newFileName);
    }

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 60,
    );

    return File(result!.path);
  }
}
