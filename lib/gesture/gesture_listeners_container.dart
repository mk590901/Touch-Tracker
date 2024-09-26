
import '../q_interfaces/i_gesture_listener.dart';

class GestureListenersContiner {
  Map<int, IGestureListener> container = <int, IGestureListener>{};

  int size() {
    return container.length;
  }

  void register(int key, IGestureListener gestureListener) {
    container[key] = gestureListener;
  }

  void unregister(int key) {
    container.remove(key);
  }

  void clear() {
    container.clear();
  }

  bool contains(int key) {
    return container.containsKey(key);
  }

  Map<int, IGestureListener> listeners() {
    return container;
  }

  Map<int, IGestureListener> clone() {
    return {...container};
  }
}
