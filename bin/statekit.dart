import 'package:statekit_cli/commands/command.dart';
import 'package:statekit_cli/data/cli_data_provider.dart';
import 'package:statekit_cli/exception/cli_exception.dart';
import 'package:statekit_cli/statekit_cli.dart';
import 'package:statekit_cli/utils/logger.dart';
import 'package:statekit_cli/utils/pubspec_utils.dart';

void main(List<String> arguments) async {
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();
  try {
    CliDataProvider.instance.args = arguments;
    Command command = CliCommand.instance.findCommand();
    if (command.requiredValidate()) {
      await command.validations?.validate();
      await PubspecUtils.instance.init();
    }
    await command.execute();
  } on CliException catch (e) {
    Logger.instance.error(e.message);
  } catch (e) {
    Logger.instance.error(e.toString());
  } finally {
    stopwatch.stop();
    Logger.instance.executionTime(stopwatch.elapsedMilliseconds);
  }
  stopwatch.stop();
}
