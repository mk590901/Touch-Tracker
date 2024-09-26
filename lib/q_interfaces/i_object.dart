import '../q_support/object_event.dart';
import 'i_mediator.dart';

abstract class IObject {
  void done(ObjectEvent signal);
  void execute(String state, int signal, Object data);
  IMediator? mediator();
  void setMediator(IMediator mediator);
  void init();
}
