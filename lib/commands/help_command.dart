import 'package:statekit_cli/commands/command.dart';

class HelpCommand extends Command {
  @override
  Future<void> execute() async {
    print("""List of available commands\n
    init: Initialize the structure of an existing project. Example: statekit init
    create screen: Generate a single screen (page) for your application. Example: statekit create screen <screen_name>
    create screens: Generate multiple screens (pages) for your application. Example: statekit create screens screen_1 screen_2 ... screen_n
    help: Display this help message\n\n""");
  }

  @override
  bool requiredValidate() => false;
}
