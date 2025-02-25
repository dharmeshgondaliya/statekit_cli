import 'package:statekit_cli/validations/validations.dart';

abstract class Command {
  Command({this.validations});
  final Validations? validations;
  Future<void> execute();
  bool requiredValidate();
}
