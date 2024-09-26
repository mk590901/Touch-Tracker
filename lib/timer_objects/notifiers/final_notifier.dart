import '../timerInterfaces/i_notifier.dart';
import '../timerInterfaces/i_actor.dart';

class FinalNotifier implements INotifier {
  @override
  void notify(IActor parent, String timerIdent) {
    DateTime now = DateTime.now();
    print(
        '[$timerIdent] final ${now.hour}:${now.minute}:${now.second}:${now.millisecond}');
    //if (parent != null) {
      parent.execute(timerIdent, "@final");
    //}
  }
}
