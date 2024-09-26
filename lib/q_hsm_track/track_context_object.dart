import 'dart:math';

import '../helpers/DirectionHelper.dart';
import '../helpers/velocity_helper.dart';
import '../q_interfaces/i_logger.dart';
import '../q_interfaces/i_mediator.dart';
import '../q_interfaces/i_object.dart';
import '../q_support/object_event.dart';
import '../q_support/tracker.dart';
import '../timer_objects/time_machine.dart';

class TrackContextObject implements IObject {
	IMediator? _mediator;
	final ILogger? _logger;
	final int _pointer;

	final TimeMachine? _timeMachine    = TimeMachine();

	final VelocityHelper    _velocityHelper = VelocityHelper  (8);
	final DirectionHelper   _directionHelper= DirectionHelper (8);

	static final int  APP_START_ENUM  = 1;
	static final int  TERMINATE       = APP_START_ENUM;
	static final int  TouchDown       = APP_START_ENUM + 1;
	static final int  TouchUp         = APP_START_ENUM + 2;
	static final int  TouchMove       = APP_START_ENUM + 3;
	static final int  Timeout         = APP_START_ENUM + 4;
	static final int  MoveStart       = APP_START_ENUM + 5;
	static final int  Reset           = APP_START_ENUM + 6;
	static final int  INIT_IsDone     = APP_START_ENUM + 7;

	TrackContextObject(this._pointer, [this._logger]); /*{
		_timeMachine  = TimeMachine();
	}*/

	bool onInitTop(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'top-QHsmScheme.INIT_SIG'
				: 'top-QHsmScheme.INIT_SIG[$data]');
		return result;
	}

	bool onIdleEntry(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'Idle-QHsm.Q_ENTRY_SIG'
				: 'Idle-QHsm.Q_ENTRY_SIG[$data]');
		return result;
	}

	bool onIdleExit(Object? data) {
		bool result = false;
		_logger?.trace(
				data == null ? 'Idle-QHsm.Q_EXIT_SIG' : 'Idle-QHsm.Q_EXIT_SIG[$data]');
		return result;
	}

	bool onIdleTouchDown(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'Idle-QHsmScheme.TouchDown'
				: 'Idle-QHsmScheme.TouchDown[$data]');
		return result;
	}

	bool onIdleTouchUp(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'Idle-QHsmScheme.TouchUp'
				: 'Idle-QHsmScheme.TouchUp[$data]');
		return result;
	}

	bool onIdleReset(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'Idle-QHsmScheme.Reset'
				: 'Idle-QHsmScheme.Reset[$data]');
		return result;
	}

	bool onInsideDownEntry(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'InsideDown-QHsm.Q_ENTRY_SIG'
				: 'InsideDown-QHsm.Q_ENTRY_SIG[$data]');
		return result;
	}

	bool onInsideDownExit(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'InsideDown-QHsm.Q_EXIT_SIG'
				: 'InsideDown-QHsm.Q_EXIT_SIG[$data]');
		return result;
	}

	bool onInsideDownTouchMove(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'InsideDown-QHsmScheme.TouchMove'
				: 'InsideDown-QHsmScheme.TouchMove[$data]');
		return result;
	}

	bool onInsideDownTouchUp(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'InsideDown-QHsmScheme.TouchUp'
				: 'InsideDown-QHsmScheme.TouchUp[$data]');
		return result;
	}

	bool onInsideDownTimeout(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'InsideDown-QHsmScheme.Timeout'
				: 'InsideDown-QHsmScheme.Timeout[$data]');
		return result;
	}

	bool onMovingEntry(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'Moving-QHsm.Q_ENTRY_SIG'
				: 'Moving-QHsm.Q_ENTRY_SIG[$data]');
		return result;
	}

	bool onMovingExit(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'Moving-QHsm.Q_EXIT_SIG'
				: 'Moving-QHsm.Q_EXIT_SIG[$data]');
		return result;
	}

	bool onMovingTouchUp(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'Moving-QHsmScheme.TouchUp'
				: 'Moving-QHsmScheme.TouchUp[$data]');
		return result;
	}

	bool onMovingTouchMove(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'Moving-QHsmScheme.TouchMove'
				: 'Moving-QHsmScheme.TouchMove[$data]');
		return result;
	}

	bool onCheckMoveEntry(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'CheckMove-QHsm.Q_ENTRY_SIG'
				: 'CheckMove-QHsm.Q_ENTRY_SIG[$data]');
		return result;
	}

	bool onCheckMoveExit(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'CheckMove-QHsm.Q_EXIT_SIG'
				: 'CheckMove-QHsm.Q_EXIT_SIG[$data]');
		return result;
	}

	bool onCheckMoveMoveStart(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'CheckMove-QHsmScheme.MoveStart'
				: 'CheckMove-QHsmScheme.MoveStart[$data]');
		return result;
	}

	bool onCheckMoveTouchUp(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'CheckMove-QHsmScheme.TouchUp'
				: 'CheckMove-QHsmScheme.TouchUp[$data]');
		return result;
	}

	bool onCheckMoveTimeout(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'CheckMove-QHsmScheme.Timeout'
				: 'CheckMove-QHsmScheme.Timeout[$data]');
		return result;
	}

	bool onCheckMoveTouchMove(Object? data) {
		bool result = false;
		_logger?.trace(data == null
				? 'CheckMove-QHsmScheme.TouchMove'
				: 'CheckMove-QHsmScheme.TouchMove[$data]');
		return result;
	}

  @override
  void done(ObjectEvent signal) {
		_mediator?.objDone(signal.event(), signal.data()!);
	}

  @override
  void execute(String state, int signal, Object? data) {
  }

  @override
  void init() {
		_mediator?.init();
	}

  @override
  IMediator? mediator() {
		return _mediator;
  }

  @override
  void setMediator(IMediator mediator) {
		_mediator = mediator;
  }

	@override
	void doneInside(ObjectEvent signal) {
		//print('done.signal->[${signal.event()}]');
		_mediator!.objDoneInside(signal.event(), signal.data()!);
	}

	void moveInit(int time, double x, double y) {
		_velocityHelper .init(time, x, y);
		_directionHelper.init(x, y);
	}

	void moveDone(int time, double x, double y, Tracker tracker) {
		double average = _velocityHelper .velocity(time, x, y);
		if (average >= 0.01) {
			tracker.setCurrentPoint(Point<double>(x.round().toDouble(),y.round().toDouble()));
		}
		_directionHelper.direction(x, y);
//    Offset a = _directionHelper.average();
//    if (a != null)
//    {
//    //  _tracker.onTryToRecognizeGesture(_pointer, a, _gesture);
//      print ('direction->(${v.dx},${v.dy})->(${a.dx},${a.dy})');
//    }
	}

	void moveStop() {
		_velocityHelper .reset();
		_directionHelper.reset();
	}


}

