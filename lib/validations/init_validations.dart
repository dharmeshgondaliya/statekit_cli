import 'package:statekit_cli/data/constants.dart';
import 'package:statekit_cli/exception/cli_exception.dart';
import 'package:statekit_cli/validations/validations.dart';

class InitValidations extends Validations {
  @override
  Future<void> validate() async {
    await super.validate();
    bool appDirectoryExist = await checkDirectoryExist(Constants.appDirectoryPath);
    if (appDirectoryExist) {
      throw CliException(message: "Initialization already completed");
    }
  }
}
