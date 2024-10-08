//	TrackMediator: file automatically generated at 2024-10-07 08:26:08
import 'dart:async';
import 'dart:collection';
import '../q_hsm_core/q_event.dart';
import '../q_hsm_core/q_hsm.dart';
import '../q_interfaces/i_hsm.dart';
import '../q_interfaces/i_logger.dart';
import '../q_interfaces/i_mediator.dart';
import '../q_support/interceptor.dart';
import '../q_support/commands.dart';
import '../q_support/pairs.dart';
import 'track_context_object.dart';
import 'track_qhsm_scheme.dart';

class TrackMediator extends IMediator {
  final	Map <int,String>	hashTable	= <int, String>{};
  final	ILogger?	_logger;
  late	IHsm?	_hsm;
  final	TrackContextObject	_context;
  final	Interceptor	_interceptor;
  final	Commands	_commands	= Commands();
  final	Pairs	_connector	= Pairs();
  final Queue<QEvent>	_queue	= Queue<QEvent>();

  TrackMediator(this._context, this._interceptor, this._logger) {
    _context.setMediator(this);
    createTable	();
    createCommands	();
    createConnector	();
  }


  @override
  void execute(String? state, int signal, [int? data]) {
    dynamic command = _commands.get(state!, signal);
    if (command == null) {
      Object? dataObject = _interceptor.getObject(data);
      if (dataObject == null) {
        _logger?.trace('$state-${getEventId(signal)}');
      }
      else {
        _logger?.trace('$state-${getEventId(signal)}[$dataObject]');
      }
    }
    else {
      command(signal, data);
    }
  }

  @override
  int getEvent(int contextEventID) {
    return _connector.get(contextEventID);
  }

  @override
  String? getEventId(int event) {
    return hashTable.containsKey(event) ? hashTable[event] : 'UNKNOWN';
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
    return _connector.get(signal);
  }

  @override
  void setHsm(IHsm hsm) {
    _hsm = hsm;
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
        _logger?.clear('TrackMediator.objDone.[$eventText]');
        _hsm?.dispatch(event);
        _logger?.printTrace();
        _interceptor.clear(event.ticket);
      }
    });
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

    _commands.add("Idle",	QHsm.Q_ENTRY_SIG,	idleEntry);
    _commands.add("Idle",	QHsm.Q_EXIT_SIG,	idleExit);
    _commands.add("Idle",	TrackQHsmScheme.TouchDown,	idleTouchDown);
    _commands.add("Idle",	TrackQHsmScheme.TouchUp,	idleTouchUp);
    _commands.add("Idle",	TrackQHsmScheme.Reset,	idleReset);

    _commands.add("InsideDown",	QHsm.Q_ENTRY_SIG,	insideDownEntry);
    _commands.add("InsideDown",	QHsm.Q_EXIT_SIG,	insideDownExit);
    _commands.add("InsideDown",	TrackQHsmScheme.TouchMove,	insideDownTouchMove);
    _commands.add("InsideDown",	TrackQHsmScheme.TouchUp,	insideDownTouchUp);
    _commands.add("InsideDown",	TrackQHsmScheme.Timeout,	insideDownTimeout);

    _commands.add("Moving",	QHsm.Q_ENTRY_SIG,	movingEntry);
    _commands.add("Moving",	QHsm.Q_EXIT_SIG,	movingExit);
    _commands.add("Moving",	TrackQHsmScheme.TouchUp,	movingTouchUp);
    _commands.add("Moving",	TrackQHsmScheme.TouchMove,	movingTouchMove);

    _commands.add("CheckMove",	QHsm.Q_ENTRY_SIG,	checkMoveEntry);
    _commands.add("CheckMove",	QHsm.Q_EXIT_SIG,	checkMoveExit);
    _commands.add("CheckMove",	TrackQHsmScheme.MoveStart,	checkMoveMoveStart);
    _commands.add("CheckMove",	TrackQHsmScheme.TouchUp,	checkMoveTouchUp);
    _commands.add("CheckMove",	TrackQHsmScheme.Timeout,	checkMoveTimeout);
    _commands.add("CheckMove",	TrackQHsmScheme.TouchMove,	checkMoveTouchMove);
  }

  bool initTop(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onInitTop(value);
    return result;
  }

  bool idleEntry(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onIdleEntry(value);
    return result;
  }

  bool idleExit(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onIdleExit(value);
    return result;
  }

  bool idleTouchDown(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onIdleTouchDown(value);
    return result;
  }

  bool idleTouchUp(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onIdleTouchUp(value);
    return result;
  }

  bool idleReset(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onIdleReset(value);
    return result;
  }

  bool insideDownEntry(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onInsideDownEntry(value);
    return result;
  }

  bool insideDownExit(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onInsideDownExit(value);
    return result;
  }

  bool insideDownTouchMove(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onInsideDownTouchMove(value);
    return result;
  }

  bool insideDownTouchUp(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onInsideDownTouchUp(value);
    return result;
  }

  bool insideDownTimeout(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onInsideDownTimeout(value);
    return result;
  }

  bool movingEntry(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onMovingEntry(value);
    return result;
  }

  bool movingExit(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onMovingExit(value);
    return result;
  }

  bool movingTouchUp(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onMovingTouchUp(value);
    return result;
  }

  bool movingTouchMove(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onMovingTouchMove(value);
    return result;
  }

  bool checkMoveEntry(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onCheckMoveEntry(value);
    return result;
  }

  bool checkMoveExit(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onCheckMoveExit(value);
    return result;
  }

  bool checkMoveMoveStart(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onCheckMoveMoveStart(value);
    return result;
  }

  bool checkMoveTouchUp(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onCheckMoveTouchUp(value);
    return result;
  }

  bool checkMoveTimeout(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onCheckMoveTimeout(value);
    return result;
  }

  bool checkMoveTouchMove(int signal, int? ticket) {
    Object? value = _interceptor.getObject(ticket);
    bool result = _context.onCheckMoveTouchMove(value);
    return result;
  }
}
