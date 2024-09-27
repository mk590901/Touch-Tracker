
import '../q_interfaces/i_logger.dart';

class Logger implements ILogger {
  final List<String> _logger = [];

  Logger();

  @override
  void trace(String text) {
    _logger.add(text);
  }

  @override
  void traceExt(String state, String event) {
  }

  @override
  String toString() {
    String result = "";
    for (int i = 0; i < _logger.length; i++) {
      result += _logger[i] +
          ((i == (_logger.length - 1)) ? "" : " ");
    }
    return result;
  }

  @override
  String toTrace() {
    String result = '';
    if (_logger.length < 2) {
      return result;
    }
    for (int i = 1; i < _logger.length; i++) {
      result += _logger[i] + (i == (_logger.length - 1) ? "" : " ");
    }
    return result;
  }

  @override
  void printTrace() {
    print(toString());
  }

  @override
  void clear(String label) {
    //print('================= LOGGER.clear() =================');

    _logger.clear();
    if (label.isNotEmpty) {
      _logger.add(label);
    }
  }
}
