import '../timerInterfaces/i_notifier.dart';
import '../notifiers/notifier.dart';

abstract class ITimer {
  void start();
  void stop();
  bool timeOver();
  bool isOnce();
  void setPeriod(int period);
  int getPeriod();
  void setStartNotifier(INotifier notifier);
  void setFinalNotifier(INotifier notifier);
  void setStartFunction(Notifier notifyFunction);
  void setFinalFunction(Notifier notifyFunction);

//  public	void 		setParent(IActor parent);
//  public	void 		setQueue(MacrosQueue queue);
//  public	MacrosQueue	getQueue();
//  public	boolean 	isRepeated();
  String ident();
//  public	void 		sleep(int mSec);
  bool isActive();
//  public	void 		enable(boolean enable);
//  public	boolean 	isEnabled();
}
