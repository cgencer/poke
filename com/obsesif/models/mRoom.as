package com.obsesif.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;

	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import it.gotoandplay.smartfoxserver.data.Room;
	import it.gotoandplay.smartfoxserver.data.User;

	import com.adobe.serialization.json.*;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	import com.obsesif.utils.LoggingFactory;
	import com.obsesif.models.data.gRoom;
	import com.obsesif.events.impEvent;

	public class mRoom implements IEventDispatcher
	{
		public static const log :Logger = LogContext.getLogger(mRoom);

		static private var _instance:mRoom;
		private var dispatcher:EventDispatcher;

		private var srv:SmartFoxClient;

		private var serverIp:String;
		private var serverPort:int = 9339;
		private var serverZone:String;
		private var serverRooms:Object;
		private var _userName:String;

		private var rooms:Object;

		private var buddylist:Array = new Array();
		private var scores:Array = new Array();

		private var totalPingTime:Number = 0;
		private var pingCount:int = 0;
		private var pings:Array = new Array();
		private var pingTimer:Timer;
		private var avgPing:int;

		private var pockets:Array = new Array();
		private var tablecards:Array = new Array();
		private var roomUsers:Array = new Array();
		private var roomPlayers:Array = new Array();
		private var _playerObjs:Array = new Array();
		private var _roomId:Number;
		private var _playerIndex:Number;
		private var _playerHand:Array;
		private var _table:Array = new Array();
		private var _tableCards:Array = new Array();
		private var _tableScores:Array = new Array();
		private var _turnCard:String;
		private var _riverCard:String;
		private var _myid:Number;
		private var _lobbyId:Number;
		private var _lobbyFlag:Boolean = false;
		private var _gameconfig:Array;
		private var _userCount:Number;
		private var _winners:String;
		private var myrealid:Number;
		private var pubMsg:String;
		private var privMsg:String;
		private var admMsg:String;
		private var _roomObj:Object;
		private var _newCreatedSFId:Number;
		private var _newCreatedDBId:Number;
		private var _seats:String;
		private var _heads:String;
		private var _newProfileId:Number;
		private var _passingDrink:Object;
		public var whosTurn:Number;
		private var _roomOwner:Number;
		private var _whoWon:Number;
		public var turnStatus:Number;
		public var dealerSfid:Number = -1;
		private var _usersRooms:Array;
		private var roomToJoin:String = "";
		private var roomObjToJoin:Object = null;
		private var _roomCreating:Object;
		public var modlist:Array = [];
		public var roomListAction:Number = 0;
		public var roomListActionParams:Object = null;
		public var roomJoinErrorCount:Number = 0;
		public var bidCounterAt:String = "";
		public var autoSit:Boolean = false;

		public function mRoom(e:SingletonEnforcer) {}

		public function boot(i:String, p:int, z:String) :void
		{
			this.serverIp = i;
			this.serverPort = p;
			this.serverZone = z;
			// this.serverRooms = r;
			this._userName = main._me['sfoxname'];

			dispatcher = new EventDispatcher();
			srv = new SmartFoxClient(true);

			srv.addEventListener(SFSEvent.onConnection,			onConnection);
			srv.addEventListener(SFSEvent.onLogin,					onLogin);
			srv.addEventListener(SFSEvent.onRoomListUpdate,		onRoomListUpdate);
//			srv.addEventListener(SFSEvent.onUserCountChange,	onUserCountChange);
			srv.addEventListener(SFSEvent.onConnectionLost,		onConnectionLost);

			srv.addEventListener(SFSEvent.onRoomAdded,				onRoomAdded);
			srv.addEventListener(SFSEvent.onRoomDeleted,				onRoomDeleted);
			srv.addEventListener(SFSEvent.onCreateRoomError,		onCreateRoomError);

			srv.addEventListener(SFSEvent.onExtensionResponse,		onExtensionHandler);
			srv.addEventListener(SFSEvent.onRoomVariablesUpdate, 	onRoomVars);
			srv.addEventListener(SFSEvent.onUserVariablesUpdate, 	onUserVars);

			srv.addEventListener(SFSEvent.onJoinRoom,				onJoinRoom);
			srv.addEventListener(SFSEvent.onJoinRoomError,		onJoinRoomError);
			srv.addEventListener(SFSEvent.onUserEnterRoom,		onUserEnterRoom);
			srv.addEventListener(SFSEvent.onUserLeaveRoom,		onUserLeaveRoom);
			srv.addEventListener(SFSEvent.onBuddyRoom,			onBuddyRoomHandler);

			srv.addEventListener(SFSEvent.onSpectatorSwitched,	heSitsNow);//adam player oldu
			srv.addEventListener(SFSEvent.onPlayerSwitched,		heStandsNow);//adam spec oldu

			srv.addEventListener(SFSEvent.onObjectReceived,		onObjectReceivedHandler);

			srv.addEventListener(SFSEvent.onPublicMessage,		onPublicMessage);
//			srv.addEventListener(SFSEvent.onPrivateMessage,		onPrivateMessage);
			srv.addEventListener(SFSEvent.onAdminMessage,		onAdminMessage);
			srv.addEventListener(SFSEvent.onModeratorMessage,	onAdminMessage);

			log.info("sockserver coming up on: "+this.serverIp+":"+this.serverPort);
			srv.connect(this.serverIp, this.serverPort);
		}

//==============================================================================
// bootstrap
//==============================================================================
		public function onConnection(e:SFSEvent):void
		{
			var ok:Boolean = e.params.success;
			log.info(ok ? "sockserver ready..." : "failed connecting sockserver");
			//			if(ok) srv.login(this.serverZone, "obsesif_"+String( ( Math.floor( Math.random()*999 ) ) ), "gudubet");
			if(ok){
				srv.login(this.serverZone, this._userName, "");
			}else{
				dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Oyuna giriş yapılamadı, lütfen sayfayı yenileyin ya da tekrar giriş yapın.", url: 'poker.aspx'}));
			}
		}

		public function onLogin(e:SFSEvent):void
		{
			var ok:Boolean = e.params.success;
			log.info(ok ? "logged in as " + e.params.name : "login error: " + e.params.error);
			if(ok){
				this._myid = srv.myUserId;

				srv.sendXtMessage('turn', 'uCn', {});
				dispatchEvent(new Event('ROOMS_LOADED'));
		}else{
				dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Oyuna giriş yapılamadı, lütfen sayfayı yenileyin ya da tekrar giriş yapın.", url: 'poker.aspx'}));
			}
		}
//==============================================================================
// personal
//==============================================================================
		public function saverealid(uid:Number):void
		{
			this.myrealid = uid;
		}
		public function grabInfo(uid:Number):void
		{
		}
		public function saveInfo(obj:Object):void
		{
			this._playerObjs[obj.userId] = obj;
		}
		public function removeInfo(obj:Object):void
		{
			this._playerObjs[obj.userId] = null;
		}
		public function buddyCheck(bl:Array):void
		{
			this.buddylist = bl;
//			srv.sendXtMessage('zone', 'uLs', {});
		}
		public function onlineBuddiesReceived(str:String):void
		{
			var fn:Array = [];
			var us:Array = str.split(';');
			var fb:Array = [];

			for(var s:String in us){
				var prt:Array = us[s].split(':');
				var pru:Array = prt[0].split('_');
				var uid:Number = Number(pru[0]);
				var rid:Number = Number(prt[1]);
				var pass:String = String(prt[2]);
				fn[uid] = rid;

//				main.log.info('USER: '+uid+' is in '+rid);

				for(s in this.buddylist)
				{
					var buddy:Object = this.buddylist[s];

					if(Number(buddy['userId']) == Number(uid))
					{
						buddy.inRoom = rid;

						if(Number(rid) == Number(this._lobbyId))
						{
							buddy.urim = buddy.uri + " (lobide)";
						}else{
							buddy.urim = buddy.uri;

							if (pass != "#####")
							{
								buddy.password = pass;
							}
						}
						fb.push(buddy);
					}
				}
			}
			this.buddylist = [];
			this.buddylist = fb.slice();

/*
//	For testing scroll on buddieslist
			fb = [];
			for(var i:Number=0;i<40;i++){
				fb.push({urim: 'test_+'+i, password:'', inRoom:1});
			}
*/
			dispatchEvent(new impEvent('BUDDIES_CHECKED', {buddies: fb}));
		}
		public function modListReceived(str:String):void
		{
//12_user_x:0:262
			var fn:Array = [];
			var us:Array = str.split(';');
			var fb:Array = [];

			for(var s:String in us){
				var prt:Array = us[s].split(':');

				var dbid:Number = prt[0].substr( 0, prt[0].indexOf('_') );
				var nick:String = prt[0].substr( prt[0].indexOf('_')+1 );
				var ulvl:Number = Number(prt[1]);
				var sfid:Number = Number(prt[2]);

main.log.info('uid:'+userId+' lvl:'+ulvl);
				if(dbid != Number(main._me['userId'])){
					fb.push( {userId: dbid, name:nick, level:ulvl, sfid: sfid} );
				}
			}
			dispatchEvent(new impEvent('MODLIST_BUILT', {modlist: fb}));
		}

//==============================================================================
// money related
//==============================================================================

		public function playMoney(cash:Number) :void
		{
/*
			main._me['useableCash'] = rounder(main._me['useableCash']);
			main._me['total'] = rounder(main._me['total']);

			var cash:Number = Number(main._me['useableCash']);

			if ( isNaN(cash) )
			{
					main.log.info("playmoney invalid: "+cash);
					dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Sunucudan veriler yüklenemedi, lütfen sayfayı yenileyin."}));
					return;

			}else if ( cash<=5 ){

					main.log.info("playmoney too low: "+cash);
					dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Elinizde çimdik kalmamış."}));
					return;

			}else{
*/
//				var pm:Number = rounder(cash);
main.log.info('adding cash to table: '+cash);
				srv.sendXtMessage('turn', 'cTT', {amount: rounder(cash)});
//			}
		}
//==============================================================================
// room list
//==============================================================================
		public function getRooms() :void
		{
			srv.getRoomList();
		}

		public function onRoomListUpdate(e:SFSEvent) :void
		{
		if (this.roomListAction>0)
			{
			if (this.roomListAction==2 && this.roomJoinErrorCount==1)
				{
				main.log.info("roomListActionParams");
				this.joinRoom(-1, this.roomListActionParams);
				}
			else
				{
				dispatchEvent(new impEvent('ROOMS_REFRESH', {action:this.roomListAction, params:this.roomListActionParams}));
				}
			this.roomListAction = 0;
			this.roomListActionParams = null;
			return;
			}

		if (this.roomToJoin!="")
			{
			var pass:String = "";
			if (this._roomCreating && this._roomCreating.password && this._roomCreating.password is String) pass = this._roomCreating.password;
			main.log.trace("pass is "+pass);

			var roomObj:Room = null;
			roomObj = srv.getRoomByName(this.roomToJoin);
			if (roomObj)
				{
				main.log.info("joining existing room "+this.roomToJoin);
				srv.joinRoom(/*roomObj.getId()*/this.roomToJoin, pass, true);
				this.roomToJoin = "";
				}
			return;
			}

//FIXME: bu kod (sondaki autojoin/dispatch disinda?) kullanilmiyor bosuna duruyor? -k
			var ids:Array = [];
			var idx:Array = [];
			var cnt:Number = 0;
			var ssId:Number;
			var odas:Array = ['game', 'tournament', 'vip', 'private'];
			this.rooms = {};
			this.rooms.game = [];
			this.rooms.tournament = [];
			this.rooms.vip = [];
			this.rooms.private = [];

			for (var r:String in e.params.roomList)
			{
				var oda:Room = e.params.roomList[r] as Room;
				var on:String = oda.getName();
				var ty:String = on.substr(0, on.indexOf('_') );
				var omin:String = oda.getVariable('buy_in');
				var omax:String = oda.getVariable('buy_inT');

/*
				var ov:String = oda.getVariable('game_type');
				// BUG: Doesn't get the variable
				if(ov == null)ov = "NoLimit";
*/

				if( odas.indexOf(ty) > -1 )
				{
					ssId = oda.getId();

					var odaname:String = on.substr( on.indexOf('_')+1 );
					var odatype:String = on.substr(0, on.indexOf('_'));
					var stat:String = String(oda.getUserCount() + " (+" + oda.getSpectatorCount() + ") / " + oda.getMaxUsers());
				}
			}
			srv.autoJoin();
			dispatchEvent(new Event('ROOMS_READY'));
		}

		/**
		 * Odaları gruplu olarak sakla
		 * (bkz: googledocs/pokenotlar/sheet:odalar)
		 */

		public function addTempRooms(rs:Object) :void
		{
			var rf:Object = {};
			var odas:Array = ['game', 'tournament', 'vip', 'private'];

			this.rooms = {};
			this.rooms.game = [];
			this.rooms.tournament = [];
			this.rooms.vip = [];
			this.rooms.private = [];
			for (var odatype:String in odas)
			{
				for(var oi:String in rs[odas[odatype]])
				{
					var nx:Object = rs[odas[odatype]][oi];

					var stat:String = "";
					var roomObj:Room = srv.getRoomByName(nx['name']);

					if(roomObj){
						nx['matchId'] = roomObj.getId();
						stat = String(roomObj.getUserCount()) + " / " + String(roomObj.getMaxUsers()) + " (+" + nx['maxSpectators'] + ")";
					}else{
						stat = "0 / " + String(nx['maxUsers']) + " (+" + nx['maxSpectators'] + ")";
					}

/*if(nx['limitType'] != "Pot")*/{

					this.rooms[odas[odatype]].push(
				new gRoom(	nx['name'],	odas[odatype],	nx['roomId'], nx['matchId'], nx['ownerId'],
								nx['minLevel'],
								nx['maxUsers'],	nx['maxSpectators'], stat,
								nx['limitType'], false,
								nx['blindBig'],	nx['blindSmall'], nx['timeLimit'],
								nx['roomCash'],	nx['roomCashMax'], nx['password'] )
					);
}
				}
			}
			dispatchEvent(new Event('ROOMS_ADDED'));
		}
//==============================================================================
// message facility
//==============================================================================
// nesajiletme problemsiz, oyun masasında mesajı gödnerirken mesaja
// log/chat window olacağının bilgisini eklemek gerekiyor

		public function getRealUsername(u:Object): String
		{
			if (typeof u == 'string')
				{
				var tmp:Array = String(u).split("_"); //split'e 2 diye limit verince olmadi -k
				tmp.splice(0, 1);
				var nm:String = tmp.join("_");
				return(nm);
				}
			return(getRealUsername((u as User).getName()));
		}

		public function sendMessage(sc:String, tg:String, msg:String) :void
		{
			var fmsgA:String = (sc == 'LOBBY') ? 'L' : 'T';
			var fmsgB:String = (tg == 'right') ? 'r' : 'l';
			var fmsg:String = fmsgA + fmsgB + "#" + msg;

//			main.log.info('@ mRoom sending: ' + fmsg);

			srv.sendPublicMessage(fmsg, srv.activeRoomId);
		}

		public function onAdminMessage(e:SFSEvent) :void
		{
			dispatchEvent(new impEvent('DISPLAY_ALERT', {message: e.params.message}));
		}

		public function onPublicMessage(e:SFSEvent) :void
		{
			var s:String = (e.params.message.substr(0,1)=='T') ? 'TABLE' : 'LOBBY';
			var t:String = (e.params.message.substr(1,1)=='r') ? 'right' : 'left';
			var m:String = e.params.message.substr(3);
//main.log.info('==='+s+'='+t+':'+m);

			var nm:String = getRealUsername(e.params.sender);

			if(t=='right')
				m = nm + ':!#' + m;
			else
				m = '[' + nm + '] ' + m;

			if(e.params.sender.getId() != srv.myUserId)
				dispatchEvent(new impEvent('PUBLIC_MESSAGE', {screen: s, target: t, message: m, sender: e.params.sender.getId()}));
		}
//==============================================================================
// sit & stand
//==============================================================================
// odaya ilk oyuncu dışında herkes Spectator olarak girer ve Join Game
// butonuyla Player moduna dönüşür. Masadan kalkıldığında tekrar Spectator
// olması opsiyonel olabilir, doğrudan lobiye de düşebilir.

		public function sitPlayer() :void
		{
			main.log.info("mRoom.sitPlayer");
			srv.switchSpectator();//make him a player
		}

		public function standPlayer() :void
		{
			main.log.info("mRoom.standPlayer");
			srv.switchPlayer();//make him a spectator
		}

		private function heStandsNow(e:SFSEvent) :void
		{
			try{
				main.log.info("heStandsNow");
			if (e.params.success){
				logWriter('masadan kalktı');
				srv.sendObject({cmd:'updateseats'});
				dispatchEvent(new Event('STANDING_NOW'));
			}
		}catch(e:Error){main.log.info("heStandsNow Exception:"+e.message);}
		}

		private function heSitsNow(e:SFSEvent) :void
		{
			try{
				main.log.info("heSitsNow: "+e.params.success);
			if (e.params.success){
				logWriter('masaya oturdu');
				dispatchEvent(new Event('SITTING_NOW'));
			}
		}catch(e:Error){main.log.info("heSitsNow Exception:"+e.message);}
		}

		public function iAmTheWinner( userid:Number ) :void
		{
			srv.sendObject( {cmd:'winner', uid: userid} );
		}

		/**
		 * srv.sendObject() ile oda içinde bir oyuncudan diğer
		 * oyunculara gönderilen paketlerin değerlendirilmesi
		 */
		private function onObjectReceivedHandler(e:SFSEvent):void
		{
			var st:String = e.params.obj.val;

			switch(e.params.obj.cmd)
			{
				case 'turnender':
						dispatchEvent(new Event('TURN_END'));
					break;
/*
//adoptraiser cagir, gerek yok turn basinda bize serverdan zaten geldigi icin
				case 'raiser':
						this._lastRaised = Number(e.params.obj.amount);
						dispatchEvent(new Event('ADOPT_RAISER'));
					break;
*/
				case 'winner':
						this._whoWon = Number(e.params.obj.uid);
						dispatchEvent(new Event('ANNOUNCE_THE_WINNER'));
					break;

				// hand sonucu
				case 'handResult':
					dispatchEvent(new impEvent('HAND_RESULT', e.params.obj.data));
					break;

				// içki gönderimi
				case 'drink':
						var d:Object = e.params.obj.item;
						this._passingDrink = d;
					dispatchEvent(new Event('DRINK_SERVED_COLD'));
					break;
				case 'updateseats':
					dispatchEvent(new Event('UPDATE_SEATS2'));
					break;

				// profil bilgisini iletmek için
				case 'profile':
					e.params.obj.cmd = null;
					var uObj:Object = {	userId:			e.params.obj.userId,
												levels:			e.params.obj.levels,
												uri:				e.params.obj.uri,
												nickname:		e.params.obj.nickname,
												useableCash:	rounder(e.params.obj.useableCash)
											};
					this._playerObjs[uObj.userId] = uObj;
					this._newProfileId = e.params.obj.userId;

					if (e.params.obj.custom.response!=true)
						sendMyProfile(e.params.sender.getId(), {response:true});

					dispatchEvent(new Event('SHOW_PROFILE'));
					break;
			}
		}

		public function sendMyProfile(restrictTo:Number=0, custom:Object=null) :void
		{
			var profile:Object = {};
			profile.cmd = 'profile';
			profile.userId = main._me.userId;
			profile.levels = main._me.levels;
			profile.uri = main._me.uri;
			profile.nickname = main._me.nickname;
			profile.useableCash = rounder(main._me.useableCash);
			custom = custom || {};
			profile.custom = custom;

			main.log.info("["+profile.userId+"] sendMyProfile: "+main._me.uri+" (to:"+(restrictTo==0?"ALL":restrictTo)+")");
			// gönderilen paketlerde ayrım yapılması gerekiyor, herkese
			// göndermeye kalkınca kendine de göndermiş olacağından, o paketi
			// yine işleyip flood halinde göndermemesi için sınırlama şart
			// yoksa birkaç saniyede odadaki tüm oyuncular paket bombardımanı
			// yedikleri için disconnect ediliyorlar

			if(restrictTo==0)	srv.sendObject(profile);
			else					srv.sendObjectToGroup(profile, [restrictTo]);

		}

		private function updatePlayers() :void
		{
			roomPlayers = [];
			var room:Object = srv.getActiveRoom();
			roomUsers = room.getUserList();
			for (var u:String in roomUsers)
			{
				if(roomUsers[u].isSpectator() == false)
				{
					roomPlayers.push( roomUsers[u].getId() );
					dispatchEvent(new Event('UPDATE_SEATS'));
				}
			}
		}
//==============================================================================
// join / leave room
//==============================================================================
		public function joinRoom(n:*, rObj:Object) :void
		{
try{
//create the room
			if(n==this._lobbyId){
				srv.joinRoom(this._lobbyId, '', false);
			}else{
				this._roomObj = rObj;
				this.roomToJoin = String(rObj.title);
				this.roomObjToJoin = rObj;
				var r:Room = srv.getRoomByName(rObj.title);
				if(r == null)
				{
					var roomObj:Object = new Object();
					roomObj.name = rObj.title;
					roomObj.isGame = true;
					roomObj.maxUsers = rObj.maxusers;
					roomObj.maxSpectators = rObj.maxspecs;
					roomObj.joinAsSpectator = main._noSit; //false;
					roomObj.exitCurrentRoom = true;
					if(main._compileForRelease){
						roomObj.extension = {name: 'turn', script: 'poker_turn.as'};
					}else{
						roomObj.extension = {name: 'turn', script: 'dev_poker_turn.as'};
					}

//	main.log.info("rObj is "+rObj);
/* BEWARE: rObj is gRoom! */
					var pass:String = (!rObj.password || rObj.password == "") ? "" : rObj.password;
					var variables:Array = [
						{name:"owner_id",			val: rObj.ownerid,		priv: false,	persistent: true},
						{name:"muted",				val: false,					priv: false,	persistent: true},
						{name:"blind_big",		val: rObj.blindbig,		priv: false,	persistent: true},
						{name:"blind_small",		val: rObj.blindsmall,	priv: false,	persistent: true},
						{name:"min_level",		val: rObj.minlevel,		priv: false,	persistent: true},
						{name:"blind_inc",		val: 10,						priv: false,	persistent: true},
						{name:"time_limit",		val: rObj.timelimit,		priv: false,	persistent: true},
						{name:"room_type",		val: 'dynamic',			priv: false,	persistent: true},
						{name:"game_type",		val: rObj.gametype,		priv: false,	persistent: true},
						{name:"buy_in",			val: rObj.buyin,			priv: false,	persistent: true},
						{name:"buy_inT",			val: rObj.buyinT,			priv: false,	persistent: true},
						{name:"password",			val: pass,					priv: false,	persistent: true}
					];

					roomObj.vars = variables;
					roomObj.uCount = false;
					this._roomOwner = Number(main._me['userId']);

					this._roomCreating = rObj;
					srv.createRoom(roomObj);
				}else{
					srv.joinRoom(rObj.title, rObj.password, true);
				}

//				this.setUvars(); //client roomid ile server'daki roomid tutmuyorsa (room destroy olup tekrar yaratilmissa, client refresh etmemisse) exception veriyor, #1009. onJoinRoom'a konuldu o yuzden. -k
			}

}catch(e:Error){main.log.info("joinRoom exception:"+e);}
		}

		public function setUvars():void
		{
		try{
			var uVars:Object = new Object();
			uVars.mlevel = main._me['mod'];
			uVars.plevel = main._me['levels'];
			uVars.dbid = main._me['userId'];
			uVars.uri = main._me['uri'];
			uVars.nick = main._me['nickname'];
			uVars.sfoxname = main._me['sfoxname'];
			srv.setUserVariables(uVars);
		}catch(e:Error){main.log.info("setUvars exception:"+e);}
		}

		public function getRoomMute() :Boolean {
			var room:Room = srv.getActiveRoom();
			return room.getVariable('muted') as Boolean;
		}

		public function setRoomMute(f:Boolean) :void {
			var rVars:Array = new Array();
			rVars.push({name:"muted", val:f, priv: true, persistent: true});
			srv.setRoomVariables(rVars);
		}

		public function onRoomAdded(e:SFSEvent) :void {
			main.log.info("Room " + e.params.room.getName() + " was created");
			this._newCreatedSFId = e.params.room.getId();
			this._newCreatedDBId = this._roomObj.roomId;
			dispatchEvent(new Event('ROOM_CREATED'));
		}

		public function onJoinRoom(e:SFSEvent) :void
		{
			var joinedRoom:Room = e.params.room;
			this.roomToJoin = "";
			this.roomObjToJoin = null;
			this._roomId = joinedRoom.getId();

			log.info("joined the room "+joinedRoom.getName()+" ("+srv.activeRoomId+")");

			if(!_lobbyFlag){
				this._lobbyId = srv.activeRoomId;
				this._lobbyFlag = true;
			}

			if (joinedRoom.isGame()){
				this.setUvars();
				roomJoinErrorCount = 0;
				sendMyProfile();
				srv.sendXtMessage('turn', 'jdR', {who: this.myrealid});
				srv.sendXtMessage('turn', 'sMs', {});

				log.info("My player id here: " + joinedRoom.getMyPlayerIndex()+ " my real id is "+this.myrealid);
				this._playerIndex = joinedRoom.getMyPlayerIndex();
				this._table[this._playerIndex] = true;

				this._gameconfig = joinedRoom.getVariables();
				this._gameconfig['name']			= joinedRoom.getName();
				this._gameconfig['id']				= joinedRoom.getId();
				this._gameconfig['players']		= joinedRoom.getMaxUsers();
				this._gameconfig['viewers']		= joinedRoom.getMaxSpectators();
				this._gameconfig['count']			= joinedRoom.getUserCount();
				this._gameconfig['playerId']		= srv.myUserId;
				this._gameconfig['playerName']	= srv.myUserName;
				this._gameconfig['timelimit']		= joinedRoom.getVariable('time_limit');
				this._gameconfig['blindSmall']	= joinedRoom.getVariable('blind_small');
				this._gameconfig['blindBig']		= joinedRoom.getVariable('blind_big');
				this._gameconfig['gameType']		= joinedRoom.getVariable('game_type');
				this._gameconfig['ownerId']		= this._roomOwner;
				this._gameconfig['buyIn']			= joinedRoom.getVariable('buy_in');
				this._gameconfig['buyInT']			= joinedRoom.getVariable('buy_inT');

				playMoney(main._me['useableCash']);

				this.turnStatus = joinedRoom.getVariable('turnProgress');
				if (this.turnStatus>0) this.dealerSfid = joinedRoom.getVariable('dealer');

				this.roomPlayers = [];
				this.roomUsers = joinedRoom.getUserList();
				for (var u:String in this.roomUsers){

					var rn:String = this.roomUsers[u].getName();
					var ra:Array = rn.split('_');

					if(this.roomUsers[u].isSpectator() == false){
						this.roomPlayers.push( Number(u) );
//						main.log.info("["+main._me['userId']+"]: roomplayer: "+u);
					}
//					else
//						main.log.info("["+main._me['userId']+"]: roomspectator: "+u);
				}
			}

			if(this._roomId == this._lobbyId){
				main.log.info('>>>>> sending request');
				srv.sendXtMessage('zone', 'uLs', {});

				dispatchEvent(new Event('LOBBY_JOINED'));
			}else{
				dispatchEvent(new impEvent('ROOM_JOINED', {cfg:this._gameconfig, jp:this.roomPlayers, po:this._playerObjs, 'ts':this.turnStatus, 'muted':this.getRoomMute()}));
			}
//			dispatchEvent(new Event('BUILD_MODLIST'));
		}

		public function askModList() :void
		{
			if(this._roomId != this._lobbyId){
				srv.sendXtMessage('zone', 'uMs', {});
			}
		}

		public function onUserEnterRoom(e:SFSEvent) :void
		{
			if(e.params.roomId == this._roomId){
//				dispatchEvent(new Event('BUILD_MODLIST'));
askModList();
				logWriter(getRealUsername(e.params.user)+" odaya girdi...", true);
			}
		}

		public function onUserLeaveRoom(e:SFSEvent) :void
		{
//			main.log.info("onUserLeaveRoom: "+e.params.userId);
			try{
			if(e.params.roomId != this._lobbyId){
askModList();
/*
				for(var t:String in this._playerObjs){
					if(this._playerObjs[t].sfoxid == e.params.userId){
						this._playerObjs[t] = null;
					}
				}
*/
//				dispatchEvent(new impEvent('OTHERS_LEAVING', {sfid:e.params.userId}));
				dispatchEvent(new impEvent('SOMEONE_LEFT', {sfid:e.params.userId}));
//				dispatchEvent(new Event('UPDATE_SEATS2'));
				logWriter(getRealUsername(e.params.userName)+" odadan ayrıldı...", true);
			}
		}catch(e:Error){main.log.info("onUserLeaveRoom exception:"+e.message);}

		}

//==============================================================================
// Room adding
//==============================================================================
		public function onRoomDeleted(e:SFSEvent) :void {
		}
		public function onCreateRoomError(e:SFSEvent) :void {
			try{
			main.log.info("createRoom: "+String(e.params.error)+" (r2j="+this.roomToJoin+")");
			if (e.params.error.indexOf("already taken")>-1 && this.roomToJoin!="")
				{
/*
reproduce etmek:
A bir odaya girer.
B bir oda yaratir (A daha lobideyken o oda yaratilmamis olmali)
A odadan cikar, B'nin odasina girmeye calisir (listeyi refresh etmeden)
B hata alir
*/

//oda refresh ediliyor, onRoomListUpdate cagiriliyor.
				srv.getRoomList();
				}
			else if (e.params.error.indexOf("or was just deleted")>-1 && this.roomToJoin!="" && this.roomJoinErrorCount==0)
				{
				this.roomJoinErrorCount++;
				this.roomListActionParams = this.roomObjToJoin;
				this.roomListAction = 2;
				this.getRooms();
				}
			else
				{
//				dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Odaya girerken hata oluştu! Sayfayı yenilemeniz gerekiyor.", width:190, height:140, url: 'poker.aspx'}));
				dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Odaya girerken hata oluştu! Oda listesini yenilemeniz gerekiyor.", width:190, height:140}));
				}
		}catch(e:Error){main.log.info("onCreateRoomError exception:"+e.message);}
		}
//==============================================================================
// Speedtest
//==============================================================================
		private function pinger(e:SFSEvent):void
		{
			var time:int = e.params.elapsed;
			totalPingTime += time/2;
			pingCount++;
			var avg:int = Math.round(totalPingTime/pingCount);
			this.pings.push(avg);
			if(this.pings.length==4){
				pingTimer.removeEventListener(TimerEvent.TIMER, doPing);
				pingTimer = null;
				var sum:int;
				for(var i:Number=0;i<this.pings.length;i++){
					sum+=this.pings[i];
				}
				this.avgPing = Math.round(sum/this.pings.length);
				dispatchEvent(new Event('PING_CALCULATED'));
			}
		}
		public function checkPing() :void
		{
			srv.addEventListener(SFSEvent.onRoundTripResponse, pinger);
			pingTimer = new Timer(4321, 5);
			pingTimer.addEventListener(TimerEvent.TIMER, doPing);
			pingTimer.start();
		}
		private function doPing(e:TimerEvent) :void
		{
			srv.roundTripBench();
		}
//==============================================================================
// various
//==============================================================================
		public function onJoinRoomError(e:SFSEvent)	:void
		{
			var err:String = String(e.params.error);
			main.log.info("joinRoom: "+String(e.params.error)+" (r2j="+this.roomToJoin+")");

			if (e.params.error.indexOf("or was just deleted")>-1 && this.roomToJoin!="" && this.roomJoinErrorCount==0)
				{
				this.roomJoinErrorCount++;
				this.roomListActionParams = this.roomObjToJoin;
				this.roomListAction = 2;
				this.getRooms();
				}
			else
				{
				dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Odaya girerken hata oluştu! Oda listesini yenilemeniz gerekiyor.", width:190, height:140}));
				}
		}

		public function onConnectionLost(e:SFSEvent)	:void
			{
				dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Bağlantınız kesildiği için tekrar giriş yapmanız gerekiyor.", url: 'login.aspx' }));
			}

		public function onUserCountChange(e:SFSEvent) :void
			{ /* dispatchEvent(new Event('UPDATE_SEATS')); */ }

		public function get passingDrink() :Object
			{ var d:Object = this._passingDrink; this._passingDrink = {}; return d; }
		public function get newProfileId() :Number
			{ var n:Number = this._newProfileId; this._newProfileId = 0; return n; }

		public function get buddies()				:Array	{ return this.buddylist; }
		public function get playerIndex()		:Number	{ return this._playerIndex; }
		public function get roomList()			:Object	{ return this.rooms; }
		public function get player_scores()		:Array	{ return this.scores; }
		public function get cards_player()		:Array	{ return this.pockets; }
		public function get cards_table()		:Array	{ return this.tablecards; }
		public function get ping()					:int		{ return this.avgPing; }
		public function get joinedUsers()		:Array	{ return this.roomUsers; }
		public function get joinedPlayers()		:Array	{ return this.roomPlayers; }
		public function get myid()					:Number	{ return this._myid; }
		public function get roomid()				:Number	{ return this._roomId; }
		public function get lobbyid()				:Number	{ return this._lobbyId; }
		public function get gamesetup()			:Array	{ return this._gameconfig; }
		public function get userNick()			:String	{ return srv.myUserName; }
		public function get userId()				:Number	{ return srv.myUserId; }
		public function get playerObjs()			:Array	{ return this._playerObjs; }
		public function get stillConnected()	:Boolean	{ return srv.isConnected; }
		public function get userCount()			:Number	{ return this._userCount; }
		public function get winners()				:String	{ return this._winners; }
		public function get newDBId()				:Number	{ return this._newCreatedDBId; }
		public function get newSFId()				:Number	{ return this._newCreatedSFId; }
		public function get heads()				:String	{ return this._heads; }
		public function get seats()				:String	{ return this._seats; }
		public function get whoWon()				:Number	{ return this._whoWon; }
		public function get usersRooms()			:Array	{ return this._usersRooms; }

//==============================================================================
// IEventDispatcher
//==============================================================================
		public static function getInstance() :mRoom
		{
			if(mRoom._instance == null)
				mRoom._instance = new mRoom(new SingletonEnforcer());
			return mRoom._instance;
		}
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, weakRef: Boolean = false):void
			{ dispatcher.addEventListener(type, listener, useCapture, priority, weakRef); }
		public function dispatchEvent(e:Event) :Boolean
			{ return dispatcher.dispatchEvent(e); }
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) :void
			{ dispatcher.removeEventListener(type, listener, useCapture); }
      public function hasEventListener(type:String) :Boolean
			{ return dispatcher.hasEventListener(type); }
		public function willTrigger(type:String):Boolean
			{ return dispatcher.willTrigger(type); }
