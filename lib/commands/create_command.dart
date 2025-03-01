import 'package:statekit_cli/enums/enums.dart';
import 'package:statekit_cli/extensions/string_extensions.dart';
import 'package:dart_style/dart_style.dart';

abstract class CreateCommand {
  Future<void> execute();

  String getRoutesFileContent(String screenName, String routesFileContent) {
    String routeName = "";
    if (routesFileContent.contains("abstract class Routes")) {
      String routesData = routesFileContent.replaceAll("abstract class Routes {", "").replaceAll("}", "").trim();
      routeName = screenName.routeName;
      routesData = "$routesData\nstatic const String $routeName = \"/$routeName\";";

      String finalRoutes = "abstract class Routes {$routesData}";

      return DartFormatter(languageVersion: DartFormatter.latestLanguageVersion).format(finalRoutes);
    }
    return routesFileContent;
  }

  String getNavigatorFileContent(String screenName, String navigatorFileContent, DirectoryStructor directoryStructore, String module) {
    String routeName = screenName.routeName;
    if (navigatorFileContent.contains("abstract class RouteNavigator")) {
      List lines = navigatorFileContent.replaceAll("\n\n", "\n").split("\n");
      int index = lines.indexWhere((element) => element.contains("abstract class RouteNavigator"));
      if (index != -1) {
        String imports;
        if (directoryStructore == DirectoryStructor.modular) {
          imports = "import '../modules/$module/$screenName/view/$screenName.dart';\nimport '../modules/$module/$screenName/controller/${screenName}_controller.dart';";
        } else {
          imports = "import '../screens/$screenName/view/$screenName.dart';\nimport '../screens/$screenName/controller/${screenName}_controller.dart';";
        }

        lines.insert(index, "$imports\n\n");
      }
      navigatorFileContent = lines.join("\n");

      RegExp regExp = RegExp(r'routes\s*=\s*{([^}]+)};');
      Match? match = regExp.firstMatch(navigatorFileContent);
      if (match == null) return navigatorFileContent;
      String? matchData = match.group(0);
      if (matchData == null) return navigatorFileContent;
      String mapStringData = matchData.replaceAll("routes = {", "").replaceAll("};", "").trim();
      if (!mapStringData.endsWith(",")) {
        mapStringData = "$mapStringData,";
      }

      String routes =
          "routes = {${mapStringData}Routes.$routeName: (BuildContext context) => StateProvider(stateProvider: StatekitProvider(create: () => <screen_controller_name>()),child: <screen_class_name>(),),};";
      navigatorFileContent = navigatorFileContent.replaceAll(matchData, routes.sanitizeFileContent(screenName));
      return DartFormatter(languageVersion: DartFormatter.latestLanguageVersion).format(navigatorFileContent);
    }
    return navigatorFileContent;
  }
}
