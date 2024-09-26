
import '../q_support/tracker.dart';

class TrackersContiner {
  final Map<int, Tracker> _container = <int, Tracker>{};

  void register(int key, Tracker gestureListener) {
    _container[key] = gestureListener;
  }

  void unregister(int key) {
    _container.remove(key);
  }

  void clear() {
    _container.clear();
  }

  int size() {
    return _container.length;
  }

  Tracker? get(int key)
  {
    Tracker? result;
    if (_container.containsKey(key))
    {
      result = _container[key];
    }
    return  result;
  }

  Map<int, Tracker> trackers()
  {
    return  _container;
  }

}


