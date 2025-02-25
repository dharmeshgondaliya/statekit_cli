import 'dart:io';

import 'package:pubspec_parse/pubspec_parse.dart';

class PubspecUtils {
  static final PubspecUtils _pubspecUtils = PubspecUtils._();
  static PubspecUtils get instance => _pubspecUtils;
  PubspecUtils._();
  late Pubspec pubSpec;

  Future<void> init() async {
    String path = [Directory.current.path, "pubspec.yaml"].join(Platform.pathSeparator);
    File pubspecFile = File(path);
    String pubspecFileString = await pubspecFile.readAsString();
    pubSpec = Pubspec.parse(pubspecFileString);
  }

  String get getAppName => pubSpec.name;
}
