Map<String, dynamic>
	lookupTable = new Map<String, dynamic>();

void createWalker()
{
	lookupTable[createKey("GestureTrack","Q_ENTRY")]	= GestureTrackEntry;
	lookupTable[createKey("GestureTrack","Q_EXIT")]	= GestureTrackExit;
	lookupTable[createKey("GestureTrack","Q_INIT")]	= GestureTrackInit;
	lookupTable[createKey("Idle","Q_ENTRY")]	= IdleEntry;
	lookupTable[createKey("Idle","Q_EXIT")]	= IdleExit;
	lookupTable[createKey("Idle","TouchDown")]	= IdleTouchdown;
	lookupTable[createKey("Idle","TouchUp")]	= IdleTouchup;
	lookupTable[createKey("Idle","Reset")]	= IdleReset;
	lookupTable[createKey("InsideDown","Q_ENTRY")]	= InsideDownEntry;
	lookupTable[createKey("InsideDown","Q_EXIT")]	= InsideDownExit;
	lookupTable[createKey("InsideDown","TouchMove")]	= InsideDownTouchmove;
	lookupTable[createKey("InsideDown","TouchUp")]	= InsideDownTouchup;
	lookupTable[createKey("InsideDown","Timeout")]	= InsideDownTimeout;
	lookupTable[createKey("Moving","Q_ENTRY")]	= MovingEntry;
	lookupTable[createKey("Moving","Q_EXIT")]	= MovingExit;
	lookupTable[createKey("Moving","TouchUp")]	= MovingTouchup;
	lookupTable[createKey("Moving","TouchMove")]	= MovingTouchmove;
	lookupTable[createKey("CheckMove","Q_ENTRY")]	= CheckMoveEntry;
	lookupTable[createKey("CheckMove","Q_EXIT")]	= CheckMoveExit;
	lookupTable[createKey("CheckMove","MoveStart")]	= CheckMoveMovestart;
	lookupTable[createKey("CheckMove","TouchUp")]	= CheckMoveTouchup;
	lookupTable[createKey("CheckMove","Timeout")]	= CheckMoveTimeout;
	lookupTable[createKey("CheckMove","TouchMove")]	= CheckMoveTouchmove;
}

void GestureTrackEntry()
{
	print("inside GestureTrackEntry");
}

void GestureTrackExit()
{
	print("inside GestureTrackExit");
}

void GestureTrackInit()
{
	print("inside GestureTrackInit");
}

void IdleEntry()
{
	print("inside IdleEntry");
}

void IdleExit()
{
	print("inside IdleExit");
}

void IdleTouchdown()
{
	print("inside IdleTouchdown");
}

void IdleTouchup()
{
	print("inside IdleTouchup");
}

void IdleReset()
{
	print("inside IdleReset");
}

void InsideDownEntry()
{
	print("inside InsideDownEntry");
}

void InsideDownExit()
{
	print("inside InsideDownExit");
}

void InsideDownTouchmove()
{
	print("inside InsideDownTouchmove");
}

void InsideDownTouchup()
{
	print("inside InsideDownTouchup");
}

void InsideDownTimeout()
{
	print("inside InsideDownTimeout");
}

void MovingEntry()
{
	print("inside MovingEntry");
}

void MovingExit()
{
	print("inside MovingExit");
}

void MovingTouchup()
{
	print("inside MovingTouchup");
}

void MovingTouchmove()
{
	print("inside MovingTouchmove");
}

void CheckMoveEntry()
{
	print("inside CheckMoveEntry");
}

void CheckMoveExit()
{
	print("inside CheckMoveExit");
}

void CheckMoveMovestart()
{
	print("inside CheckMoveMovestart");
}

void CheckMoveTouchup()
{
	print("inside CheckMoveTouchup");
}

void CheckMoveTimeout()
{
	print("inside CheckMoveTimeout");
}

void CheckMoveTouchmove()
{
	print("inside CheckMoveTouchmove");
}

String createKey(String s, String t)
{
	return s + '.' + t;
}

