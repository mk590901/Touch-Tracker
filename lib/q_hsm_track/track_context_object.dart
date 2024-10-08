//	Class TrackContextObject: file automatically generated at 2024-10-08 09:26:16
//////////////////////////////////////////////////////////////////////////////
import 'dart:math';
import '../gesture/gesture_manager.dart';
import '../helpers/velocity_helper.dart';
import '../q_interfaces/i_gesture_listener.dart';
import '../q_support/tracker.dart';
import '../timer_objects/time_machine.dart';
//////////////////////////////////////////////////////////////////////////////
import '../q_interfaces/i_logger.dart';
import '../q_interfaces/i_mediator.dart';
import '../q_interfaces/i_object.dart';
import '../q_support/object_event.dart';

class TrackContextObject implements IObject {
	late	IMediator?	_mediator;
	final	ILogger?	_logger;

//////////////////////////////////////////////////////////////////////////////
	final int 				_pointer;
	Point<double>?		_downPoint;
	Point<double>?		_lastPoint;
	bool              _pause          = false;

	final TimeMachine _timeMachine    = TimeMachine();
	late  String      _timer          = "";

	final VelocityHelper    _velocityHelper = VelocityHelper  (8);

	final int  TIMEOUT_FOR_LONG_PRESS = 1000;
	final double THRESHOLD       = 25.0;  //  16.0 - Ok
//////////////////////////////////////////////////////////////////////////////

	static	final	int	APP_START_ENUM	= 1;
	static	final	int	TERMINATE	= APP_START_ENUM;
	static	final	int	TouchDown	= APP_START_ENUM + 1;
	static	final	int	TouchUp	= APP_START_ENUM + 2;
	static	final	int	TouchMove	= APP_START_ENUM + 3;
	static	final	int	Timeout	= APP_START_ENUM + 4;
	static	final	int	Reset	= APP_START_ENUM + 5;
	static	final	int	MoveStart	= APP_START_ENUM + 6;
	static	final	int	INIT_IsDone	= APP_START_ENUM + 7;

	TrackContextObject(this._pointer, [this._logger]);

	@override
	void done(ObjectEvent signal) {
		_mediator?.objDone(signal.event(), signal.data());
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


	bool onInitTop(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'top-QHsmScheme.INIT_SIG' : 'top-QHsmScheme.INIT_SIG[$data]');
		return result;
	}

	bool onIdleEntry(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Idle-QHsm.Q_ENTRY_SIG' : 'Idle-QHsm.Q_ENTRY_SIG[$data]');
		return result;
	}

	bool onIdleExit(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Idle-QHsm.Q_EXIT_SIG' : 'Idle-QHsm.Q_EXIT_SIG[$data]');
		return result;
	}

	bool onIdleTouchDown(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Idle-QHsmScheme.TouchDown' : 'Idle-QHsmScheme.TouchDown[$data]');

//////////////////////////////////////////////////////////////////////////////
		setDownPoint(data as Point<double>);
		_timer = _timeMachine.invoke(TIMEOUT_FOR_LONG_PRESS, startNotifier, finalNotifier);
//////////////////////////////////////////////////////////////////////////////

		return result;
	}

	bool onIdleTouchUp(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Idle-QHsmScheme.TouchUp' : 'Idle-QHsmScheme.TouchUp[$data]');
//////////////////////////////////////////////////////////////////////////////
		_timeMachine.delete(_timer);
//////////////////////////////////////////////////////////////////////////////
		return result;
	}

	bool onIdleReset(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Idle-QHsmScheme.Reset' : 'Idle-QHsmScheme.Reset[$data]');
//////////////////////////////////////////////////////////////////////////////
		_timeMachine.delete(_timer);
//////////////////////////////////////////////////////////////////////////////
		return result;
	}

	bool onInsideDownEntry(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'InsideDown-QHsm.Q_ENTRY_SIG' : 'InsideDown-QHsm.Q_ENTRY_SIG[$data]');
		return result;
	}

	bool onInsideDownExit(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'InsideDown-QHsm.Q_EXIT_SIG' : 'InsideDown-QHsm.Q_EXIT_SIG[$data]');
		return result;
	}

	bool onInsideDownTouchMove(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'InsideDown-QHsmScheme.TouchMove' : 'InsideDown-QHsmScheme.TouchMove[$data]');
		return result;
	}

	bool onInsideDownTouchUp(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'InsideDown-QHsmScheme.TouchUp' : 'InsideDown-QHsmScheme.TouchUp[$data]');

//////////////////////////////////////////////////////////////////////////////
		_timeMachine.delete(_timer);
		GestureManager.manager()!.eventTap(_pointer, _downPoint!);
//////////////////////////////////////////////////////////////////////////////
		return result;
	}

	bool onInsideDownTimeout(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'InsideDown-QHsmScheme.Timeout' : 'InsideDown-QHsmScheme.Timeout[$data]');

//////////////////////////////////////////////////////////////////////////////
		GestureManager.manager()?.eventLongPress(_pointer, _downPoint!);
