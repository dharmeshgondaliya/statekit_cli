import 'dart:io';

extension StringExtensions on String {
  String get path => [Directory.current.path, ...split("/")..remove("")].join(Platform.pathSeparator);
}
