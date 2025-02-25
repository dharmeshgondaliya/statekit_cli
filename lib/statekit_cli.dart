import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/commands/command_not_found.dart';
import 'package:statekit_cli/commands/invalid_command.dart';
import 'package:statekit_cli/data/cli_data_provider.dart';

class CliCommand {
  static final CliCommand _validation = CliCommand._();
  static CliCommand get instance => _validation;
  CliCommand._();

  Command findCommand() {
    final Map<String, dynamic> commandData = CliDataProvider.instance.commandData;
    List<String> args = CliDataProvider.instance.args;
    if (args.isEmpty) {
      return commandData["help"]["command"];
    }
    if (!commandData.containsKey(args.first)) {
      return CommandNotFound();
    }
    if (commandData[args.first]["args_length"] != null && commandData[args.first]["args_length"] != args.length) {
      return InvalidCommand();
    }
    if (!commandData[args.first]["has_sub_command"]) {
      return commandData[args.first]["command"];
    }
    return _validate(commandData[args.first], args) ?? commandData["help"]["command"];
  }

  Command? _validate(Map<String, dynamic> data, List<String> args) {
    if (data['sub_commands'] is! Map) {
      return InvalidCommand();
    }
    int? argsLen = data['sub_commands']['args_length'];
    if (args.length < 2) {
      return InvalidCommand();
    }
    if (argsLen != null && argsLen != args.length) {
      return InvalidCommand();
    }
    if (!(data['sub_commands'] as Map).containsKey(args[1])) {
      return InvalidCommand();
    }
    int? argsLens = data['sub_commands'][args[1]]['args_length'] ?? data['sub_commands'][args[1]]['min_args_length'];
    if (argsLens != null && argsLens > args.length) {
      return InvalidCommand();
    }
    return data['sub_commands'][args[1]]['command'];
  }
}
