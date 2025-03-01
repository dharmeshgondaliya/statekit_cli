import 'package:statekit_cli/data/cli_data_provider.dart';
import 'package:statekit_cli/data/constants.dart';
import 'package:statekit_cli/exception/cli_exception.dart';
import 'package:statekit_cli/validations/validations.dart';

class ScreenCreateValidations extends Validations {
  ScreenCreateValidations({required this.createMultiple});
  final bool createMultiple;

  @override
  Future<void> validate() async {
    await super.validate();
    bool screenDirectoryExist = await checkDirectoryExist(Constants.screensDirectoryPath);
    bool modulesDirectoryExist = await checkDirectoryExist(Constants.modulesDirectoryPath);
    if (!screenDirectoryExist && !modulesDirectoryExist) {
      throw CliException(message: "${Constants.screensDirectoryPath} Directory not found");
    }
    for (String screenName in CliDataProvider.instance.args.sublist(2)) {
      if (!isValidScreenName(screenName)) {
        throw CliException(message: """
* Screen name must start with a character, e.g., [a-z].
* Screen name can contain only characters, digits, and underscores, e.g., [a-z, 0-9, _].
* Screen name cannot end with an underscore.
""");
      }
    }
  }

  bool isValidScreenName(String name) {
    return RegExp(r'^[a-z][a-z0-9_]*[a-z0-9]$').hasMatch(name);
  }
}
