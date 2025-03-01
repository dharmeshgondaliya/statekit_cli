import 'dart:io';

import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/commands/command_helper.dart';
import 'package:statekit_cli/commands/create_command.dart';
import 'package:statekit_cli/commands/sub_commands/blank_screen_create_command.dart';
import 'package:statekit_cli/commands/sub_commands/grid_screen_create_command.dart';
import 'package:statekit_cli/commands/sub_commands/listing_screen_create_command.dart';
import 'package:statekit_cli/data/cli_data_provider.dart';
import 'package:statekit_cli/data/constants.dart';
import 'package:statekit_cli/enums/enums.dart';
import 'package:statekit_cli/exception/cli_exception.dart';
import 'package:statekit_cli/extensions/string_extensions.dart';
import 'package:statekit_cli/utils/logger.dart';
import 'package:statekit_cli/utils/select_menu.dart';

class ScreenCreateCommand extends Command with CommandHelper {
  ScreenCreateCommand({required super.validations, required this.createMultiple});
  final bool createMultiple;

  @override
  Future<void> execute() async {
    List<String> args = CliDataProvider.instance.args;
    if (args[1] == "screen" || args[1] == "screens") {
      await createScreens();
    }
  }

  Future<void> createScreens() async {
    bool modulesDirectoryExist = await checkDirectoryExist(Constants.modulesDirectoryPath);

    DirectoryStructor directoryStructor = modulesDirectoryExist ? DirectoryStructor.modular : DirectoryStructor.global;

    if (directoryStructor == DirectoryStructor.global) {
      await checkNonModularPatternScreenExist();
    }

    Logger.instance.message("""\nNote:
- Press Space to select or unselect an option.
- Use the Up (↑) and Down (↓) arrow keys to navigate.
- Press Enter to confirm your selection.\n""");

    Logger.instance.message("Choose the type of screen you want to create:");
    int selectedScreen = SelectMenu(options: ["Blank Screen", "Listing Screen", "Grid Screen"], console: Logger.instance).ask();

    String? selectedModuleName;
    bool moduleCreated = false;

    if (directoryStructor == DirectoryStructor.modular) {
      String moduleDirPath = [Directory.current.path, ...Constants.modulesDirectoryPath.split("/")..remove("")].join(Platform.pathSeparator);
      Directory dir = Directory(moduleDirPath);
      if (!await dir.exists()) {
        throw CliException(message: "$moduleDirPath ${Constants.modulesDirectoryPath} Directory not found");
      }
      List<String> modules = dir.listSync().whereType<Directory>().map((e) => e.path.split(Platform.pathSeparator).last).toList();
      modules.remove("shared");
      modules.add("+ Create New Module");
      Logger.instance.message("Select a Module to Create a Screen:");
      int selectedModule = SelectMenu(options: modules, console: Logger.instance).ask();
      if (selectedModule == modules.length - 1) {
        Logger.instance.message("");
        selectedModuleName = getModuleNameFromUser();
        if (selectedModuleName.isNotEmpty) {
          moduleCreated = true;
          await createDirectory("${Constants.modulesDirectoryPath}/$selectedModuleName");
          await Future.wait([
            createDirectory("${Constants.modulesDirectoryPath}/$selectedModuleName/models"),
            createDirectory("${Constants.modulesDirectoryPath}/$selectedModuleName/widgets"),
            createDirectory("${Constants.modulesDirectoryPath}/$selectedModuleName/shared/controllers"),
            createDirectory("${Constants.modulesDirectoryPath}/$selectedModuleName/shared/repositories"),
          ]);
        }
      } else {
        selectedModuleName = modules[selectedModule];
      }
    }

    if (directoryStructor == DirectoryStructor.modular && (selectedModuleName ?? "").isEmpty) {
      throw CliException(message: "Something went wrong!");
    }

    if (directoryStructor == DirectoryStructor.modular) {
      await checkModularPatternScreenExist(selectedModuleName!);
    }

    CreateCommand createCommand = switch (selectedScreen) {
      0 => BlankScreenCreateCommand(directoryStructor, selectedModuleName, moduleCreated),
      1 => ListingScreenCreateCommand(directoryStructor, selectedModuleName, moduleCreated),
      2 => GridScreenCreateCommand(directoryStructor, selectedModuleName, moduleCreated),
      _ => BlankScreenCreateCommand(directoryStructor, selectedModuleName, moduleCreated),
    };

    await createCommand.execute();
  }

  String getModuleNameFromUser() {
    Logger.instance.messageWrite("Enter module name: ");
    String input = Logger.instance.readLine() ?? "";
    if (input.isEmpty) {
      Logger.instance.warning("\nModule name can not be empty.\n");
      return getModuleNameFromUser();
    }
    if (!RegExp(r'^[a-z][a-z0-9_]*[a-z0-9]$').hasMatch(input)) {
      Logger.instance.warning("\nInvalid module name.\n");
      return getModuleNameFromUser();
    }
    return input;
  }

  Future<void> checkNonModularPatternScreenExist() async {
    for (String screen in CliDataProvider.instance.args.sublist(2)) {
      bool screenExist = await checkDirectoryExist("${Constants.screensDirectoryPath}/$screen");
      if (screenExist) {
        String path = "${Constants.screensDirectoryPath}/$screen".path;
        throw CliException(message: "$path already exist");
      }
    }
  }

  Future<void> checkModularPatternScreenExist(String moduleName) async {
    for (String screen in CliDataProvider.instance.args.sublist(2)) {
      bool screenExist = await checkDirectoryExist("${Constants.modulesDirectoryPath}/$moduleName/$screen");
      if (screenExist) {
        String path = "${Constants.modulesDirectoryPath}/$moduleName/$screen".path;
        throw CliException(message: "$path already exist");
      }
    }
  }

  @override
  bool requiredValidate() => true;
}
