import '../q_interfaces/typedefs.dart';
import 'tap.dart';

class Taps {
  final Map<String, Tap> _container = <String, Tap>{};

  late VoidCallbackParameter? callback;

  void clear() {
    _container.clear();
  }

  void setCallback(VoidCallbackParameter? cb) {
    callback = cb;
  }

  void put(Tap tap) {
    _container[tap.uuid()] = tap;
    tap.setParent(this);
    tap.run();
    //@print('+ [${tap.uuid()}] -> ${_container.length}');
  }

  void stop() {
    Map<String,Tap> clone = {..._container};
    for (var entry in clone.entries) {
      Tap tap = entry.value;
      tap.stop();
    }
  }

  void remove(String uuid) {
    _container.remove(uuid);
    //@print('- [$uuid] -> ${_container.length}');
    callback?.call(_container.length);
  }

  void update(String uuid) {
    remove(uuid);
  }

  Map<String, Tap> container() {
    return _container;
  }
}
