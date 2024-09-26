import 'notifiers/notifier.dart';
import 'time_machine.dart';
import 'timerInterfaces/i_actor.dart';
import 'timerInterfaces/i_notifier.dart';
import 'timerInterfaces/i_timer.dart';

class SoftTimer implements ITimer {
  INotifier? _startNotifier;
  INotifier? _finalNotifier;
  Notifier? _start;
  Notifier? _final;
  int _startTick = 0;
  int _currentTick = 0;
  int _period = 0;
  String _ident = "";
  bool _isOnce = false;
  bool _isActive = false;
  IActor? _parent;

//  Constructor
  SoftTimer([TimeMachine? timeMachine]) {
    _ident = timeMachine!.generateUniqueName("timer_");
    _period = 0;
    _finalNotifier = null;
    _startNotifier = null;
    _start = null;
    _final = null;
    _parent = null;
    _isOnce = true; //false;
    _isActive = false;
    _startTick = 0;
    _currentTick = 0;
  }

  bool _invokeStart() {
    bool result = false;
    if (_start != null) {
      _start!(_ident, "@start");
      return true;
    }
    if (_startNotifier == null) {
      return result;
    }
    _startNotifier!.notify(_parent!, _ident);
    result = true;
    return result;
  }

  bool _invokeFinal() {
    bool result = false;
    if (_final != null) {
      _final!(_ident, "@final");
      return true;
    }
    if (_finalNotifier == null) {
      return result;
    }
    _finalNotifier!.notify(_parent!, _ident);
    result = true;
    return result;
  }

//  Properties
  @override
  int getPeriod() {
    return _period;
  }

  @override
  String ident() {
    return _ident;
  }

  @override
  bool isOnce() {
    return _isOnce;
  }

  @override
  void setFinalNotifier(INotifier notifier) {
    _finalNotifier = notifier;
  }

  @override
  void setPeriod(int period) {
    _period = period;
  }

  @override
  void setStartNotifier(notifier) {
    _startNotifier = notifier;
  }

  @override
  void start() {
    _isActive = true;
    _invokeStart();
    _startTick = DateTime.now().millisecondsSinceEpoch;
    _currentTick = _startTick;
  }

  @override
  void stop() {
    _isActive = false;
    _invokeFinal();
    _startTick = 0;
    _currentTick = 0;
  }

  @override
  bool timeOver() {
    bool result = false;
    _currentTick = DateTime.now().millisecondsSinceEpoch;
    int procTime = _currentTick - _startTick;
    if (procTime >= _period) {
      result = true;
    }
    return result;
  }

  @override
  bool isActive() {
    return _isActive;
  }

  @override
  void setFinalFunction(Notifier notifyFunction) {
    _final = notifyFunction;
  }

  @override
  void setStartFunction(Notifier notifyFunction) {
    _start = notifyFunction;
  }
}
