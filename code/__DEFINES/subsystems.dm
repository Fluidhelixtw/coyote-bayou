//Update this whenever the db schema changes
//make sure you add an update to the schema_version stable in the db changelog
#define DB_MAJOR_VERSION 4
#define DB_MINOR_VERSION 7


#define addtimer(args...) _addtimer(args, file = __FILE__, line = __LINE__)

//! ## Timing subsystem
/**
 * Don't run if there is an identical unique timer active
 *
 * if the arguments to addtimer are the same as an existing timer, it doesn't create a new timer,
 * and returns the id of the existing timer
 */
#define TIMER_UNIQUE (1<<0)

///For unique timers: Replace the old timer rather then not start this one
#define TIMER_OVERRIDE (1<<1)

/**
 * Timing should be based on how timing progresses on clients, not the server.
 *
 * Tracking this is more expensive,
 * should only be used in conjuction with things that have to progress client side, such as
 * animate() or sound()
 */
#define TIMER_CLIENT_TIME (1<<2)

///Timer can be stopped using deltimer()
#define TIMER_STOPPABLE (1<<3)

///prevents distinguishing identical timers with the wait variable
///
///To be used with TIMER_UNIQUE
#define TIMER_NO_HASH_WAIT (1<<4)

///Loops the timer repeatedly until qdeleted
///
///In most cases you want a subsystem instead, so don't use this unless you have a good reason
#define TIMER_LOOP (1<<5)

///Delete the timer on parent datum Destroy() and when deltimer'd
#define TIMER_DELETE_ME (1<<6)

///Empty ID define
#define TIMER_ID_NULL -1

//Initalization Subsystem

#define INITIALIZATION_INSSATOMS 0	//New should not call Initialize
#define INITIALIZATION_INNEW_MAPLOAD 2	//New should call Initialize(TRUE)
#define INITIALIZATION_INNEW_REGULAR 1	//New should call Initialize(FALSE)

#define INITIALIZE_HINT_NORMAL 0    //Nothing happens
#define INITIALIZE_HINT_LATELOAD 1  //Call LateInitialize
#define INITIALIZE_HINT_QDEL 2  //Call qdel on the atom

///Call qdel with a force of TRUE after initialization
#define INITIALIZE_HINT_QDEL_FORCE 3

//type and all subtypes should always call Initialize in New()
#define INITIALIZE_IMMEDIATE(X) ##X/New(loc, ...){\
	..();\
	if(!(flags_1 & INITIALIZED_1)) {\
		args[1] = TRUE;\
		SSatoms.InitAtom(src, args);\
	}\
}

// Subsystem init_order, from highest priority to lowest priority
// Subsystems shutdown in the reverse of the order they initialize in
// The numbers just define the ordering, they are meaningless otherwise.

#define INIT_ORDER_PROFILER			100
#define INIT_ORDER_FAIL2TOPIC		99
#define INIT_ORDER_TITLE			98
#define INIT_ORDER_GARBAGE			95
#define INIT_ORDER_DBCORE			94
#define INIT_ORDER_STATPANELS		93
#define INIT_ORDER_BLACKBOX			92
#define INIT_ORDER_SERVER_MAINT		91
#define INIT_ORDER_INPUT			90
#define INIT_ORDER_SOUNDS			85
#define INIT_ORDER_VIS				80
#define INIT_ORDER_RESEARCH			75
#define INIT_ORDER_EVENTS			70
#define INIT_ORDER_JOBS				65
#define INIT_ORDER_QUIRKS			60
#define INIT_ORDER_AI_MOVEMENT 		56 //We need the movement setup
#define INIT_ORDER_TICKER			55
#define INIT_ORDER_INSTRUMENTS		53
#define INIT_ORDER_MAPPING			50
#define INIT_ORDER_ECONOMY			45
#define INIT_ORDER_TIMETRACK		47
#define INIT_ORDER_NETWORKS			40
#define INIT_ORDER_HOLODECK			35
#define INIT_ORDER_ARTIFACT			34
#define INIT_ORDER_ATOMS			30
#define INIT_ORDER_ITEMSPAWNERS		29
#define INIT_ORDER_VALIDBALL		28
#define INIT_ORDER_WHO				27
#define INIT_ORDER_LANGUAGE			25
#define INIT_ORDER_PLANTS			21
#define INIT_ORDER_MACHINES			20
#define INIT_ORDER_CIRCUIT			15
#define INIT_ORDER_TIMER			1
#define INIT_ORDER_DEFAULT			0
#define INIT_ORDER_AIR				-1
#define INIT_ORDER_AIR_TURFS		-2
#define INIT_ORDER_MINIMAP			-3
#define INIT_ORDER_ASSETS			-4
#define INIT_ORDER_ICON_SMOOTHING	-5
#define INIT_ORDER_OVERLAY			-6
#define INIT_ORDER_MATCHMATKING -7
#define INIT_ORDER_XKEYSCORE		-10
#define INIT_ORDER_STICKY_BAN		-10
#define INIT_ORDER_LIGHTING			-20
#define INIT_ORDER_SHUTTLE			-21
#define INIT_ORDER_MINOR_MAPPING	-40
#define INIT_ORDER_PATH				-50
#define INIT_ORDER_PREFBREAK		-51
#define INIT_ORDER_PERSISTENCE		-95
#define INIT_ORDER_LATELOAD			-97
#define INIT_ORDER_DEMO				-99  // o avoid a bunch of changes related to initialization being written, do this last
#define INIT_ORDER_CHAT				-100 //Should be last to ensure chat remains smooth during init.


