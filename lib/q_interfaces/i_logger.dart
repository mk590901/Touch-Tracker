abstract class ILogger {
  void            trace     (String string);
  void            traceExt  (String state, String event);
  void            printTrace();
  @override
  String          toString  ();
  String          toTrace   ();
  void            clear     (String label);
}
