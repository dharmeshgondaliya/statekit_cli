import 'package:statekit_cli/utils/pubspec_utils.dart';
import 'package:statekit_cli/validations/validations.dart';

abstract class Command {
  Command({this.validations});
  final Validations? validations;

  String get projectName => PubspecUtils.instance.getAppName;

  Future<void> execute();
  bool requiredValidate();
}
