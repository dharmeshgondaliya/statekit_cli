import 'package:dart_console/dart_console.dart';

class SelectMenu {
  SelectMenu({required this.options, required this.console});
  final List<String> options;
  int selectedOption = 0;
  int currentOption = 0;
  final Console console;
  // Coordinate? coordinate;
  bool firstTime = true;

  int ask() {
    if (options.isEmpty) return selectedOption;
    console.rawMode = true;
    console.hideCursor();
    // coordinate = console.cursorPosition;

    while (true) {
      // console.cursorPosition = coordinate;
      _drawMenu();
      firstTime = false;

      final Key key = console.readKey();

      if (key.controlChar == ControlCharacter.enter) {
        break;
      }

      if (key.char == " ") {
        selectedOption = currentOption;
      }

      if (key.controlChar == ControlCharacter.arrowUp && currentOption > 0) {
        currentOption--;
      }
      if (key.controlChar == ControlCharacter.arrowDown && currentOption < options.length - 1) {
        currentOption++;
      }
    }

    console.rawMode = false;
    console.showCursor();
    console.resetColorAttributes();
    return selectedOption;
  }

  void _drawMenu() {
    if (!firstTime) {
      for (int i = 0; i < options.length + 1; i++) {
        console.write("\x1B[1A");
        console.write("\x1B[2K");
      }
    }
    for (int i = 0; i < options.length; i++) {
      if (i == currentOption) {
        console.setForegroundColor(ConsoleColor.blue);
        console.write("> ");
      } else {
        console.write("  ");
      }

      if (i == selectedOption) {
        console.write("(√) ");
      } else {
        console.write("( ) ");
      }

      console.write("${options[i]}\n");
      console.resetColorAttributes();
      if (i == options.length - 1) {
        console.writeLine();
      }
    }
  }
}