//////////////////////////////////////////////////////////////////////////////

		return result;
	}

	bool onMovingEntry(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Moving-QHsm.Q_ENTRY_SIG' : 'Moving-QHsm.Q_ENTRY_SIG[$data]');

//////////////////////////////////////////////////////////////////////////////
		double average  = _velocityHelper.average();

		print('onMovingEntry->$average');

		if (average >= 0.01) {
			print('onMovingEntry.MOVE');
			//@@@@@@@_gesture.onMove(_pointer, ActionModifier.Continue, data);
			GestureManager.manager()?.eventMove(_pointer, ActionModifier.Continue, data as Point<double>);

			setLastPoint(data);
			setPause(false);
		}
		else { //print('PAUSE');
			if (!isPause()) {
				//  _gesture.onPause(_pointer, data);
				GestureManager.manager()?.eventPause(_pointer, data as Point<double>);
				setPause(true);
			}
		}
//////////////////////////////////////////////////////////////////////////////
		return result;
	}

	bool onMovingExit(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Moving-QHsm.Q_EXIT_SIG' : 'Moving-QHsm.Q_EXIT_SIG[$data]');
		return result;
	}

	bool onMovingTouchUp(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Moving-QHsmScheme.TouchUp' : 'Moving-QHsmScheme.TouchUp[$data]');

//////////////////////////////////////////////////////////////////////////////
		GestureManager.manager()?.eventMove(_pointer, ActionModifier.Final, data as Point<double>);
//////////////////////////////////////////////////////////////////////////////

		return result;
	}

	bool onMovingTouchMove(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'Moving-QHsmScheme.TouchMove' : 'Moving-QHsmScheme.TouchMove[$data]');
		return result;
	}

	bool onCheckMoveEntry(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'CheckMove-QHsm.Q_ENTRY_SIG' : 'CheckMove-QHsm.Q_ENTRY_SIG[$data]');

///////////////////////////////////////////////////////////////////
		if (data is! Point<double>) {
			return result;
		}
		Point<double>
		point = data;
		if (isFirstMove(point.x, point.y)) {
			done(ObjectEvent(TrackContextObject.MoveStart, data));
		}
//////////////////////////////////////////////////////////////////

		return result;
	}

	bool onCheckMoveExit(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'CheckMove-QHsm.Q_EXIT_SIG' : 'CheckMove-QHsm.Q_EXIT_SIG[$data]');
		return result;
	}

	bool onCheckMoveMoveStart(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'CheckMove-QHsmScheme.MoveStart' : 'CheckMove-QHsmScheme.MoveStart[$data]');

//////////////////////////////////////////////////////////////////
		_timeMachine.delete(_timer);
		GestureManager.manager()?.eventMove(_pointer, ActionModifier.Start, data as Point<double>);
//////////////////////////////////////////////////////////////////

		return result;
	}

	bool onCheckMoveTouchUp(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'CheckMove-QHsmScheme.TouchUp' : 'CheckMove-QHsmScheme.TouchUp[$data]');

//////////////////////////////////////////////////////////////////
		GestureManager.manager()?.eventTap(_pointer, _downPoint!);
//////////////////////////////////////////////////////////////////

		return result;
	}

	bool onCheckMoveTimeout(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'CheckMove-QHsmScheme.Timeout' : 'CheckMove-QHsmScheme.Timeout[$data]');

//////////////////////////////////////////////////////////////////
		GestureManager.manager()?.eventLongPress(_pointer, _downPoint!);
//////////////////////////////////////////////////////////////////

		return result;
	}

	bool onCheckMoveTouchMove(Object? data) {
		bool result = false;
		_logger?.trace(data == null ? 'CheckMove-QHsmScheme.TouchMove' : 'CheckMove-QHsmScheme.TouchMove[$data]');
		return result;
	}

//////////////////////////////////////////////////////////////////////////////
	void setDownPoint(Point<double> point) {
		_downPoint  = point;
		print('setDownPoint->[${point.x},${point.y}]');
	}

	void startNotifier (String timerIdent, String action) {
		DateTime now = DateTime.now();
		print('[$timerIdent] $action ${now.hour}:${now.minute}:${now.second}:${now.millisecond}');
	}

	void finalNotifier (String timerIdent, String action) {
		DateTime now = DateTime.now();
		print('[$timerIdent] $action ${now.hour}:${now.minute}:${now.second}:${now.millisecond}');
		done(ObjectEvent(TrackContextObject.Timeout, "TIMEOUT"));
	}

	void setLastPoint(Object? data) {
		_lastPoint = data as Point<double>;
	}

	Point<double>? getLastPoint() {
		return  _lastPoint;
	}

	void setPause(bool enable) {
		_pause = enable;
	}

	bool isPause() {
		return  _pause;
	}

	bool isFirstMove(double x, double y) {
		double  dx    = x    - _downPoint!.x;
		double  dy    = y    - _downPoint!.y;
		double  shift = (dx*dx + dy*dy);
		return  shift < THRESHOLD ? false : true;
	}

	void moveInit(int time, double x, double y) {
		_velocityHelper .init(time, x, y);
	}

	void moveDone(int time, double x, double y, Tracker tracker) {
		double average = _velocityHelper .velocity(time, x, y);
		if (average >= 0.01) {
			tracker.setCurrentPoint(Point<double>(x.round().toDouble(),y.round().toDouble()));
		}
	}

	void moveStop() {
		_velocityHelper .reset();
	}

//////////////////////////////////////////////////////////////////////////////


}

