import 'package:statekit_cli/data/constants.dart';
import 'package:statekit_cli/exception/cli_exception.dart';
import 'package:statekit_cli/extensions/string_extensions.dart';
import 'package:statekit_cli/validations/validations.dart';

class AuthScreensValidations extends Validations {
  @override
  Future<void> validate() async {
    await super.validate();
    bool screensDirectoryExist = await checkDirectoryExist(Constants.screensDirectoryPath);
    if (!screensDirectoryExist) {
      throw CliException(message: "${Constants.screensDirectoryPath.path} Directory not found");
    }
    bool widgetsDirectoryExist = await checkDirectoryExist(Constants.widgetsDirectoryPath);
    if (!widgetsDirectoryExist) {
      throw CliException(message: "${Constants.widgetsDirectoryPath.path} Directory not found");
    }
    for (String screen in [
      Constants.loginScreen,
      Constants.registerScreen,
      Constants.forgotPasswordScreen,
      Constants.resetPasswordScreen,
      Constants.changePasswordScreen,
      Constants.otpVerificationScreen,
      Constants.profileSetupScreen,
      Constants.editProfileScreen,
    ]) {
      bool screenExist = await checkDirectoryExist("${Constants.screensDirectoryPath}/$screen".path);
      if (screenExist) {
        throw CliException(message: "${"${Constants.screensDirectoryPath}/$screen".path} already exist");
      }
    }
  }
}
