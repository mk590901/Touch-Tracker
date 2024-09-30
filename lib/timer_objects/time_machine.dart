import 'dart:async';

import 'notifiers/notifier.dart';
import 'soft_timer.dart';
import 'timerInterfaces/i_notifier.dart';
import 'timerInterfaces/i_timer.dart';

class TimeMachine {
  final Duration oneMs = const Duration(milliseconds:10);
  //final Duration oneMs = const Duration(seconds:1000);

  final Map<String, ITimer> _container = <String, ITimer>{};
  
  bool delete(String timerIdent) {
    bool result = false;
    if (_container.containsKey(timerIdent)) {
      print('--- timer [$timerIdent] was deleted ---');
      _container.remove(timerIdent);
      result = true;
    }
    return result;
  }

  String create(int period, void Function(String a, String b) startNotifierFunc,
      void Function(String a, String b) finalNotifierFunc) {
    String result = "";
    ITimer timer = SoftTimer(this);
    timer.setPeriod(period);
    timer.setStartFunction(startNotifierFunc);
    timer.setFinalFunction(finalNotifierFunc);
    _container[timer.ident()] = timer;

    if (_container.length == 1) {
      print('-2- timer was created -2-');
      Duration oneSec = const Duration(milliseconds:100);
      Timer.periodic(oneSec, (Timer t) {
        execute();
        if (_container.isEmpty) {
          t.cancel();
        }
      });
    }
    result = timer.ident();
    return result;
  }

  ITimer? get(String timerIdent) {
    ITimer? result;
    if (timerIdent.isEmpty) {
      return result;
    }
    if (!_container.containsKey(timerIdent)) {
      return result;
    }
    result = _container[timerIdent];
    return result;
  }

  bool start(String timerIdent) {
    bool result = false;
    ITimer? timer = get(timerIdent);
    if (timer == null) {
      return result;
    }
    timer.start();
    result = true;
    return result;
  }
  
  String invoke(int period, Notifier startNotifierFunc,
      Notifier finalNotifierFunc) {
    String result = create(period, startNotifierFunc, finalNotifierFunc);
    return start(result) ? result : "";
  }

  bool execute() {
    bool result = false;
    List<String> markToDelete = [];

    //print ('in execute');

    for (String key in _container.keys) {
      ITimer? timer = _container[key];
      if (timer != null && timer.isActive()) {
        if (timer.timeOver()) {
          if (timer.isOnce()) {
            markToDelete.add(timer.ident());
            timer.stop();
          }
        }
      }
    }
    result = true;
    int length = markToDelete.length;
    if (length == 0) {
      return result;
    }
    for (int i = 0; i < length; i++) {
      String key = markToDelete[i];
      if (key.isNotEmpty) {
        _container.remove(key);
      }
    }
    return result;
  }

  String generateUniqueName(String basicName) {
    String result = "";
    List<String> names = _container.keys.toList();
    String name = basicName;
    int counter = 0;
    while (true) {
      bool duplication = _checkName(name, names);
      if (!duplication) {
        result = name;
        break;
      }
      name = "$basicName${++counter}";
    }
    return result;
  }

  bool _checkName(String name, List<String> names) {
    bool result = false;
    if (names.isEmpty) {
      return result;
    }
    result = names.contains(name);
    return result;
  }
}
