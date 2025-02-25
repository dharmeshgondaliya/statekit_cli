import 'dart:io';

import 'package:statekit_cli/data/constants.dart';
import 'package:statekit_cli/exception/cli_exception.dart';
import 'package:statekit_cli/extensions/string_extensions.dart';

abstract class Validations<T> {
  Future<void> validate() async {
    List<bool> files = await Future.wait([
      checkFileExist(Constants.pubspecFilePath),
      checkFileExist(Constants.mainFilePath),
    ]);
    if (!files[0]) {
      throw CliException(
        message: "${Constants.pubspecFilePath.path} file is not exist",
      );
    }
    if (!files[1]) {
      throw CliException(
        message: "${Constants.mainFilePath.path} file is not exist",
      );
    }
  }

  Future<bool> checkFileExist(String path) async {
    return File(path.path).exists();
  }

  Future<bool> checkDirectoryExist(String path) async {
    return Directory(path.path).exists();
  }
}
