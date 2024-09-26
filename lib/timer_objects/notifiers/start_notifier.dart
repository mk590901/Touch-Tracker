import '../timerInterfaces/i_notifier.dart';
import '../timerInterfaces/i_actor.dart';

class StartNotifier implements INotifier {
  @override
  void notify(IActor parent, String timerIdent) {
    DateTime now = new DateTime.now();
    print(
        '[$timerIdent] start ${now.hour}:${now.minute}:${now.second}:${now.millisecond}');
    if (parent != null) {
      parent.execute(timerIdent, "@start");
    }
  }
}
