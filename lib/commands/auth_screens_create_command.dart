import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/commands/command_helper.dart';
import 'package:statekit_cli/utils/logger.dart';

class AuthScreensCreateCommand extends Command with CommandHelper {
  AuthScreensCreateCommand({required super.validations});

  @override
  Future<void> execute() async {
    Logger.instance.message("Auth screens create command");
  }

  @override
  bool requiredValidate() => true;
}
