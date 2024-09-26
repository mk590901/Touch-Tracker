import 'dart:async';
import 'dart:collection';

import '../q_hsm_core/q_event.dart';
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
	final ILogger?	_logger;
	IHsm?	_hsm;
	final TrackContextObject	_context;
	final Interceptor	_interceptor;
	final Commands	_commands	= Commands();
	final Pairs	_connector	= Pairs();

	final Queue<QEvent> _queue = Queue<QEvent>();

	Mediator(this._context, this._interceptor, this._logger) {
		_context.setMediator(this);
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

	/*bool*/ initTop(int signal, int ticket) {
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
		dynamic command = _commands.get(state!, signal);
		if (command == null) {
			Object? dataObject = _interceptor.getObject(data!);
			if (dataObject == null) {
				_logger?.trace('$state-${getEventId(signal)}');
			} else {
				_logger?.trace('$state-${getEventId(signal)}[$dataObject]');
			}
		} else if (command != null) {
			command(signal, data);
		}
	}

  @override
  int getEvent(int contextEventID) {
		return _connector.get(contextEventID);
  }

  @override
  String? getEventId(int event) {
		return hashTable.containsKey(event) ? hashTable[event] : "UNKNOWN";
  }

  @override
  ILogger? getLogger() {
		return _logger;
	}

  @override
  void init() {
		scheduleMicrotask(() {
			//_logger?.clear('[INIT]: ');
			_hsm?.init();
			//_logger?.printTrace();
		});
  }

	int eventObj2Hsm(int signal) {
		return _connector.get(signal); // !!! Problem H
	}

	@override
  void objDone(int signal, Object? data) {
		int hsmEvt = eventObj2Hsm(signal);
		int dataId = _interceptor.putObject(data);
		QEvent e = QEvent(hsmEvt, dataId);
		scheduleMicrotask(() {
			while (_queue.isNotEmpty) {
				QEvent event = _queue.removeFirst();
				String?  eventText = getEventId(event.sig);
				//_logger?.clear('TrackMediator.objDone.[$eventText]: ');
				_hsm!.dispatch(event);
				//_logger?.printTrace();
				_interceptor.clear(event.ticket);
			}
		});
  }

  @override
  void objDoneInside(int signal, Object? data) {
		int hsmEvt = eventObj2Hsm(signal);
		int dataId = _interceptor.putObject(data);
		QEvent e = QEvent(hsmEvt, dataId);
		_queue.addFirst(e);

//      printQueue();

		scheduleMicrotask(() {
			while (_queue.isNotEmpty) {
				QEvent event = _queue.removeFirst();
				//String?  eventText = getEventId(event.sig);
				//_logger.clear('[$eventText]: ');
				_hsm?.dispatch(event);
				//_logger.printTrace();
				//_logger.printTraceW();
				_interceptor.clear(event.ticket);
			}
		});
  }

  @override
  void setHsm(IHsm hsm) {
		_hsm = hsm;
	}
}

