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

class TrackMediator extends IMediator {

	final Map <int,String>	hashTable	= <int, String>{};
	final ILogger?	_logger;
	late  IHsm?	_hsm;
	final TrackContextObject	_context;
	final Interceptor	_interceptor;
	final Commands	_commands	= Commands();
	final Pairs	_connector	= Pairs();

	final Queue<QEvent> _queue = Queue<QEvent>();

	TrackMediator(this._context, this._interceptor, this._logger) {
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
		hashTable[TrackQHsmScheme.	TERMINATE	] = "TERMINATE";
		hashTable[TrackQHsmScheme.	TouchDown	] = "TouchDown";
		hashTable[TrackQHsmScheme.	TouchUp	] = "TouchUp";
		hashTable[TrackQHsmScheme.	TouchMove	] = "TouchMove";
		hashTable[TrackQHsmScheme.	Timeout	] = "Timeout";
		hashTable[TrackQHsmScheme.	Reset	] = "Reset";
		hashTable[TrackQHsmScheme.	MoveStart	] = "MoveStart";
		hashTable[TrackQHsmScheme.	INIT_SIG	] = "INIT";
	}

	void createConnector() {
		_connector.add(TrackContextObject.	TERMINATE,	TrackQHsmScheme.TERMINATE);
		_connector.add(TrackContextObject.	TouchDown,	TrackQHsmScheme.TouchDown);
		_connector.add(TrackContextObject.	TouchUp,	TrackQHsmScheme.TouchUp);
		_connector.add(TrackContextObject.	TouchMove,	TrackQHsmScheme.TouchMove);
		_connector.add(TrackContextObject.	Timeout,	TrackQHsmScheme.Timeout);
		_connector.add(TrackContextObject.	Reset,	TrackQHsmScheme.Reset);
		_connector.add(TrackContextObject.	MoveStart,	TrackQHsmScheme.MoveStart);
		_connector.add(TrackContextObject.	INIT_IsDone,	TrackQHsmScheme.INIT_SIG);
	}

	void	createCommands() {
		_commands.add("top",	TrackQHsmScheme.INIT_SIG,  initTop);

		_commands.add("Idle",	QHsm.Q_ENTRY_SIG,	IdleEntry);
		_commands.add("Idle",	QHsm.Q_EXIT_SIG,	IdleExit);
		_commands.add("Idle",	TrackQHsmScheme.TouchDown,	IdleTouchDown);
		_commands.add("Idle",	TrackQHsmScheme.TouchUp,	IdleTouchUp);
		_commands.add("Idle",	TrackQHsmScheme.Reset,	IdleReset);

		_commands.add("InsideDown",	QHsm.Q_ENTRY_SIG,	InsideDownEntry);
		_commands.add("InsideDown",	QHsm.Q_EXIT_SIG,	InsideDownExit);
		_commands.add("InsideDown",	TrackQHsmScheme.TouchMove,	InsideDownTouchMove);
		_commands.add("InsideDown",	TrackQHsmScheme.TouchUp,	InsideDownTouchUp);
		_commands.add("InsideDown",	TrackQHsmScheme.Timeout,	InsideDownTimeout);

		_commands.add("Moving",	QHsm.Q_ENTRY_SIG,	MovingEntry);
		_commands.add("Moving",	QHsm.Q_EXIT_SIG,	MovingExit);
		_commands.add("Moving",	TrackQHsmScheme.TouchUp,	MovingTouchUp);
		_commands.add("Moving",	TrackQHsmScheme.TouchMove,	MovingTouchMove);

		_commands.add("CheckMove",	QHsm.Q_ENTRY_SIG,	CheckMoveEntry);
		_commands.add("CheckMove",	QHsm.Q_EXIT_SIG,	CheckMoveExit);
		_commands.add("CheckMove",	TrackQHsmScheme.MoveStart,	CheckMoveMoveStart);
		_commands.add("CheckMove",	TrackQHsmScheme.TouchUp,	CheckMoveTouchUp);
		_commands.add("CheckMove",	TrackQHsmScheme.Timeout,	CheckMoveTimeout);
		_commands.add("CheckMove",	TrackQHsmScheme.TouchMove,	CheckMoveTouchMove);
	}

