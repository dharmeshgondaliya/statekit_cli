import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/utils/logger.dart';

class ScreenCreateCommand extends Command {
  ScreenCreateCommand({required super.validations, required this.createMultiple});
  final bool createMultiple;

  @override
  Future<void> execute() async {
    Logger.instance.message("Screen create command");
  }

  @override
  bool requiredValidate() => true;
}
