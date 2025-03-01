import 'dart:io';

import 'package:statekit_cli/utils/pubspec_utils.dart';

extension StringExtensions on String {
  String get path => [Directory.current.path, ...split("/")..remove("")].join(Platform.pathSeparator);

  String get capitalizeFirst {
    if (isEmpty || length == 1) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String get camelCase {
    if (isEmpty || length == 1) return this;
    return split("_").map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase()).join();
  }

  String sanitizeFileContent(String? screenName) {
    String sanitizedContent = replaceAll("<app_name>", PubspecUtils.instance.getAppName);
    if (screenName != null) {
      sanitizedContent = sanitizedContent
          .replaceAll("<screen_name>", screenName)
          .replaceAll("<screen_content>", screenName.split("_").join(" "))
          .replaceAll("<screen_class_name>", screenName.camelCase)
          .replaceAll("<screen_controller_name>", "${screenName.camelCase}Controller")
          .replaceAll("<screen_binding_name>", "${screenName.camelCase}Binding")
          .replaceAll("<repository_name>", "${screenName.camelCase}Repository");
    }
    return sanitizedContent;
  }

  String get routeName {
    String name = camelCase;
    return name[0].toLowerCase() + name.substring(1);
  }
}