	bool initTop(int signal, int? ticket) {
		//print ('initTop ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInitTop(value);
		return result;
	}

	bool IdleEntry(int signal, int? ticket) {
		//print ('IdleEntry ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleEntry(value);
		return result;
	}

	bool IdleExit(int signal, int? ticket) {
		//print ('IdleExit ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleExit(value);
		return result;
	}

	bool IdleTouchDown(int signal, int? ticket) {
		//print ('IdleTouchDown ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleTouchDown(value);
		return result;
	}

	bool IdleTouchUp(int signal, int? ticket) {
		//print ('IdleTouchUp ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleTouchUp(value);
		return result;
	}

	bool IdleReset(int signal, int? ticket) {
		//print ('IdleReset ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onIdleReset(value);
		return result;
	}

	bool InsideDownEntry(int signal, int? ticket) {
		//print ('InsideDownEntry ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownEntry(value);
		return result;
	}

	bool InsideDownExit(int signal, int? ticket) {
		//print ('InsideDownExit ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownExit(value);
		return result;
	}

	bool InsideDownTouchMove(int signal, int? ticket) {
		//print ('InsideDownTouchMove ');
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownTouchMove(value);
		return result;
	}

	bool InsideDownTouchUp(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownTouchUp(value);
		return result;
	}

	bool InsideDownTimeout(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onInsideDownTimeout(value);
		return result;
	}

	bool MovingEntry(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onMovingEntry(value);
		return result;
	}

	bool MovingExit(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onMovingExit(value);
		return result;
	}

	bool MovingTouchUp(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onMovingTouchUp(value);
		return result;
	}

	bool MovingTouchMove(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onMovingTouchMove(value);
		return result;
	}

	bool CheckMoveEntry(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveEntry(value);
		return result;
	}

	bool CheckMoveExit(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveExit(value);
		return result;
	}

	bool CheckMoveMoveStart(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveMoveStart(value);
		return result;
	}

	bool CheckMoveTouchUp(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveTouchUp(value);
		return result;
	}

	bool CheckMoveTimeout(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveTimeout(value);
		return result;
	}

	bool CheckMoveTouchMove(int signal, int? ticket) {
		Object? value = _interceptor.getObject(ticket);
		bool result = _context.onCheckMoveTouchMove(value);
		return result;
	}

  @override
  void execute(String? state, int signal, [int? data]) {

		//print('execute $state : $signal : $data');

		dynamic command = _commands.get(state!, signal);
		//print('execute.@ $state : $signal : $data -> $command');
		if (command == null) {
			Object? dataObject = _interceptor.getObject(data);
			//print('execute.3 dataObject->$dataObject');
			if (dataObject == null) {
				//print('execute.4');
				_logger?.trace('$state-${getEventId(signal)}');

				//print('${_logger?.toString()}');
			}
			else {
				//print('execute.5');
				_logger?.trace('$state-${getEventId(signal)}[$dataObject]');
			}
		}
		else {
			//print('execute! $command ($signal $data)');
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
				_logger?.clear('[INIT]: ');
			_hsm?.init();
				_logger?.printTrace();
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
		_queue.add(e);
		scheduleMicrotask(() {
			while (_queue.isNotEmpty) {
				QEvent event = _queue.removeFirst();
				String?  eventText = getEventId(event.sig);
				//print ('eventText->$eventText');
					_logger?.clear('TrackMediator.objDone.[$eventText]');
				_hsm?.dispatch(event);
					_logger?.printTrace();
				_interceptor.clear(event.ticket);
			}
		});
  }

  @override
  void setHsm(IHsm hsm) {
		_hsm = hsm;
	}
}

