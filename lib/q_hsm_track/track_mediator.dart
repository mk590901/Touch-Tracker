import '../q_hsm_core/q_hsm.dart';
import '../q_interfaces/i_hsm.dart';
import '../q_interfaces/i_logger.dart';
import '../q_interfaces/i_mediator.dart';
import '../q_support/Interceptor.dart';
import '../q_support/commands.dart';
import '../q_support/pairs.dart';
import 'track_context_object.dart';
import 'track_qhsm_scheme.dart';

class Mediator extends IMediator {

	final Map <int,String>	hashTable	= <int, String>{};
	ILogger?	_logger;
	IHsm?	_hsm;
	TrackContextObject	_context;
	final Interceptor	_interceptor;
	final Commands	_commands	= Commands();
	final Pairs	_connector	= Pairs();

	Mediator(this._context, this._interceptor, this._logger) {
		_context?.setMediator(this);
		createTable	();
		createCommands	();
		createConnector	();
	}


	void createTable() {
		hashTable[QHsm.	Q_EMPTY_SIG	] = "Q_EMPTY";
		hashTable[QHsm.	Q_INIT_SIG	] = "Q_INIT";
		hashTable[QHsm.	Q_ENTRY_SIG	] = "Q_ENTRY";
		hashTable[QHsm.	Q_EXIT_SIG	] = "Q_EXIT";
		hashTable[QHsmScheme.	TERMINATE	] = "TERMINATE";
		hashTable[QHsmScheme.	TouchDown	] = "TouchDown";
		hashTable[QHsmScheme.	TouchUp	] = "TouchUp";
		hashTable[QHsmScheme.	TouchMove	] = "TouchMove";
		hashTable[QHsmScheme.	Timeout	] = "Timeout";
		hashTable[QHsmScheme.	Reset	] = "Reset";
		hashTable[QHsmScheme.	MoveStart	] = "MoveStart";
		hashTable[QHsmScheme.	INIT_SIG	] = "INIT";
	}

	void createConnector() {
		_connector.add(TrackContextObject.	TERMINATE,	QHsmScheme.TERMINATE);
		_connector.add(TrackContextObject.	TouchDown,	QHsmScheme.TouchDown);
		_connector.add(TrackContextObject.	TouchUp,	QHsmScheme.TouchUp);
		_connector.add(TrackContextObject.	TouchMove,	QHsmScheme.TouchMove);
		_connector.add(TrackContextObject.	Timeout,	QHsmScheme.Timeout);
		_connector.add(TrackContextObject.	Reset,	QHsmScheme.Reset);
		_connector.add(TrackContextObject.	MoveStart,	QHsmScheme.MoveStart);
		_connector.add(TrackContextObject.	INIT_IsDone,	QHsmScheme.INIT_SIG);
	}

	void	createCommands() {
		_commands.add("top",	QHsmScheme.INIT_SIG,  initTop);

		_commands.add("IdleState",	QHsm.Q_ENTRY_SIG,	IdleEntry);
		_commands.add("IdleState",	QHsm.Q_EXIT_SIG,	IdleExit);
		_commands.add("IdleState",	QHsmScheme.TouchDown,	IdleTouchDown);
		_commands.add("IdleState",	QHsmScheme.TouchUp,	IdleTouchUp);
		_commands.add("IdleState",	QHsmScheme.Reset,	IdleReset);

		_commands.add("InsideDownState",	QHsm.Q_ENTRY_SIG,	InsideDownEntry);
		_commands.add("InsideDownState",	QHsm.Q_EXIT_SIG,	InsideDownExit);
		_commands.add("InsideDownState",	QHsmScheme.TouchMove,	InsideDownTouchMove);
		_commands.add("InsideDownState",	QHsmScheme.TouchUp,	InsideDownTouchUp);
		_commands.add("InsideDownState",	QHsmScheme.Timeout,	InsideDownTimeout);

		_commands.add("MovingState",	QHsm.Q_ENTRY_SIG,	MovingEntry);
		_commands.add("MovingState",	QHsm.Q_EXIT_SIG,	MovingExit);
		_commands.add("MovingState",	QHsmScheme.TouchUp,	MovingTouchUp);
		_commands.add("MovingState",	QHsmScheme.TouchMove,	MovingTouchMove);

		_commands.add("CheckMoveState",	QHsm.Q_ENTRY_SIG,	CheckMoveEntry);
		_commands.add("CheckMoveState",	QHsm.Q_EXIT_SIG,	CheckMoveExit);
		_commands.add("CheckMoveState",	QHsmScheme.MoveStart,	CheckMoveMoveStart);
		_commands.add("CheckMoveState",	QHsmScheme.TouchUp,	CheckMoveTouchUp);
		_commands.add("CheckMoveState",	QHsmScheme.Timeout,	CheckMoveTimeout);
		_commands.add("CheckMoveState",	QHsmScheme.TouchMove,	CheckMoveTouchMove);
	}

	initTop(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInitTop(value);
		return result;
	}

	IdleEntry(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleEntry(value);
		return result;
	}

	IdleExit(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleExit(value);
		return result;
	}

	IdleTouchDown(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleTouchDown(value);
		return result;
	}

	IdleTouchUp(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleTouchUp(value);
		return result;
	}

	IdleReset(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleReset(value);
		return result;
	}

	InsideDownEntry(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownEntry(value);
		return result;
	}

	InsideDownExit(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownExit(value);
		return result;
	}

	InsideDownTouchMove(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownTouchMove(value);
		return result;
	}

	InsideDownTouchUp(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownTouchUp(value);
		return result;
	}

	InsideDownTimeout(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownTimeout(value);
		return result;
	}

	MovingEntry(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onMovingEntry(value);
		return result;
	}

	MovingExit(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onMovingExit(value);
		return result;
	}

	MovingTouchUp(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onMovingTouchUp(value);
		return result;
	}

	MovingTouchMove(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onMovingTouchMove(value);
		return result;
	}

	CheckMoveEntry(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveEntry(value);
		return result;
	}

	CheckMoveExit(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveExit(value);
		return result;
	}

	CheckMoveMoveStart(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveMoveStart(value);
		return result;
	}

	CheckMoveTouchUp(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveTouchUp(value);
		return result;
	}

	CheckMoveTimeout(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveTimeout(value);
		return result;
	}

	CheckMoveTouchMove(int signal, int ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveTouchMove(value);
		return result;
	}

  @override
  void execute(String? state, int signal, [int? data]) {
    // TODO: implement execute
  }

  @override
  int getEvent(int contextEventID) {
    // TODO: implement getEvent
    throw UnimplementedError();
  }

  @override
  String? getEventId(int event) {
    // TODO: implement getEventId
    throw UnimplementedError();
  }

  @override
  ILogger? getLogger() {
    // TODO: implement getLogger
    throw UnimplementedError();
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  void objDone(int signal, Object? data) {
    // TODO: implement objDone
  }

  @override
  void objDoneInside(int signal, Object? data) {
    // TODO: implement objDoneInside
  }

  @override
  void setHsm(IHsm hsm) {
    // TODO: implement setHsm
  }
}

