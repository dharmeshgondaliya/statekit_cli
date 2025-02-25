import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/commands/command_helper.dart';
import 'package:statekit_cli/utils/logger.dart';

class InitCommand extends Command with CommandHelper {
  InitCommand({required super.validations});

  @override
  Future<void> execute() async {
    Logger.instance.message("Init command");
  }

  @override
  bool requiredValidate() => true;
}
