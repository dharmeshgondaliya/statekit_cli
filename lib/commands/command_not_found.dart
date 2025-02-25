import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/data/cli_data_provider.dart';
import 'package:statekit_cli/exception/cli_exception.dart';

class CommandNotFound extends Command {
  @override
  Future<void> execute() async {
    throw CliException(message: "Command ${CliDataProvider.instance.args.join(' ')} Not Found");
  }

  @override
  bool requiredValidate() => false;
}
