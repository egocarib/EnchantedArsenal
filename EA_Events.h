#include "skse/PapyrusEvents.h"



struct TESEquipEvent
{
	Actor*		actor;			// 00
	UInt32		equippedFormID;	// 04
	UInt32		unk08;			// 08  (always 0)  specific ObjectReference FormID if item has one?
	UInt16		unk0C;			// 0C  (always 0)
	bool		isEquipping;	// 0E
	// more?
};

template <>
class BSTEventSink <TESEquipEvent>
{
public:
	virtual ~BSTEventSink() {}
	virtual EventResult ReceiveEvent(TESEquipEvent * evn, EventDispatcher<TESEquipEvent> * dispatcher) = 0;
};

//Equip Event Handler
class TESEquipEventHandler : public BSTEventSink <TESEquipEvent> 
{
public:
	virtual	EventResult	ReceiveEvent(TESEquipEvent * evn, EventDispatcher<TESEquipEvent> * dispatcher);
};

extern	EventDispatcher<TESEquipEvent>*		g_equipEventDispatcher;
extern	TESEquipEventHandler				g_equipEventHandler;



//Weapon Draw Event Handler
class LocalActionEventHandler : public BSTEventSink <SKSEActionEvent>
{
public:
	virtual	EventResult		ReceiveEvent(SKSEActionEvent * evn, EventDispatcher<SKSEActionEvent> * dispatcher);
};

extern	EventDispatcher<SKSEActionEvent>*	g_skseActionEventDispatcher;
extern	LocalActionEventHandler				g_skseActionEventHandler;