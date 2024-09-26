import '../q_interfaces/i_logger.dart';
import '../q_interfaces/i_mediator.dart';
import '../q_interfaces/i_object.dart';
import '../q_support/object_event.dart';

class TrackContextObject implements IObject {
	IMediator? _mediator;
	ILogger? _logger;

	static final int  APP_START_ENUM  = 1;
	static final int  TERMINATE       = APP_START_ENUM;
	static final int  TouchDown       = APP_START_ENUM + 1;
	static final int  TouchUp         = APP_START_ENUM + 2;
	static final int  TouchMove       = APP_START_ENUM + 3;
	static final int  Timeout         = APP_START_ENUM + 4;
	static final int  MoveStart       = APP_START_ENUM + 5;
	static final int  Reset           = APP_START_ENUM + 6;
	static final int  INIT_IsDone     = APP_START_ENUM + 7;

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
    // TODO: implement done
  }

  @override
  void execute(String state, int signal, Object? data) {
    // TODO: implement execute
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  IMediator? mediator() {
    // TODO: implement mediator
    throw UnimplementedError();
  }

  @override
  void setMediator(IMediator mediator) {
    // TODO: implement setMediator
  }
}

