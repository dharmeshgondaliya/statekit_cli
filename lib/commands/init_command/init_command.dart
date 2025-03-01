import 'dart:io';

import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/commands/command_helper.dart';
import 'package:statekit_cli/data/constants.dart';
import 'package:statekit_cli/enums/enums.dart';
import 'package:statekit_cli/generator/init_generator/init_generator.dart';
import 'package:statekit_cli/generator/init_generator/init_generator_modular.dart';
import 'package:statekit_cli/generator/init_generator/init_generator_global.dart';
import 'package:statekit_cli/utils/logger.dart';
import 'package:statekit_cli/utils/select_menu.dart';

class InitCommand extends Command with CommandHelper {
  InitCommand({required super.validations});

  @override
  Future<void> execute() async {
    Logger.instance.message("""\nNote:
- Press Space to select or unselect an option.
- Use the Up (↑) and Down (↓) arrow keys to navigate.
- Press Enter to confirm your selection.\n""");

    Logger.instance.message("Which folder structure do you prefer for your project?");
    int selectedOption = SelectMenu(options: ["Module-wise Structure", "Global Structure"], console: Logger.instance).ask();
    DirectoryStructor directoryStructor = selectedOption == 0 ? DirectoryStructor.modular : DirectoryStructor.global;

    Logger.instance.info("Creating project files and folder structure for $projectName...");

    await createDirectory(Constants.appDirectoryPath);

    await Future.wait([
      createDirectory(Constants.coreDirectoryPath),
      createDirectory(Constants.utilsDirectoryPath),
      createDirectory(Constants.constantsDirectoryPath),
      createDirectory(Constants.providerDirectoryPath),
      createDirectory(Constants.themeDirectoryPath),
      createDirectory(Constants.assetsImageDirectoryPath),
      if (directoryStructor == DirectoryStructor.modular) ...[
        createDirectory(Constants.modulesDirectoryPath),
      ] else ...[
        createDirectory(Constants.widgetsDirectoryPath),
        createDirectory(Constants.screensDirectoryPath),
      ],
    ]);

    await Future.wait([
      writeFile(
        path: Constants.mainFilePath,
        content: InitGenerator.mainFileContent,
      ),
      writeFile(
        path: Constants.appFilePath,
        content: InitGenerator.appFileContent,
      ),
      writeFile(
        path: Constants.appRoutesPath,
        content: InitGenerator.appRoutesFileContent,
      ),
      writeFile(
        path: Constants.colorConstantsPath,
        content: InitGenerator.colorConstantsFileContent,
      ),
      writeFile(
        path: Constants.assetImagesPath,
        content: InitGenerator.assetImagesFileContent,
      ),
      writeFile(
        path: Constants.commonUtilsFilePath,
        content: InitGenerator.commonUtilsFileContent,
      ),
      writeFile(
        path: Constants.mediaUtilsFilePath,
        content: InitGenerator.mediaUtilsFileContent,
      ),
      writeFile(
        path: Constants.datePickerUtilsFilePath,
        content: InitGenerator.datePickerUtilsFileContent,
      ),
      writeFile(
        path: Constants.textStyleFilePath,
        content: InitGenerator.textStyleFileContent,
      ),
      writeFile(
        path: Constants.urlManagerPath,
        content: InitGenerator.urlManagerFileContent,
      ),
      writeFile(
        path: Constants.preferenceProviderPath,
        content: InitGenerator.preferenceProviderFileContent,
      ),
      writeFile(
        path: Constants.enumsPath,
        content: InitGenerator.enumsFileContent,
      ),
      writeFile(
        path: Constants.apiProviderPath,
        content: InitGenerator.apiProviderFileContent,
      ),
      writeFile(
        path: Constants.themeFilePath,
        content: InitGenerator.themeFileContent,
      ),
      if (directoryStructor == DirectoryStructor.modular) ...[
        writeFile(
          path: Constants.routeNavigatorPath,
          content: InitGeneratorModular.routeNavigatorFileContent,
        ),
        writeFile(
          path: Constants.baseScreenPathModular,
          content: InitGeneratorModular.baseScreenFileContent,
        ),
        writeFile(
          path: Constants.homeScreenPathModular,
          content: InitGeneratorModular.homeScreenFileContent,
        ),
        writeFile(
          path: Constants.baseDialogPathModular,
          content: InitGenerator.baseDialogFileContent,
        ),
        writeFile(
          path: Constants.customAppbarPathModular,
          content: InitGenerator.customAppbarFileContent,
        ),
        writeFile(
          path: Constants.splashScreenPathModular,
          content: InitGenerator.splashScreenFileContent,
        ),
        writeFile(
          path: Constants.homeScreenRepositoryPathModular,
          content: InitGenerator.homeScreenRepositoryFileContent,
        ),
        writeFile(
          path: Constants.homeScreenControllerPathModular,
          content: InitGenerator.homeScreenControllerFileContent,
        ),
        writeFile(
          path: Constants.homeScreenBindingPathModular,
          content: InitGenerator.homeScreenBindingFileContent,
        ),
        writeFile(
          path: Constants.textFieldWidgetPathModular,
          content: InitGenerator.textfieldWidgetFileContent,
        ),
        writeFile(
          path: Constants.checkboxWidgetPathModular,
          content: InitGenerator.checkboxWidgetFileContent,
        ),
        writeFile(
          path: Constants.radioButtonWidgetPathModular,
          content: InitGenerator.radioButtonWidgetFileContent,
        ),
        writeFile(
          path: Constants.networkImageWidgetPathModular,
          content: InitGenerator.networkImageWidgetFileContent,
        ),
        writeFile(
          path: Constants.searchFieldWidgetPathModular,
          content: InitGenerator.searchFieldWidgetFileContent,
        ),
        writeFile(
          path: Constants.emptyViewWidgetPathModular,
          content: InitGenerator.emptyWidgetFileContent,
        ),
        writeFile(
          path: Constants.backArrowWidgetPathModular,
          content: InitGenerator.backArrowWidgetFileContent,
        ),
      ] else ...[
        writeFile(
          path: Constants.routeNavigatorPath,
          content: InitGeneratorGlobal.routeNavigatorFileContent,
        ),
        writeFile(
          path: Constants.baseScreenPathGlobal,
          content: InitGeneratorGlobal.baseScreenFileContent,
        ),
        writeFile(
          path: Constants.homeScreenPathGlobal,
          content: InitGeneratorGlobal.homeScreenFileContent,
        ),
        writeFile(
          path: Constants.baseDialogPathGlobal,
          content: InitGenerator.baseDialogFileContent,
        ),
        writeFile(
          path: Constants.customAppbarPathGlobal,
          content: InitGenerator.customAppbarFileContent,
        ),
        writeFile(
          path: Constants.splashScreenPathGlobal,
          content: InitGenerator.splashScreenFileContent,
        ),
        writeFile(
          path: Constants.homeScreenRepositoryPathGlobal,
          content: InitGenerator.homeScreenRepositoryFileContent,
        ),
        writeFile(
          path: Constants.homeScreenControllerPathGlobal,
          content: InitGenerator.homeScreenControllerFileContent,
        ),
        writeFile(
          path: Constants.homeScreenBindingPathGlobal,
          content: InitGenerator.homeScreenBindingFileContent,
        ),
        writeFile(
          path: Constants.textFieldWidgetPathGlobal,
          content: InitGenerator.textfieldWidgetFileContent,
        ),
        writeFile(
          path: Constants.checkboxWidgetPathGlobal,
          content: InitGenerator.checkboxWidgetFileContent,
        ),
        writeFile(
          path: Constants.radioButtonWidgetPathGlobal,
          content: InitGenerator.radioButtonWidgetFileContent,
        ),
        writeFile(
          path: Constants.networkImageWidgetPathGlobal,
          content: InitGenerator.networkImageWidgetFileContent,
        ),
        writeFile(
          path: Constants.searchFieldWidgetPathGlobal,
          content: InitGenerator.searchFieldWidgetFileContent,
        ),
        writeFile(
          path: Constants.emptyViewWidgetPathGlobal,
          content: InitGenerator.emptyWidgetFileContent,
        ),
        writeFile(
          path: Constants.backArrowWidgetPathGlobal,
          content: InitGenerator.backArrowWidgetFileContent,
        ),
      ],
    ]);

    String filePath = Platform.script.toFilePath();
    if (filePath.contains("flutter_bloc_cli")) {
      String directoryPath = filePath.substring(0, filePath.indexOf("${Platform.pathSeparator}statekit_cli${Platform.pathSeparator}"));
      String emptyImageFilePath =
          "$directoryPath${Platform.pathSeparator}statekit_cli${Platform.pathSeparator}assets${Platform.pathSeparator}images${Platform.pathSeparator}empty.png";
      String destinationFilePath = [Directory.current.path, Constants.assetsEmptyImageFilePath.split("/")..remove("")].join(Platform.pathSeparator);

      File emptyImageFile = File(emptyImageFilePath);
      if (emptyImageFile.existsSync()) {
        File destinationFile = File(destinationFilePath);
        await destinationFile.create(recursive: true);
        await emptyImageFile.copy(destinationFile.path);
      }
    }

    if (directoryStructor == DirectoryStructor.modular) {
      Logger.instance.success(Constants.modularPatternInitDirectoryStructor);
    } else {
      Logger.instance.success(Constants.nonModularPatternInitDirectoryStructor);
    }

    Logger.instance.warning("\nAdding the required dependencies to your $projectName project...");

    await Process.run("flutter", ["pub", "add", "file_picker", "intl", "statekit", "cached_network_image", "shared_preferences", "http", "shimmer"]);

    Logger.instance.success("\n√ Statekit Pattern structure successfully generated for $projectName.\n");
  }

  @override
  bool requiredValidate() => true;
}