//==============================================================================
// Game mechanics
//==============================================================================
		public function joinBuddyRoom(id:Number, pass:String):void
		{
//			this.autoSit = true;
			srv.joinRoom(id, pass, true);
		}

		private function onBuddyRoomHandler(e:SFSEvent):void
		{
main.log.info('mRoom handled');
			srv.joinRoom(e.params.idList[0]);
		}

		public function turnEnd():void
		{
			srv.sendObject({cmd:'turnender'});
		}

		public function calcSeats(notify:Boolean = true):void
		{
//main.log.info("["+main._me['userId']+"]: calcSeats start");
		try{
		var room:Object = srv.getActiveRoom();

		// uSx, odadaki oyuncuların profileid ve smartfoxid'sini bileşik
		// olarak iletir (sfoxid:profileid:index:flags:joinorder) ve bu string,
		// main._me içinde seats olarak saklanır.
		// uSx oda değişkeni, oyuncunun smartfoxid'si ile bileşik isimlendiriliyor
		// bu şekilde herkes kendisine ait uSx değişkenini alır
		// index bozuk olmaması için, her uSx alan, kendisi önde oturacak şekilde
		// bu diziyi kaydırarak ve index değerlerini düzelterek kaydeder
		var users:Array = [];

		for (var ci:Number=0; ci<10; ci++)
		{
			var t:String = room.getVariable('uSx_'+String(ci));
			if (t!=null){
				users.push(t);				// sfoxid : userId : playerIndex : flags : joinOrder
			}
		}

		var myIdx:Number = -1, myIdx2:Number = -1, tmu:Number = -1;
		var av:Array;
		for(var i:Number=0; i<users.length; i++)
		{
			av = users[i].split(':');								// aç
			if (av[0] == srv.myUserId) myIdx = i;
			if (main._me.joinord>-1 && av[4]>main._me.joinord && (myIdx2==-1 || av[4]<myIdx2)) { myIdx2 = i; tmu = av[0]; } //joinord'u bizimkinden buyuk ama aralarinda en dusuk oyuncuyu al
		}

//main.log.trace("["+main._me['userId']+"] myidx is "+myIdx+" myidx2 is "+myIdx2+" ("+tmu+")");
	if (myIdx==-1) myIdx=myIdx2; //oturursak joinorder'a gore nasil gorecegimiz
	if (myIdx==-1) myIdx=0; //spectator

		if(users.length==0)
			{
			main.sittingDucks = "";
			main.sittingGhosts = "";
			main.sittingFolded = "";
			main._me['seats'] = "";
			}

		if(users.length>0){
			var rs:Array = users.concat(users);					// overflowing array
			var firstUs:String = "";
			var firstSd:String = "";
			var firstSg:String = "";
			var firstSf:String = "";
			var seatsUpdated:Boolean = false;

			for(var di:Number=0; di<users.length; di++)
			{
				var uset:Array = rs.slice(di+myIdx, di+myIdx+users.length);

				var uixs:Array = []; //oturanlarin indexleri
				var uixg:Array = []; //ghostlarin indexleri
				var uixf:Array = []; //foldedlarin indexleri
				for(var uix:Number=0; uix<uset.length; uix++)
				{															// overwrite the playerIndex part of each
					av = uset[uix].split(':');								// aç
					av[2] = String(uix);								// değiştir
					uset[uix] = av.join(':');						// kapa
					uixs[uix] = av[2];
					if ((av[3] & 6)>0) uixg.push(uix);
					if ((av[3] & 1)>0) uixf.push(uix);
				}

				var us:String = uset.join(';');									// rebuild the whole string
				if (firstUs=="") firstUs=us;
				if (firstSd=="") firstSd=uixs.join(",");
				if (firstSg=="") firstSg=uixg.join(",");
				if (firstSf=="") firstSf=uixf.join(",");

				var sxa:Number = us.indexOf(':');
				var sxb:Number = us.indexOf(':', sxa+1);
				var uid:Number = Number(us.substr(sxa+1, sxb-sxa-1));
//main.log.info("["+main._me['userId']+"] uid="+uid+", userid="+main._me['userId']+", myrealid="+this.myrealid+", myUserId:"+srv.myUserId);
				if (uid==srv.myUserId)
					{
					main._me['seats'] = us;
					main.sittingDucks = uixs.join(",");
					main.sittingGhosts = uixg.join(",");
					main.sittingFolded = uixf.join(",");
					seatsUpdated = true;
//					main.log.info("["+uid+"] updating seats: "+us);
					}

//			main.log.info("15: uid="+uid);
				if (!this._playerObjs[uid]) this._playerObjs[uid]={};
//				if (this._playerObjs) main.log.info("15.5: "+this._playerObjs[uid]);
//			if (this._playerObjs[uid]) main.log.info("15.7: "+this._playerObjs[uid].seats);
				this._playerObjs[uid].seats = us;

//			main.log.info("16");
			}
		if (!seatsUpdated)
			{
			main.sittingDucks = firstSd;
			main.sittingGhosts = firstSg;
			main.sittingFolded = firstSf;
			main._me['seats'] = firstUs;
			}
		}
//main.log.info("["+main._me['userId']+"]: calcSeats OK");
	}catch(e:Error){main.log.info("["+main._me['userId']+"]: calcSeats ERROR! "+e.message);};

		dispatchEvent(new Event('SHOW_HEADS'));
		dispatchEvent(new Event('LIGHT_THE_CANDLES'));

		if (notify)
			{
			srv.sendObject({cmd:'updateseats'});
			}
		}
		/**
		 * smartfox tarafından herkesin alacağı bilgileri oda değişkenleri
		 * üzerinden iletmek daha az paket iletilmesini sağlıyor.
		 */
		private function onRoomVars(e:SFSEvent):void
		{
			var changedVars:Array = e.params.changedVars;
			var tmp:Number;

			for (var v:String in changedVars)
			{
//main.log.info("["+main._me['userId']+"]: onroomvars: "+v);

				switch(v)
				{
					case 'pc':
						tmp = e.params.room.getVariable('pc');
						dispatchEvent(new impEvent('PLAYERCOUNT_UPDATE', {count:tmp}));
						break;
					case 'turnProgress':
						tmp = e.params.room.getVariable('turnProgress');
						if (tmp==this.turnStatus)
							{
							main.log.info("["+main._me['userId']+"]: DUPE turnStatus: "+this.turnStatus);
							return;
							}
						else
							{
							this.turnStatus = tmp;
							main.log.info("["+main._me['userId']+"]: turnStatus: "+this.turnStatus);
							}
						if (this.turnStatus == 1)
							{
							main.log.info("["+main._me['userId']+"]: TURN_START!!!!!!!");
							dispatchEvent(new Event('TURN_START'));
							}
						else
							{
							main.log.info("["+main._me['userId']+"]: TURN_END!!!!!!!!");
							dispatchEvent(new Event('TURN_END'));
							}
						break;

					case 'dealer':
						this.dealerSfid = e.params.room.getVariable('dealer');
						dispatchEvent(new impEvent('DEALER_CHANGE', {sfid:this.dealerSfid}));
						break;

					// herkesin sahip olduğu para miktarı bilgisi, paketli olarak iletiliyor
					case 'csH':
						var cashSet:String = e.params.room.getVariable('csH');
						var csA:Array = cashSet.split(';');
						for(var csax:String in csA){
							var ea:String = csA[csax];
							var eaA:Array = ea.split(':');

							var cashOwner:Number = Number(eaA[0]);
							var cashAmt:Number = Number(eaA[1]);

							this._playerObjs[cashOwner]['useableCash'] = cashAmt;
							if (cashOwner == Number(main._me['userId']))
								{
								main._me['useableCash'] = rounder(cashAmt);
								}
						}
						dispatchEvent(new Event('UPDATE_ALL_CASH'));
						break;

					case 'turnAt':
						try
							{
							tmp = parseInt(e.params.room.getVariable('turnAt'));
							}
						catch(ex:Error)
							{
							tmp=0;
							}
						this.whosTurn = tmp;
						dispatchEvent(new impEvent('TURN_POSITION', {sfid:this.whosTurn}));
						break;
				}
			}

		calcSeats();
		}

		public function payYourDrink(p:Number):void
		{
			srv.sendXtMessage('turn', 'dPt', {price: p});
		}

		public function bartender(d:Object):void
		{
			main.log.info('mrooma geldim');
			srv.sendObject({cmd:'drink', item:d});
		}

		private function onUserVars(e:SFSEvent):void
		{
			var changedVars:Array = e.params.changedVars;
			for (var v:String in changedVars){
				var h:String = e.params.user.getVariable(v);
				switch (v)
				{
					case 'pck_'+this._myid:
						main.log.info(this._myid+"'s hand is "+h);
						dispatchEvent(new impEvent('CARDS_UPDATE', {cards:h.split(';')}));
						break;
				}
			}
		}

		public function gameFolded(timedOut:Boolean = false) :void
		{
			if (timedOut)
				srv.sendXtMessage('turn', 'fLdt', {id:this.bidCounterAt});
			else
				srv.sendXtMessage('turn', 'fLd', {id:this.bidCounterAt});
//			srv.sendObject({cmd:'turnender'});
		}

		public function sitOut(sitIn:Boolean = false) :void
		{
			main.log.trace("sitOut called: "+sitIn);
			if (sitIn)
				srv.sendXtMessage('turn', 'sii', {});
			else
				if(Number(main._me['autoBuyinto']) == 0){
					srv.sendXtMessage('turn', 'sio', {});
				}
		}

		public function kickUser(sfid:Number): void
		{
			// kick him
			srv.sendXtMessage('zone', 'kCk', {uid: sfid});
		}

		public function tableReady(): void
		{
			main.log.info("tableReady");
			srv.sendXtMessage('turn', 'tbr', {});
		}

		public function postHandResult(params:Object): void
		{
		params.who = this._myid;
		srv.sendObject({cmd:'handResult', data:params});
		}

		public function biddingRaised(params:Object) :void
		{
			main.log.info('mRoom:biddingRaised (amount=' + params.amount +', type=' + params.type+")");
			params.id = this.bidCounterAt;

			var tms:Timer = new Timer(1000, 1);
			try{
			tms.addEventListener(TimerEvent.TIMER_COMPLETE, function (e:TimerEvent):void {
//				main.log.info('Fire bRs');
				srv.sendXtMessage('turn', 'bRs', params);
			});
			} catch(err:Error) {main.log.info('hata:'+err.message)}
			tms.start();
		}

		/**
		 * smartfox tarafından sendResponse ile iletilen paketler
		 */
		private function onExtensionHandler(e:SFSEvent):void
		{
			var type:String = e.params.type;
			var data:Object = e.params.dataObj;
			var cmd:String = data[0];
			var roomid:String = data[1];
			var h:String = data[2];
			var k:String = data[3];
			var l:String = data[4];
			var m:String = data[5];
			var n:String = data[6];

			main.log.info('_CMD : '+data[0]);

			if(type == SmartFoxClient.XTMSG_TYPE_STR){
				switch(cmd)
				{
/*
					case 'cAu':		// clean all users fold flag
						dispatchEvent(new Event('TURN_END'));
						break;
*/
					case 'uSt':		// user lost
						break;
					case 'kCd':		// kicked
						dispatchEvent(new Event('LEAVE_GAME'));
						break;
					case 'uLr':		// dbid_username:userid:roomid
						onlineBuddiesReceived(h);
						break;
					case 'uMr':		// dbid_username:ulevel
main.log.info('>>>>>> received the list');
main.log.info(h);
						modListReceived(h);
						break;
					case 'fUi':
						srv.sendXtMessage('turn', 'fUs', {who:this.myrealid});
						srv.sendXtMessage('turn', 'sMs', {});
						dispatchEvent(new Event('FIRST_IN_ROOM'));
						break;
					case 'jPt':
						srv.sendXtMessage('turn', 'sMs', {});
						break;
					case 'jor':
//						main.log.trace(this.myrealid+"'s joinOrd is "+h);
						dispatchEvent(new impEvent('JOINORD_UPDATE', {jo:Number(h), roomOwner: Number(k)}));
						break;
					case 'neG':
						dispatchEvent(new Event('NEW_GAME_SOON'));
						break;
					case 'sio':
						dispatchEvent(new impEvent('FORCED_SIT_OUT', {reason:h}));
						break;
					case 'gst':
						dispatchEvent(new impEvent('GAME_STARTED'));
						break;

					case 'bls':
					case 'blb':
						dispatchEvent(new impEvent('BLINDS_PAID', {'type':(cmd=='bls'?'small':'big'), 'amount':Number(h), 'sfid':Number(k)}));
						break;

/*
					case 'nCs_'+this._myid:
						this._playerCash = Number(h);
						dispatchEvent(new Event('USERCASH_UPDATED'));
						break;
*/
					case 'tBl':
						dispatchEvent(new impEvent('UPDATED_TABLECASH', {amount:Number(h)}));
						break;

					case 'doB':
						srv.sendXtMessage('turn', 'sMs', {});
						this.bidCounterAt = String(data[8]);
						dispatchEvent(new impEvent('ACCEPT_BID', {'toCall':Number(h), 'minRaise':Number(k), 'openingBet':(l=="1"), 'maxRaise':Number(m), 'maxBet':Number(n), 'firstToAct':(String(data[7])=="1")}));
						break;

					case 'bto': //bid timed out serverside
						if (h != this.bidCounterAt)
							{
							main.log.trace("bto but id mismatch: got "+h+", expected "+this.bidCounterAt);
							}
						else
							{
							dispatchEvent(new impEvent("BIDDING_COMPLETE", {type:'timeout-server'}));
							}
						break;

					// poker_turn.as ile packets[] içinden iletilen oyun kağıtları
					case 'flp':
						logWriter(renameCards('3 masa kağıdı geldi: '+h), true);
						this._tableCards = h.split(';');
						dispatchEvent(new impEvent('TABLECARDS_UPDATE', {round:2, cards:this._tableCards}));
						break;
					case 'trn':
						logWriter(renameCards('turn kağıdı geldi: '+h), true);
						this._turnCard = h;
						dispatchEvent(new impEvent('TABLECARDS_UPDATE', {round:3, cards:[h]}));
						break;
					case 'rvr':
						logWriter(renameCards('river kağıdı geldi: '+h), true);
						this._riverCard = h;
						dispatchEvent(new impEvent('TABLECARDS_UPDATE', {round:4, cards:[h]}));
						break;
					case 'shw':
						srv.sendObject({cmd:'turnender'});
						break;

					// turn bitiminde elin hesaplanması ve oyuncunun
					// hangi kart grubunda kaç skor yaptığı
					case 'win':
						dispatchEvent(new impEvent('WINNERS_WON', {list:h.split(';')}));
						break;
				}
			}
		}
		private function logWriter(m:String, local:Boolean=false) :void
		{
		if (local)
			dispatchEvent(new impEvent('LOG_CONTENT', {message:m})); //display the message locally
		else
			dispatchEvent(new impEvent('LOG_MESSAGE', {message:m})); //display and distribute the message
		}
		public function renameCards(src:String) :String
		{
			var px:RegExp;
			px = /([\dAKQJT]+)([cdhs]+)[\;]+/g;
			src = src.replace(px, "$1$2, ");
			px = /([\dAKQJT]+)[c]+/g;
			src = src.replace(px, "sinek $1");
			px = /([\dAKQJT]+)[d]+/g;
			src = src.replace(px, "karo $1");
			px = /([\dAKQJT]+)[h]+/g;
			src = src.replace(px, "kupa $1");
			px = /([\dAKQJT]+)[s]+/g;
			src = src.replace(px, "maça $1");
			px = /([maça|sinek|karo|kupa]+) [A]+/g;
			src = src.replace(px, "$1 as");
			px = /([maça|sinek|karo|kupa]+) [K]+/g;
			src = src.replace(px, "$1 papaz");
			px = /([maça|sinek|karo|kupa]+) [Q]+/g;
			src = src.replace(px, "$1 kız");
			px = /([maça|sinek|karo|kupa]+) [J]+/g;
			src = src.replace(px, "$1 vale");
			px = /([maça|sinek|karo|kupa]+) [T]+/g;
			src = src.replace(px, "$1 on");
			return src;
		}
		private function rounder(v:Number) :Number
		{
			return(Math.floor(v/5)*5);
		}
//==============================================================================
	}
}
class SingletonEnforcer {}