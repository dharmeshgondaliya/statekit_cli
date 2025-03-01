import 'package:statekit_cli/commands/auth_screens_create_command.dart';
import 'package:statekit_cli/commands/help_command.dart';
import 'package:statekit_cli/commands/init_command/init_command.dart';
import 'package:statekit_cli/commands/screen_create_command.dart';
import 'package:statekit_cli/validations/auth_screens_validations.dart';
import 'package:statekit_cli/validations/init_validations.dart';
import 'package:statekit_cli/validations/screen_create_validations.dart';

class CliDataProvider {
  static final CliDataProvider _blocCli = CliDataProvider._();
  static CliDataProvider get instance => _blocCli;
  CliDataProvider._();
  List<String> _args = [];

  final Map<String, dynamic> _commandData = {
    "help": {
      "args_length": 1,
      "has_sub_command": false,
      "command": HelpCommand(),
    },
    "init": {
      "args_length": 1,
      "has_sub_command": false,
      "command": InitCommand(validations: InitValidations()),
    },
    "create": {
      "has_sub_command": true,
      "sub_commands": {
        "screen": {
          "args_length": 3,
          "min_args_length": 3,
          "command": ScreenCreateCommand(
            validations: ScreenCreateValidations(createMultiple: false),
            createMultiple: false,
          ),
        },
        "screens": {
          "min_args_length": 3,
          "command": ScreenCreateCommand(
            validations: ScreenCreateValidations(createMultiple: true),
            createMultiple: true,
          ),
        },
        "auth-screens": {
          "command": AuthScreensCreateCommand(
            validations: AuthScreensValidations(),
          ),
        },
      }
    }
  };

  set args(List<String> args) {
    if (_args.isNotEmpty) throw "Arguments already initialize";
    _args = args;
  }

  List<String> get args => List.from(_args);

  Map<String, dynamic> get commandData => Map.from(_commandData);
}
