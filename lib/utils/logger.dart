import 'package:dart_console/dart_console.dart';

class Logger extends Console {
  static final Logger _logger = Logger._();
  static Logger get instance => _logger;

  Logger._();

  void message(String message) {
    resetColorAttributes();
    setForegroundColor(ConsoleColor.white);
    writeLine(message);
  }

  void messageWrite(String message) {
    resetColorAttributes();
    setForegroundColor(ConsoleColor.white);
    write(message);
  }

  void info(String message) {
    resetColorAttributes();
    setForegroundColor(ConsoleColor.cyan);
    writeLine(message);
    resetColorAttributes();
  }

  void error(String message) {
    resetColorAttributes();
    setForegroundColor(ConsoleColor.red);
    writeLine("⚠  $message");
    resetColorAttributes();
  }

  void success(String message) {
    resetColorAttributes();
    setForegroundColor(ConsoleColor.green);
    writeLine(message);
    resetColorAttributes();
  }

  void warning(String message) {
    resetColorAttributes();
    setForegroundColor(ConsoleColor.yellow);
    writeLine(message);
    resetColorAttributes();
  }

  void executionTime(int milliseconds) {
    resetColorAttributes();
    setForegroundColor(ConsoleColor.yellow);
    writeLine("⌛ Total execution time: $milliseconds Milliseconds");
    resetColorAttributes();
  }
}
