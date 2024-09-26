import '../q_hsm_core/q_event.dart';
import 'i_mediator.dart';

abstract class IHsm {
  IMediator? 	mediator();
  void 		    init    ();
  void 		    dispatch(QEvent event);
}
