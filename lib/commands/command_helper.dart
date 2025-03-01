import 'dart:io';

import 'package:statekit_cli/exception/cli_exception.dart';
import 'package:statekit_cli/extensions/string_extensions.dart';

mixin CommandHelper {
  Future<bool> checkFileExist(String path) async {
    return File(path.path).exists();
  }

  Future<bool> checkDirectoryExist(String path) async {
    return Directory(path.path).exists();
  }

  Future<void> createDirectory(String path) async {
    await Directory(path.path).create(recursive: true);
  }

  Future<String> readFile(String path) async {
    File file = File(path.path);
    if (!await file.exists()) {
      throw CliException(message: "File $path is not exist");
    }
    return await file.readAsString();
  }

  Future<void> writeFile({required String path, required String content, String? screenName}) async {
    File file = File(path.path);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(content.sanitizeFileContent(screenName));
  }
}
