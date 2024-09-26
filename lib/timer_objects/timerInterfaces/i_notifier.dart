import '../timerInterfaces/i_actor.dart';

abstract class INotifier {
  void notify(IActor parent, String timerIdent);
}
