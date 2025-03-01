import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/data/cli_data_provider.dart';
import 'package:statekit_cli/exception/cli_exception.dart';

class InvalidCommand extends Command {
  @override
  Future<void> execute() async {
    throw CliException(message: "Invalid command: ${CliDataProvider.instance.args.join(' ')}");
  }

  @override
  bool requiredValidate() => false;
}
