//	TrackQHsmScheme: file automatically generated at 2024-10-07 12:26:15
import	'../q_hsm_core/q_event.dart';
import	'../q_hsm_core/q_hsm.dart';
import	'../q_hsm_core/q_state.dart';
import	'../q_interfaces/i_mediator.dart';

class TrackQHsmScheme extends QHsm {
  static const TERMINATE	= QHsm.Q_USER_SIG;
  static const TouchDown	= QHsm.Q_USER_SIG + 1;
  static const TouchUp	= QHsm.Q_USER_SIG + 2;
  static const TouchMove	= QHsm.Q_USER_SIG + 3;
  static const Timeout	= QHsm.Q_USER_SIG + 4;
  static const Reset	= QHsm.Q_USER_SIG + 5;
  static const MoveStart	= QHsm.Q_USER_SIG + 6;
  static const INIT_SIG	= QHsm.Q_USER_SIG + 7;

  IMediator?	mediator_;

  TrackQHsmScheme(this.mediator_);

  QState?	GestureTrackState	(QEvent e) {
    switch (e.sig) {
      case QHsm.Q_ENTRY_SIG:
        mediator_?.execute("GestureTrack", QHsm.Q_ENTRY_SIG, e.ticket);
        return	null;
      case QHsm.Q_EXIT_SIG:
        mediator_?.execute("GestureTrack", QHsm.Q_EXIT_SIG, e.ticket);
        return	null;
      case QHsm.Q_INIT_SIG:
        mediator_?.execute("GestureTrack", QHsm.Q_INIT_SIG, e.ticket);
        Q_TRAN(IdleState);
        return	null;
    }
    return	QHsm.top;
  }

  void init(QEvent e)	{
    mediator_?.execute("top", TrackQHsmScheme.INIT_SIG);
    super.init_tran(GestureTrackState);
  }

  QState?	IdleState	(QEvent e) {
    switch (e.sig) {
      case QHsm.Q_ENTRY_SIG:
        mediator_?.execute("Idle", QHsm.Q_ENTRY_SIG, e.ticket);
        return	null;
      case QHsm.Q_EXIT_SIG:
        mediator_?.execute("Idle", QHsm.Q_EXIT_SIG, e.ticket);
        return	null;
      case TouchDown:
        mediator_?.execute("Idle", TrackQHsmScheme.TouchDown, e.ticket);
        Q_TRAN(InsideDownState);
        return	null;
      case TouchUp:
        mediator_?.execute("Idle", TrackQHsmScheme.TouchUp, e.ticket);
        Q_TRAN(GestureTrackState);
        return	null;
      case Reset:
        mediator_?.execute("Idle", TrackQHsmScheme.Reset, e.ticket);
        Q_TRAN(GestureTrackState);
        return	null;
    }
    return	GestureTrackState;
  }

  QState?	InsideDownState	(QEvent e) {
    switch (e.sig) {
      case QHsm.Q_ENTRY_SIG:
        mediator_?.execute("InsideDown", QHsm.Q_ENTRY_SIG, e.ticket);
        return	null;
      case QHsm.Q_EXIT_SIG:
        mediator_?.execute("InsideDown", QHsm.Q_EXIT_SIG, e.ticket);
        return	null;
      case TouchMove:
        mediator_?.execute("InsideDown", TrackQHsmScheme.TouchMove, e.ticket);
        Q_TRAN(CheckMoveState);
        return	null;
      case TouchUp:
        mediator_?.execute("InsideDown", TrackQHsmScheme.TouchUp, e.ticket);
        Q_TRAN(GestureTrackState);
        return	null;
      case Timeout:
        mediator_?.execute("InsideDown", TrackQHsmScheme.Timeout, e.ticket);
        Q_TRAN(GestureTrackState);
        return	null;
    }
    return	IdleState;
  }

  QState?	MovingState	(QEvent e) {
    switch (e.sig) {
      case QHsm.Q_ENTRY_SIG:
        mediator_?.execute("Moving", QHsm.Q_ENTRY_SIG, e.ticket);
        return	null;
      case QHsm.Q_EXIT_SIG:
        mediator_?.execute("Moving", QHsm.Q_EXIT_SIG, e.ticket);
        return	null;
      case TouchUp:
        mediator_?.execute("Moving", TrackQHsmScheme.TouchUp, e.ticket);
        Q_TRAN(GestureTrackState);
        return	null;
      case TouchMove:
        mediator_?.execute("Moving", TrackQHsmScheme.TouchMove, e.ticket);
        Q_TRAN(MovingState);
        return	null;
    }
    return	IdleState;
  }

  QState?	CheckMoveState	(QEvent e) {
    switch (e.sig) {
      case QHsm.Q_ENTRY_SIG:
        mediator_?.execute("CheckMove", QHsm.Q_ENTRY_SIG, e.ticket);
        return	null;
      case QHsm.Q_EXIT_SIG:
        mediator_?.execute("CheckMove", QHsm.Q_EXIT_SIG, e.ticket);
        return	null;
      case MoveStart:
        mediator_?.execute("CheckMove", TrackQHsmScheme.MoveStart, e.ticket);
        Q_TRAN(MovingState);
        return	null;
      case TouchUp:
        mediator_?.execute("CheckMove", TrackQHsmScheme.TouchUp, e.ticket);
        Q_TRAN(GestureTrackState);
        return	null;
      case Timeout:
        mediator_?.execute("CheckMove", TrackQHsmScheme.Timeout, e.ticket);
        Q_TRAN(GestureTrackState);
        return	null;
      case TouchMove:
        mediator_?.execute("CheckMove", TrackQHsmScheme.TouchMove, e.ticket);
        Q_TRAN(CheckMoveState);
        return	null;
    }
    return	IdleState;
  }
}