// Subsystem fire priority, from lowest to highest priority
// If the subsystem isn't listed here it's either DEFAULT or PROCESS (if it's a processing subsystem child)

#define FIRE_PRIORITY_VORE			5
#define FIRE_PRIORITY_IDLE_NPC		10
#define FIRE_PRIORITY_SERVER_MAINT	10
#define FIRE_PRIORITY_RESEARCH		10
#define FIRE_PRIORITY_VIS			10
#define FIRE_PRIORITY_GARBAGE		15
#define FIRE_PRIORITY_WET_FLOORS	20
#define FIRE_PRIORITY_AIR			20
#define FIRE_PRIORITY_FIRE			20
#define FIRE_PRIORITY_SPAWNERS		24
#define FIRE_PRIORITY_PROCESS		25
#define FIRE_PRIORITY_THROWING		25
#define FIRE_PRIORITY_SPACEDRIFT	30
#define FIRE_PRIORITY_INSTRUMENTS	30
#define FIRE_PRIORITY_FIELDS		30
#define FIRE_PRIOTITY_SMOOTHING		35
#define FIRE_PRIORITY_HUDS			40
#define FIRE_PRIORITY_NETWORKS		40
#define FIRE_PRIORITY_OBJ			40
#define FIRE_PRIORITY_ACID			40
#define FIRE_PRIOTITY_BURNING		40
#define FIRE_PRIORITY_AIR_TURFS		40
#define FIRE_PRIORITY_DEFAULT		50
#define FIRE_PRIORITY_PARALLAX		65
#define FIRE_PRIORITY_NPC_MOVEMENT	81
#define FIRE_PRIORITY_NPC			99
#define FIRE_PRIORITY_MOBS			100
#define FIRE_PRIORITY_TGUI			110
#define FIRE_PRIORITY_PROJECTILES	200
#define FIRE_PRIORITY_TICKER		200
#define FIRE_PRIORITY_ATMOS_ADJACENCY	300
#define FIRE_PRIORITY_STATPANEL		390
#define FIRE_PRIORITY_CHAT			400
#define FIRE_PRIORITY_MOUSE_ENTERED	450
#define FIRE_PRIORITY_OVERLAYS		500
#define FIRE_PRIORITY_CALLBACKS		600
#define FIRE_PRIORITY_TIMER			700
#define FIRE_PRIORITY_INPUT			1000 // This must always always be the max highest priority. Player input must never be lost.

// SS runlevels

#define RUNLEVEL_INIT 0
#define RUNLEVEL_LOBBY 1
#define RUNLEVEL_SETUP 2
#define RUNLEVEL_GAME 4
#define RUNLEVEL_POSTGAME 8

#define RUNLEVELS_DEFAULT (RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME)

// SSair run section
#define SSAIR_PIPENETS 1
#define SSAIR_ATMOSMACHINERY 2
#define SSAIR_EXCITEDGROUPS 3
#define SSAIR_HIGHPRESSURE 4
#define SSAIR_HOTSPOTS 5
#define SSAIR_TURF_CONDUCTION 6
#define SSAIR_REBUILD_PIPENETS 7
#define SSAIR_EQUALIZE 8
#define SSAIR_ACTIVETURFS 9
#define SSAIR_TURF_POST_PROCESS 10
#define SSAIR_FINALIZE_TURFS 11
#define SSAIR_ATMOSMACHINERY_AIR 12
#define SSAIR_DEFERRED_AIRS 13

// |= on overlays is not actually guaranteed to not add same appearances but we're optimistically using it anyway.
#define COMPILE_OVERLAYS(A)\
	do {\
		var/list/ad = A.add_overlays;\
		var/list/rm = A.remove_overlays;\
		if(LAZYLEN(rm)){\
			A.overlays -= rm;\
			rm.Cut();\
		}\
		if(LAZYLEN(ad)){\
			A.overlays |= ad;\
			ad.Cut();\
		}\
		A.flags_1 &= ~OVERLAY_QUEUED_1;\
	} while(FALSE)

/**
	Create a new timer and add it to the queue.
	* Arguments:
	* * callback the callback to call on timer finish
	* * wait deciseconds to run the timer for
	* * flags flags for this timer, see: code\__DEFINES\subsystems.dm
*/
