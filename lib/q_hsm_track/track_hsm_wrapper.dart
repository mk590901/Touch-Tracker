import 'dart:async';
import 'dart:collection';

import '../q_hsm_core/q_event.dart';
import '../q_interfaces/i_hsm.dart';
import '../q_interfaces/i_mediator.dart';
import 'track_qhsm_scheme.dart';

class TrackHsmWrapper implements IHsm {
  IMediator? _mediator;
  TrackQHsmScheme? _entity;
  final Queue<QEvent> _queue = Queue<QEvent>();

  TrackHsmWrapper(TrackQHsmScheme entity, IMediator mediator) {
    _entity = entity;
    _mediator = mediator;
    _mediator?.setHsm(this);
  }

  @override
  IMediator? getMediator() {
    return _mediator;
  }

  @override
  void setMediator(IMediator mediator) {
    _mediator = mediator;
  }

  @override
  void init() {
    _entity?.init(QEvent(TrackQHsmScheme.INIT_SIG));
  }

  @override
  void dispatch(QEvent event) {
    _entity?.dispatch(event);
  }

  @override
  void dispatchAsync(QEvent event) {
    _queue.add(event);
    Timer.run(() {
      while (_queue.isNotEmpty) {
        _entity!.dispatch(_queue.removeFirst());
      }
    });
  }

  @override
  IMediator? mediator() {
    return _mediator;
  }
}
