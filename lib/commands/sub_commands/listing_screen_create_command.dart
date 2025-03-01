import 'package:statekit_cli/commands/command_helper.dart';
import 'package:statekit_cli/commands/create_command.dart';
import 'package:statekit_cli/data/cli_data_provider.dart';
import 'package:statekit_cli/data/constants.dart';
import 'package:statekit_cli/enums/enums.dart';
import 'package:statekit_cli/generator/create_screen_generator/create_screen_generator.dart';
import 'package:statekit_cli/generator/create_screen_generator/create_screen_generator_modular.dart';
import 'package:statekit_cli/generator/create_screen_generator/create_screen_generator_global.dart';
import 'package:statekit_cli/utils/logger.dart';

class ListingScreenCreateCommand extends CreateCommand with CommandHelper {
  ListingScreenCreateCommand(this.directoryStructor, this.moduleName, this.moduleCreated);
  DirectoryStructor directoryStructor;
  final String? moduleName;
  final bool moduleCreated;

  @override
  Future<void> execute() async {
    String successMessage;

    if (directoryStructor == DirectoryStructor.modular) {
      successMessage = """/lib
│── /app
│   ├── /modules
│   │   ├── /$moduleName  ${moduleCreated ? '✨ (ADDED)' : ''}\n""";
    } else {
      successMessage = """\nGenerated files:\n
/lib
│── /App
│   ├── /screens\n""";
    }

    bool routeExist = await checkDirectoryExist(Constants.routesDirectoryPath);

    for (String screenName in CliDataProvider.instance.args.sublist(2)) {
      if (directoryStructor == DirectoryStructor.modular) {
        await createDirectory("${Constants.modulesDirectoryPath}/$moduleName/$screenName");
        await Future.wait([
          writeFile(
            path: "${Constants.modulesDirectoryPath}/$moduleName/$screenName/controller/${screenName}_controller.dart",
            content: CreateScreenGenerator.listScreenControllerFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.modulesDirectoryPath}/$moduleName/$screenName/view/$screenName.dart",
            content: CreateScreenGeneratorModular.listScreenFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.modulesDirectoryPath}/$moduleName/$screenName/view/list_item_view.dart",
            content: CreateScreenGenerator.listItemViewFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.modulesDirectoryPath}/$moduleName/$screenName/view/loading_view.dart",
            content: CreateScreenGenerator.listLoadingViewFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.modulesDirectoryPath}/$moduleName/$screenName/repository/${screenName}_repository.dart",
            content: CreateScreenGenerator.repositoryFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.modulesDirectoryPath}/$moduleName/$screenName/binding/${screenName}_binding.dart",
            content: CreateScreenGenerator.bindingFileContent,
            screenName: screenName,
          ),
        ]);
      } else {
        await createDirectory("${Constants.screensDirectoryPath}/$screenName");
        await Future.wait([
          writeFile(
            path: "${Constants.screensDirectoryPath}/$screenName/controller/${screenName}_controller.dart",
            content: CreateScreenGenerator.listScreenControllerFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.screensDirectoryPath}/$screenName/view/$screenName.dart",
            content: CreateScreenGeneratorGlobal.listScreenFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.screensDirectoryPath}/$screenName/view/list_item_view.dart",
            content: CreateScreenGenerator.listItemViewFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.screensDirectoryPath}/$screenName/view/loading_view.dart",
            content: CreateScreenGenerator.listLoadingViewFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.screensDirectoryPath}/$screenName/repository/${screenName}_repository.dart",
            content: CreateScreenGenerator.repositoryFileContent,
            screenName: screenName,
          ),
          writeFile(
            path: "${Constants.screensDirectoryPath}/$screenName/binding/${screenName}_binding.dart",
            content: CreateScreenGenerator.bindingFileContent,
            screenName: screenName,
          ),
        ]);
      }

      if (routeExist) {
        List routingData = await Future.wait([
          readFile(Constants.appRoutesPath),
          readFile(Constants.routeNavigatorPath),
        ]);
        String routesFileData = routingData[0];
        String routeNavigatorData = routingData[1];

        await Future.wait([
          writeFile(
            path: Constants.appRoutesPath,
            content: getRoutesFileContent(screenName, routesFileData),
            screenName: screenName,
          ),
          writeFile(
            path: Constants.routeNavigatorPath,
            content: getNavigatorFileContent(screenName, routeNavigatorData, directoryStructor, moduleName ?? ""),
            screenName: screenName,
          ),
        ]);
      }
      if (directoryStructor == DirectoryStructor.modular) {
        successMessage += """│   │   │   ├── /$screenName  ✨ (ADDED)
│   │   │   │   ├── /binding  ✨ (ADDED)
│   │   │   │   │   ├── ${screenName}_binding.dart  ✨ (ADDED)
│   │   │   │   ├── /controller  ✨ (ADDED)
│   │   │   │   │   ├── ${screenName}_controller.dart  ✨ (ADDED)
│   │   │   │   ├── /view  ✨ (ADDED)
│   │   │   │   │   ├── $screenName.dart  ✨ (ADDED)
│   │   │   │   │   ├── list_item_view.dart  ✨ (ADDED)
│   │   │   │   │   ├── loading_view.dart  ✨ (ADDED)
│   │   │   │   ├── /repository  ✨ (ADDED)
│   │   │   │   │   ├── ${screenName}_repository.dart  ✨ (ADDED) ${moduleCreated ? '''
│   │   │   ├── /models  ✨ (ADDED)
│   │   │   ├── /widgets  ✨ (ADDED)
│   │   │   ├── /shared  ✨ (ADDED)
│   │   │   │   ├── /controllers  ✨ (ADDED)
│   │   │   │   ├── /repositories  ✨ (ADDED)''' : ''}\n""";
      } else {
        successMessage += """│   │   ├── /$screenName  ✨ (ADDED)
│   │   │   ├── /view  ✨ (ADDED)
│   │   │   │   ├── $screenName.dart  ✨ (ADDED)
│   │   │   │   ├── list_item_view.dart  ✨ (ADDED)
│   │   │   │   ├── loading_view.dart  ✨ (ADDED)
│   │   │   ├── /controller  ✨ (ADDED)
│   │   │   │   ├── ${screenName}_controller.dart  ✨ (ADDED)
│   │   │   ├── /binding  ✨ (ADDED)
│   │   │   │   ├── ${screenName}_binding.dart  ✨ (ADDED)
│   │   │   ├── /repository  ✨ (ADDED)
│   │   │   │   ├── ${screenName}_repository.dart  ✨ (ADDED)\n""";
      }
    }
    Logger.instance.success(successMessage);
  }
}
