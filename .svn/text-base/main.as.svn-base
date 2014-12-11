package
{
	import flash.display.Stage;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.geom.Matrix;
	import flash.system.Security;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import flash.events.TimerEvent;
    import flash.utils.Timer;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.DataEvent;
	import flash.events.TimerEvent;
	import flash.events.FullScreenEvent;
	import flash.net.SharedObject;

	import com.flashdynamix.utils.SWFProfiler;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	import com.obsesif.utils.LoggingFactory;
	import com.adobe.utils.StringUtil;
	import net.stevensacks.utils.Web;

	import com.obsesif.models.mConfig;
	import com.obsesif.models.mRoom;
	import com.obsesif.models.mRemote;
	import com.obsesif.game.gTable;
	import com.obsesif.game.gLobby;
	import com.obsesif.events.impEvent;
	import com.obsesif.ui.UIButton;
	import com.obsesif.ui.UIAlert;
	import com.obsesif.ui.UIAlertPassword;

	[SWF(width="960", height="600", backgroundColor="#495865")]

	public class main extends Sprite
	{
      [Embed(source="/assets/UIElements.swf", symbol="winB")]
      private var rawWin:Class;
		[Embed(source="/assets/UIElements.swf", symbol="userbox")]
		private var rawUserBox:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik0")]
		private var rawCimdik0:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik1")]
		private var rawCimdik1:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik2")]
		private var rawCimdik2:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik3")]
		private var rawCimdik3:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik4")]
		private var rawCimdik4:Class;

		public static const _compileForRelease:Boolean = CONFIG::release;
		public static const debug:Boolean = CONFIG::debug;

		private var serverIp:String = '78.159.112.75';
		public static const log :Logger = LogContext.getLogger(main);

		public static var _me:Object;
		public static var _noSit:Boolean = false;

		private var buttonLogoff:UIButton;
		private var backgroundGradient:Sprite;
		public var _multiUser:mRoom;
		private var _table:gTable = null;
		private var _lobby:gLobby;
		public var myid:Number;
		private var alertDisconnect:Boolean = false;
		private var _top5:Array;
		private var _userBox:Sprite;
		private var ubw:Sprite;
		private var ubi:Sprite;
		private var _backImage:String = ""; //assets/nback.jpg";
		private var _adImage:String = "";
		private var _adUrl:String = "";
		private var cardsDealt:Boolean = false;
		private var tbrMuteStatus:Number = -1; //mute status before tbr till latest tbl
		private var _askForMore:Boolean = false;
		private var settings:SharedObject = null;
		private var _filter1:String = '';
		private var _filter2:String = '';
		private var _filter3:String = '';
		private var _filter4:String = '';
		private var totalDisplay:TextField;
		private var remoteCashCounter:Number = 0;
		private var kickWinFlag:Boolean = false;

		public static var sittingDucks:String;
		public static var sittingGhosts:String; //sittingducks icindeki adamlardan ghost olmasi gerekenler
		public static var sittingFolded:String; // denden denden folded denden

		public function main() :void
		{
			Security.allowDomain('*');
			Security.loadPolicyFile('xmlsocket://'+this.serverIp+':9339');
			LoggingFactory.getInstance();

			try{
				settings = SharedObject.getLocal("zukaa/poker", "/");
			}catch(e:Error){
			//	trace("Can't get SO: "+e);
				}

			stage.scaleMode	= StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			stage.align = StageAlign.TOP;
			stage.frameRate	= 25;

			if(!main._compileForRelease){
				SWFProfiler.init(stage, this);
			}
/*
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.ADDED, onStageResize);
			stage.addEventListener(Event.RESIZE, onStageResize);
*/
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, function(e:FullScreenEvent):void {
				if(e.fullScreen == false) {
					_table._cb._fsWarn.visible = false;
				}
			});
			_multiUser = mRoom.getInstance();

			var backgroundGradient:Sprite = new Sprite();
			addChildAt(backgroundGradient, 0);

			var _msk:Shape = new Shape();
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, /*960*/1920, /*600*/1080);
			_msk.graphics.endFill();
			this.mask = _msk;

			var _mrL:mRemote = new mRemote('getSkin', {});
			_mrL.addEventListener('RC_DATA_SAVED', rcSkin);
			_mrL.run();

			addEventListener('DISPLAY_ALERT', displayAlertHandler);
		}

//==============================================================================
// Bootstrap
//==============================================================================
/*
		private function rcBuyInto(e:Event) :void
		{
			var amt:Number = Number(e.target.valueNum);
			if (isNaN(amt))
				{
				main.log.info("buyInto error, server returned "+e.target.valueNum);
				return;
				}
			main.log.info("buyInto "+amt);
			_me['total'] -= amt;
			_me['useableCash'] = amt;

			_multiUser.playMoney(amt);

			main._noSit = false;

//			_table._buyInto.setVals(0, _me['total']);
			_table._buyInto.setVals(_table._buyInto.minAmount, _table._buyInto.maxAmount);
			_table.dispatchEvent(new Event("SIT_IN"));
		}
*/
		private function rcSkin(e:Event) :void
		{
			var o:Object = e.target.singleObj;

			this._adImage = "";
			this._adUrl = "";

			for(var x:String in o)
				{
				try
					{
					if (o[x]['back']) this._backImage = o[x]['back']
					if (o[x]['ad']) this._adImage = o[x]['ad'];
					if (o[x]['url']) this._adUrl = o[x]['url'];
					}catch(e:Error){main.log.trace("rcSkin x="+x+" / +ex:"+e);}
				}

			_lobby = new gLobby(stage, this._adImage, this._adUrl);
			_lobby.visible = true;
			addChild(_lobby);

			_userBox = new rawUserBox();
			addChild(_userBox);
			_userBox.x = 705;
			_userBox.y = 520;

			addEventListener('SENDING_DRINK', buyingDrink);

			rcLogin();
		}

		private function rcLogin() :void
		{
			var _mrP:mRemote = new mRemote('loggedProfile', {});
			_mrP.addEventListener('RC_DATA_SAVED', rcLoggedIn);
			_mrP.run();
//				_me = {sfoxname: "obsesif", userId: 12345, peanut: 1, useableCash: 1, levels: 5, uri: "obsesif", nickname: "obsesif"};
		}

		private function rcLoggedIn(e:Event) :void
		{
			_me = e.target.valueObj;
			
			_me['amiowner'] = false;
			
			main.log.info('Secure mod: ' + _me['msdata']);
			if(_me['msdata']) {
				main.log.info('Security up & running');
				_me['mod'] = 0;
				switch(_me['msdata']) {

					case '66ZAW75Z':
						_me['mod'] = 1;
						break;
					case '09GBE56W':
						_me['mod'] = 2;
						break;
					case '43FVK62S':
						_me['mod'] = 3;
						break;
					case '11JUL036':
						_me['mod'] = 4;
						break;
				
				}
			}
			

			if (!_me || isNaN(_me['userId']) || _me['userId']<1 || !_me['key'] || String(_me['key']).length<8)
				{
				dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Sunucuyla iletişim problemi oluştu, lütfen tekrar giriniz.", url: 'login.aspx'}));
				return;
				}

			_me.sfoxname = _me['userId'] + '_' + _me['uri'];
			_me.joinord = -1;
			_me.totalExpired = false;
			var _alert:UIAlert;

			// gelen para illa ki 5'in katları olsun...
			_me['useableCash'] = Math.floor(_me['useableCash']/5)*5;
			_me['total'] = Math.floor(_me['total']/5)*5;

			_me['key'] = String(_me['key']);

main.log.info('KEY is '+_me['key']);
//_me['total'] = 700;
main.log.info('MOD is '+_me['mod']);

			// this will be always 1 for manual moded buyinto isn't wanted anymore
			_me['autoBuyinto'] = 1;

			getBuddies();
			_serverSideBooted();
		}
		
		private function getBuddies():void
		{
		var _mrB:mRemote = new mRemote('buddyList', {param: String(_me['userId']), key:_me['key']});
		_mrB.addEventListener('RC_DATA_SAVED', rcBuddiesRetrieved);
		_mrB.run();
		}

		private function _serverSideBooted() :void
		{
			buttonLogoff = new UIButton(this,  880, -3, "çıkış", 'button', logOff, .6, .8);

			writeLine(_userBox, 'Hoşgeldin '+_me['uri'], 240, 'AirSans', 0xffffff, 16, 20, 3);
			totalDisplay = writeLine(_userBox, 'Çimdik: '+String(_me['total']), 240, 'AirSans', 0xffffff, 16, 70, 32);
			var cimdik:Sprite;
			if(Number(_me['membershipType']) >-1 && Number(_me['membershipType'])<5){
				if(Number(_me['membershipType']) == 0) cimdik = new rawCimdik0();
				if(Number(_me['membershipType']) == 1) cimdik = new rawCimdik1();
				if(Number(_me['membershipType']) == 2) cimdik = new rawCimdik2();
				if(Number(_me['membershipType']) == 3) cimdik = new rawCimdik3();
				if(Number(_me['membershipType']) == 4) cimdik = new rawCimdik4();
			}else{
				cimdik = new rawCimdik0();
			}
			_userBox.addChild(cimdik);
			cimdik.x = 25;
			cimdik.y = 25;

			if(main._compileForRelease){
				if (!main.debug)
					main.log.trace("rel");
				else
					main.log.trace("rel+debug");
				_multiUser.boot(this.serverIp, 9339, 'poker');
			}else{
				if (!main.debug)
					main.log.trace("dev");
				else
					main.log.trace("dev+debug");
				_multiUser.boot(this.serverIp, 9339, 'poker_dev');
			}

			_multiUser.addEventListener('FIRST_IN_ROOM', firstInRoom);
			_multiUser.addEventListener('ROOMS_LOADED', _multiUserBooted, false, 0, true);
			_multiUser.addEventListener('ROOMS_READY', roomsBooted, false, 0, true);
			_multiUser.addEventListener('PING_CALCULATED', gotPing, false, 0, true);

			_multiUser.addEventListener('ROOM_JOINED', joinedGame);
			_multiUser.addEventListener('LOBBY_JOINED', joinedLobby);
			_multiUser.addEventListener('ROOMS_REFRESH', roomsRefresh);

			_multiUser.addEventListener('CARDS_UPDATE', cardsUpdate);
			_multiUser.addEventListener('TABLECARDS_UPDATE', tableCardsUpdate);
			_multiUser.addEventListener('GAME_STARTED', gameStarted);
			_multiUser.addEventListener('ACCEPT_BID', bidsAccepting);
			_multiUser.addEventListener('PLAYERCOUNT_UPDATE', playerCountUpdate);
			_multiUser.addEventListener('JOINORD_UPDATE', joinOrdUpdate);

			_multiUser.addEventListener('UPDATED_TABLECASH', updatedTableCash);
			_multiUser.addEventListener('USERCASH_UPDATED', uCashUpdated);
			_multiUser.addEventListener('BLINDS_PAID', blindsPaid);

//			_multiUser.addEventListener('OTHERS_LEAVING', leavingRoom);
			_multiUser.addEventListener('ROOM_CREATED', roomCreated);
			_multiUser.addEventListener('LIGHT_THE_CANDLES', lightCandles);

			_multiUser.addEventListener('SHOW_PROFILE', showHeads);
			_multiUser.addEventListener('UPDATE_SEATS2', updateSeats2);

			_multiUser.addEventListener('SHOW_HEADS', showHeads);
			_multiUser.addEventListener('DRINK_SERVED_COLD', drinkServed);
			_multiUser.addEventListener('HAND_RESULT', handResult);
			_multiUser.addEventListener('TURN_POSITION', turnPosition);
			_multiUser.addEventListener('SOMEONE_LEFT', someoneLeft);
			_multiUser.addEventListener('UPDATE_ALL_CASH', showHeads);
			_multiUser.addEventListener('TURN_END', turnEnd);
			_multiUser.addEventListener('TURN_START', turnStart);
			_multiUser.addEventListener('DEALER_CHANGE', dealerChange);
			_multiUser.addEventListener('BUDDIES_CHECKED', buddiesChecked);
			_multiUser.addEventListener('WINNERS_WON', winnersWon);
			_multiUser.addEventListener('LOG_CONTENT', addLogContent);
			_multiUser.addEventListener('NEW_GAME_SOON', newGameSoon);
			_multiUser.addEventListener('FORCED_SIT_OUT', forcedSitOut);
			_multiUser.addEventListener('LEAVE_GAME', outofGame);

			_multiUser.addEventListener('SITTING_NOW', sittingNow);
			_multiUser.addEventListener('STANDING_NOW', standingNow);

			_multiUser.addEventListener('PUBLIC_MESSAGE', publicMessageReceived);
			_multiUser.addEventListener('LOG_MESSAGE', sendLogMessage);
			_multiUser.addEventListener('DISPLAY_ALERT', displayAlertHandler);
			_multiUser.addEventListener('MODLIST_BUILT', buildModList);
			_multiUser.addEventListener('BIDDING_COMPLETE', biddingComplete);

			_multiUser.checkPing();
		}

		private function logOff(e:Event) :void {
			var _mrR:mRemote = new mRemote('logOut', {param: String(_me['userId']), key:_me['key']});
			_mrR.addEventListener('RC_DATA_SAVED', loggedOut);
			_mrR.run();
		}

		private function loggedOut(e:Event) :void {
			main.log.warn('logged out...');
//			var jscommand:String = "window.top.location='http://www.zukaa.com';";
			var jscommand:String = "window.opener.location='http://www.zukaa.com';self.close();";
			var req:URLRequest = new URLRequest("javascript:" + jscommand + " void(0);");
			navigateToURL(req, "_self");
		}

		private function displayAlertHandler(e:impEvent) :void
		{
		try{
			displayAlert(e.params.message, e.params.width||300, e.params.height||90, e.params.url);
		}catch(e:Error){_table.loguser("displayAlertHandler exception: "+e);}
		}

		private function displayAlert(message:String, width:Number=300, height:Number=90, url:String=""): void
		{
		try{
			if (width==0) width=300;
			if (height==0) height=90;
			var a:UIAlert = new UIAlert(this, width, height, message, "Tamam");
			if(url=="" || url==null)
			{
				a.addEventListener('CLOSE_ME', function closeAlert(e:Event):void{ e.target.parent.removeChild(e.target); kickWinFlag = false; });
			}else{
				a.addEventListener('CLOSE_ME', function closeAlert(e:Event):void{ Web.getURL("http://www.zukaa.com/"+url, '_self'); kickWinFlag = false; });
			}
		}catch(e:Error){_table.loguser("displayAlert exception: "+e);}
		}

		private function newGameSoon(e:Event) :void
		{
			cardsDealt = false;
			_table.newGameSoon();
		}

		private function turnEnd(e:Event) :void
		{
			if(_table._cTimer.running) {
				var cTimer:Timer = new Timer((450*6), 1);
				cTimer.start();
				cTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void{
					cardsDealt = false;
					_table.turnEnded();
				});
			} else {
				cardsDealt = false;
				_table.turnEnded();
			}
		}
		private function turnStart(e:Event) :void
		{
try{
			_table.turnStarted();
			_table.changeDealer(_multiUser.dealerSfid);
}catch(e:Error){_table.loguser("turnStart exception: "+e);}
		}
		private function dealerChange(e:impEvent) :void
		{
try{
			_table.changeDealer(e.params.sfid);
}catch(e:Error){_table.loguser("dealerChange exception: "+e);}
		}

		private function doSitOut(e:Event):void { _multiUser.sitOut(); }
		private function doSitIn(e:Event):void { _multiUser.sitOut(true); }
		private function forcedSitOut(e:impEvent):void { _table.forcedSitOut(e.params); }

		private function someoneLeft(e:impEvent) :void
		{
			_table.someoneLeft(e.params.sfid);
		}

		private function turnPosition(e:impEvent) :void
		{
			if (e.params.sfid==_me.sfoxId)
				{
				_table.loguser("turnPosition at me!");
				return;
				}

			_table.loguser("turnPosition at "+e.params.sfid);
			_table.handleMultiTurnUI(e.params.sfid);
		}

		private function drinkServed(e:Event) :void
		{
			_table.passDrink( _multiUser.passingDrink );
		}

		private function handResult(e:impEvent) :void //baska oyuncunun bidi
		{
			_table.passBid(e.params);
		}

		private function lightCandles(e:Event) :void
		{
			_table.lightItUp(sittingDucks, sittingGhosts, sittingFolded);
		}

		private function showHeads(e:Event) :void
		{
			_table.showHeads( _me.seats, _multiUser.playerObjs );
		}

		private function rcBuddiesRetrieved(e:Event) :void
		{
			_me.buddies = e.target.singleArr;
			updateBuddies();
		}
		
		private function updateBuddies():void
			{
			if (_me && _me.buddies) _multiUser.buddyCheck(_me.buddies);
			}

		private function buddiesChecked(e:impEvent) :void
		{
			_lobby.buildBuddyList(e.params.buddies);
		}

		private function _multiUserBooted(e:Event) :void
		{
		try{
			_me.sfoxId = _multiUser.myid;
			_multiUser.saverealid(_me['userId']);
			_multiUser.saveInfo(_me);

			_multiUser.removeEventListener('ROOMS_LOADED', _multiUserBooted);

			var dropTimer:Timer = new Timer(3000);
			dropTimer.addEventListener(TimerEvent.TIMER_COMPLETE, dropIRQ);
			dropTimer.start();
		}catch(e:Error){main.log.info("_multiUserBooted exception: "+e);}
		}

		private function roomsBooted(e:Event) :void
		{
			_multiUser.removeEventListener('ROOMS_READY', roomsBooted);
			_lobby.addEventListener('LOBBY_REFRESH', lobbyRefresh);
//			_lobby.addEventListener('JOIN_BUTTON', intoGame);
			_lobby.addEventListener('ROOM_SELECTED', gameSelect);
			_lobby.addEventListener('MESSAGE_UP', sendLogMsgTx);
			_lobby.addEventListener('CREATE_ROOM', createRoom);
			_lobby.addEventListener('BUDDY_CLICKED', buddyClicked);
			_lobby.addEventListener('FILTER_SET', filterSet);

			var _mrR:mRemote = new mRemote('nestedrooms', {});
			_mrR.addEventListener('RC_DATA_SAVED', roomsCombine);
			_mrR.run();
		}

		private function filterSet(e:impEvent) :void
		{
			var _mrR:mRemote = null;

			if(e.params.menu == 0){
				if(e.params.item == 1)
					lobbyRefresh(null);
				if(e.params.item == 2)
					_mrR = new mRemote('filterednestedrooms', {param1: 'No',		param4: 'ASC'});
				if(e.params.item == 3)
					_mrR = new mRemote('filterednestedrooms', {param1: 'Limit',	param4: 'ASC'});
				if(e.params.item == 4)
					_mrR = new mRemote('filterednestedrooms', {param1: 'Pot',	param4: 'ASC'});
			}
			if(e.params.menu==1 && e.params.item==1)
				_mrR = new mRemote('filterednestedrooms', {param2: 'ASC',	param1: 'All'});
			if(e.params.menu==1 && e.params.item==2)
				_mrR = new mRemote('filterednestedrooms', {param2: 'DESC',	param1: 'All'});

			if(e.params.menu==2 && e.params.item==1)
				_mrR = new mRemote('filterednestedrooms', {param3: 'ASC',	param1: 'All'});
			if(e.params.menu==2 && e.params.item==2)
				_mrR = new mRemote('filterednestedrooms', {param3: 'DESC',	param1: 'All'});

			if(e.params.menu==3 && e.params.item==1)
				_mrR = new mRemote('filterednestedrooms', {param4: 'ASC',	param1: 'All'});
			if(e.params.menu==3 && e.params.item==1)
				_mrR = new mRemote('filterednestedrooms', {param4: 'DESC',	param1: 'All'});

			if (_mrR!=null)
				{
				_mrR.addEventListener('RC_DATA_SAVED', roomsCombineOnRefresh);
				_mrR.run();
				}

//			main.log.info(p1 + '...' + e.params.menu + ' / ' + e.params.item);
		}

		private function createRoom(e:impEvent) :void
		{
			var roomProp:Object = e.params.roomAttr;
			
			var str:String;
			for (var p:String in roomProp){
				str += '&' + p + '=' + roomProp[p];
			}
			main.log.info('ODA PARAMETRELERİ:' + str);
			
			roomProp.uid = _me['userId'];
			roomProp.key = _me['key'];
			var _mrR:mRemote = new mRemote('newroom', roomProp);
			_mrR.addEventListener('RC_DATA_SAVED', lobbyRefresh);
			_mrR.run();
// http://www.zukaa.com/gwJson.aspx?cmd=newroom&bi=10&ps=&tl=30&minb=NaN&uid=12&maxb=NaN&param11=0&minl=1&mu=6&maxl=5&vw=4&mid=0&rn=waga&gt=1&st=1&bs=1&bb=2
			_lobby.closeNewRoomWindow();
		}

		private function rcTop5Loaded(e:Event) :void
		{
			_lobby.tops(e.target.singleArr);
		}

		private function roomsCombineOnRefresh(e:Event) :void
		{
			_multiUser.roomListActionParams = e.target.valueObj;
			_multiUser.roomListAction = 1;
			_multiUser.getRooms();
/*
			var gr:Object = e.target.valueObj;
			_multiUser.addEventListener('ROOMS_ADDED', lobbyBuild);
			_multiUser.addTempRooms(gr);
*/
		}

		private function roomsRefresh(e:impEvent):void //sfox refresh
		{
		var gr:Object = e.params.params;
		_multiUser.addEventListener('ROOMS_ADDED', lobbyBuild);
		_multiUser.addTempRooms(gr);
		}

		private function roomsCombine(e:Event) :void
		{
			var gr:Object = e.target.valueObj;
			_multiUser.addEventListener('ROOMS_ADDED', lobbyBuild);
			_multiUser.addTempRooms(gr);

			var _mrt5:mRemote = new mRemote('users', {param:'top5'});
			_mrt5.addEventListener('RC_DATA_SAVED', rcTop5Loaded);
			_mrt5.run();
		}

		private function lobbyBuild(e:Event) :void
		{
			_multiUser.removeEventListener('ROOMS_ADDED', lobbyBuild);
			_lobby.build(_multiUser.roomList, Number(_me['levels']));
		}

		private function lobbyRefresh(e:Event) :void
		{
			_lobby.cleanRooms();

			var _mrR:mRemote = new mRemote('nestedrooms', {});
			_mrR.addEventListener('RC_DATA_SAVED', roomsCombineOnRefresh);
			_mrR.run();
			getBuddies();
		}

		private function roomCreated(e:Event) :void			// dbid, matchid
		{
			main.log.info("DB: " + _multiUser.newDBId + " / SF: " + _multiUser.newSFId);
			var mr:mRemote = new mRemote('updateMatchId', {param1:_multiUser.newDBId, param2:_multiUser.newSFId});
			mr.run();
		}

//==============================================================================
// various
//==============================================================================
		private function gotPing(e:Event) :void
		{
			_multiUser.removeEventListener('PING_CALCULATED', gotPing);
			log.info("our average ping is "+_multiUser.ping+" milliseconds...");
			if(Number(_multiUser.ping)>200){
				displayAlert("Sunucu bağlantısı çok yavaş ("+_multiUser.ping+" ms) olduğu için oyun oynanışında aksaklıklar olabilir. Yavaş bağlantıda profiller eksik gözükebilir ya da oyun işleyişi aksayabilir.");
			}
		}
		private function writeLine(p:Sprite, t:String, w:Number, f:String="AirSans", c:uint=0xffffff, s:Number=24, xpos:Number=10, ypos:Number=10) :TextField
		{
			var _format:TextFormat = new TextFormat();
			_format.font = f;
			_format.color = c;
			_format.size = s;
			_format.align = TextFormatAlign.LEFT;

			var _header:TextField = new TextField();
			_header.width = w;
			_header.embedFonts = true;
			_header.wordWrap = true;
			_header.selectable = false;
			_header.antiAliasType = AntiAliasType.ADVANCED;
			_header.defaultTextFormat = _format;
			_header.text = t;
			_header.x = xpos;
			_header.y = ypos;
			p.addChild(_header);

			return(_header);
		}
		private function onStageResize(e:Event) :void
		{
		}
		public function dropIRQ(e:TimerEvent):void
		{
			if(!_multiUser.stillConnected && !this.alertDisconnect){
				var _w:Sprite = new rawWin();
				addChild(_w);
				_w.x = (stage.width - _w.width)/2 -80;
				_w.y = 120;

				writeLine(_w, "UYARI:", _w.width-40, 'AirSansBold', 0xa00000, 24, 24, 50);
				var msg:String = "Üzgünüz, uzun süre işlem yapmadığınız için oyun odasından çıkartıldınız. Tekrar girmek için sayfayı yenileyin.";
				writeLine(_w, msg, _w.width-40, 'AirSans', 0xffffff, 16, 20, 150);

				this.alertDisconnect = true;

				log.info('just lost the connection dude...');
			}
			if(_lobby) _lobby.userCount = _multiUser.userCount;
		}
//==============================================================================
// Messaging
//==============================================================================
		private function publicMessageReceived(e:impEvent) :void
			{
				var sIdx:Number;
				sIdx = (_table) ? _table.grabSI( {need:'idx', have:'sfid', cmp:Number(e.params.sender)}, true) : -1;
				if(e.params.target == "right")
					if(e.params.screen == "LOBBY")
						_lobby.addChatContent(e.params.message, 'public', sIdx);
					else
						_table.addChatContent(e.params.message, 'public', sIdx);
				else
					_table.addLogContent(e.params.message);
			}
		public function sendLogMsgTx(e:impEvent) :void // Chat için dupe fn
			{
				_multiUser.sendMessage(e.params.screen, e.params.target, e.params.message);
			}
//==============================================================================
// SitDown & StandUp
//==============================================================================

		private function firstInRoom(e:Event) :void
		{
			_table.loguser("firstInRoom");
			sittingNow(null);
		}

		private function sitDown(e:Event) :void
		{
			_table.loguser("sitDown");
			try{
				_multiUser.sitPlayer();
		}catch(e:Error){_table.loguser("sitdown Exception:"+e.message);}
		}

		private function sittingNow(e:Event) :void //sitdown completed
		{
			_table.loguser("sittingNow");
			try{
			_table.setupSittingUser();

			_multiUser.playMoney(_me['useableCash']);
			_table.updatePanel(_me);			// 0ın uObj'sini vUser içine kaydet, bilgileri update eder

//			panelUpdate(); //daha once oturmus adam varsa bozuyor: sitting=true ama usx var'lari icinde henuz yokuz sanirim
		}catch(e:Error){_table.loguser("sitdownR Exception:"+e.message);}
		}

		private function standUp(e:Event) :void
		{
			_table.loguser("standUp");
			try{

			if (_table.myTurn)
				{
				_table.turnChange(false);
				_table._folded = true;
//				_table.dispatchEvent(new impEvent("BIDDING_COMPLETE", {type:'fold'})); //bunu yapinca server'da 2 event fire ediyor, 2 kere wta/winner hesabi oluyor
				}

			_multiUser.standPlayer();
		}catch(e:Error){_table.loguser("standUp Exception:"+e.message);}
		}

		private function standingNow(e:Event) :void //standup completed
		{
			_table.loguser("standingNow");
			try{
			_table.setupStandingPlayer();
		}catch(e:Error){_table.loguser("standingNow Exception:"+e.message);}
		}
/*
		private function leavingRoom(e:Event) :void
		{
			_table.loguser("leavingRoom: "+_multiUser.leaving);
			try{
			_multiUser.removeInfo(_multiUser.playerObjs[_multiUser.leaving]);
			panelUpdate();
		}catch(e:Error){_table.loguser("leavingRoom Exception:"+e.message);}
		}
*/

		private function updateSeats2(e:Event) :void
		{
//			log.info("updateSeats2");
			panelUpdate(false);
		}


//==============================================================================
// Game join & leaves
//==============================================================================
		private function gameSelect(e:Event) :void
			{ e.target.gameSelected = true; }

		public function cekilecekCimdik(min:Number, max:Number):Number
		{
			var _amount:Number = 0;
main.log.info('### ('+_me['total']+') MinMax: '+min+'/'+max);

			if (isNaN(_me['total'])) {
				main.log.trace("total is NaN!");
				return 0;
			}
/*
			else
				main.log.trace("total is: "+_me['total']);
*/

			if (Number(_me['total']) > max)
				{
				_amount = max;
				}

			else if (Number(_me['total']) < min*3)			// 3 katından az ise oturtma
				{
				}

			else if (Number(_me['total']) <= max)			// min*3'den büyük ve max'dan küçükse (else var basinda)
				{
				_amount = Number(_me['total']);
				}
			return(_amount);
		}

		private function intoGame(e:Event) :void
			{
				try{
					if (_me.totalExpired)
						{
						remoteCash(); //madem gelmemis tekrar request et
						dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Bilgiler güncellenemedi, lütfen tekrar deneyin."}));
						return;
						}

					if(_lobby.selectedGameObj.password == "")
						{
						intoGameReal(int(_lobby.selectedGame), _lobby.selectedGameObj);
						}
					else
						{
						var a:UIAlertPassword = new UIAlertPassword(this, 300, 90, int(_lobby.selectedGame));
						a.addEventListener('CLOSE_ME', function closeAlert(e:impEvent):void{
							if(e.params.pass != _lobby.selectedGameObj.password){
								intoGameReal(e.params.id, _lobby.selectedGameObj);
							}else{
								dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Üzgünüz, yanlış ya da eksik parola girdiniz."}));
							}
							e.target.parent.removeChild(e.target);
						});
					}


				}catch(e:Error){main.log.info("intoGame exception: "+e);}
			}

		private function intoGameReal(roomid:Number, gameObj:Object):void
			{
				try{
				_lobby.removeEventListener('JOIN_BUTTON', intoGame);

				var _amount:Number = cekilecekCimdik(gameObj.buyin, gameObj.buyinT);
				if (_amount>0)
					{
					main.log.trace("intoGame amt is "+_amount);
					main._me['total'] -= _amount;
					main._me['useableCash'] = _amount;
					main._noSit = false;
					_multiUser.playMoney(_amount);
					}
				else
					{
					main.log.trace("not enough money, can't sit");
					main._noSit = true;
					}
				_me.joinord = -1;
				_multiUser.joinRoom(roomid, gameObj);

				}catch(e:Error){main.log.info("intoGameReal exception: "+e);}
			}

		private function outofGame(e:Event) :void
			{
			_table.loguser("outofGame");
//			standUp(null);
			_multiUser.joinRoom(_multiUser.lobbyid, _lobby.selectedGameObj);
			}


		private function remoteCashUpdated(e:Event) :void
		{
		try{
			if (e.target.data.id != this.remoteCashCounter)
				{
				main.log.info("remoteCashUpdated: delayed response, ignoring ("+e.target.valueStr+")");
				return;
				}

			var amt:Number = Number(e.target.valueNum);
			if (isNaN(amt) || amt<0)
				{
				main.log.info("remoteCashUpdated error, server returned "+e.target.valueStr);
				return;
				}

			_me.totalExpired = false;

			// gelen para illa ki 5'in katları olsun...
			amt = Math.floor(amt/5)*5;
			totalDisplay.text = 'Çimdik: '+String(amt);
			_me['total'] = amt;
		}catch(e:Error){main.log.info("remoteCashUpdated exception: "+e);}
		}

		private function joinedGame(e:impEvent) :void
		{
try{
			_me.totalExpired = true;
			_lobby.visible = false;

			_table = new gTable(stage, this._backImage, this._adImage);
			_table.mainRef = this;
			addChild(_table);

main.log.info("joinedGame");

			_table.addEventListener('TABLE_READY', tableReady);
			_table.addEventListener('DISPLAY_ALERT', displayAlertHandler);

			_table.addEventListener('LOG_MESSAGE', sendLogMessage);
			_table.addEventListener('MESSAGE_UP', sendLogMsgTx);
			_table.addEventListener('BIDDING_COMPLETE', biddingComplete);
			_table.addEventListener('BIDDING_HANDLED', biddingHandled);
			_table.addEventListener('BUY_INTO_DONE', buyIntoDone);
			_table.addEventListener('SIT_OUT', doSitOut);
			_table.addEventListener('SIT_IN', doSitIn);
			_table.addEventListener('LOG_CONTENT', addLogContent);
			_table.addEventListener('LEAVE_GAME', outofGame);
			_table.addEventListener('SIT_ON_TABLE', sitDown);
			_table.addEventListener('STAND_UP', standUp);
			_table.addEventListener('MOD_KICK', kickUser);
			_table.addEventListener('MUTE_CHATBOX', muteChatBox);
			_table.addEventListener('LOG_OFF', logOff);
			_table.addEventListener('FULLSCREEN', goFullScreen);
			

//			_table.boot(_multiUser.gamesetup, _multiUser.joinedPlayers, _multiUser.playerObjs, {'turnStatus':_multiUser.turnStatus, 'muted':_multiUser.getRoomMute()});
			_table.boot(e.params.cfg, e.params.jp, e.params.po, {'turnStatus':e.params.ts, 'muted':e.params.muted});

			_table.updatePanel(_me);
			panelUpdate();
			_multiUser.sendMyProfile();

}catch(e:Error){main.log.info("joinedGame exception: "+e);}

_table.buildModListonTop();
_multiUser.askModList();
		}

		public function muteChatBox(e:impEvent) :void
		{
main.log.info('>>>>>> mutechatbox was '+_multiUser.getRoomMute());
			_multiUser.setRoomMute(!Boolean(_multiUser.getRoomMute()));
main.log.info('>>>>>> mutechatbox is '+_multiUser.getRoomMute());
		}

		public function buildModList(e:impEvent) :void
		{
		if (_table == null) return;
try{
			_table.buildModList(e.params.modlist);
main.log.info('');
}catch(e:Error){main.log.info("modRoom exception: "+e);}
		}

		public function sendLogMessage(e:impEvent) :void
			{
			_table.addLogContent("["+_me['uri'] + "] "+e.params.message);
			_multiUser.sendMessage('TABLE', 'left', e.params.message);
			}

		private function kickUser(e:impEvent) :void
		{
			main.log.info('kicking '+Number(e.params.sfid));

			var kicked:Number = Number(e.params.level);
			var kicker:Number = Number(_me['mod']);
			var owner:Boolean = (_me['mod'] > 0) ? false : _me['amiowner'];

/*
1- level 3 ve 4 modlar kendileri haric bütün kullanıcılaı , oda sahibini ve level 1 2 modları atabilir.
2- oda sahibi level 1234 modlar ve kendisi haric herkezi atabilir
3- level 1 mod kendini level 1234 modlarve oda sahibi harici herkezi atabilir
4- level 2 mod kendini level 1234 mod ve oda sahibi hariç herkezi atabilir.
*/
main.log.info('kicked:'+kicked+' kicker:'+kicker);

			/*if (kicked<3 &&

				(kicker>2 || (kicker>0 && kicker<3 && kicked==0) || (owner && kicked == 0))

			)
			*/
			if ((kicker > kicked) || owner == true) {
				if (kicker >= 3 || kicked < 1) {
					_multiUser.kickUser(Number(e.params.sfid));
				}else{
					if(!kickWinFlag){
						dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Yetkileriniz, kişiyi odadan atmak için yeterli değildir."}));
						kickWinFlag = true;
					}
				}
			} else {
				if(!kickWinFlag){
					dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Yetkileriniz, kişiyi odadan atmak için yeterli değildir."}));
					kickWinFlag = true;
				}
			}
		}
		private function tableReady(e:impEvent) :void
		{
			_table.removeEventListener('TABLE_READY', tableReady);
			tbrMuteStatus=-2;
			_multiUser.tableReady();
			if (_multiUser.autoSit)
				{
				_table.cimdikCek(true);
				}
			_multiUser.autoSit = false;
		}

		private function buyIntoDone(e:impEvent) :void
		{
			_me['total'] -= e.params.amount;
//			if (isNaN(_me['useableCash']) || _me['useableCash']<1) _me['useableCash'] = 0;
			_me['useableCash'] = e.params.amount;
			main._noSit = false;
//			_table._buyInto.setVals(_table._buyInto.minAmount, _table._buyInto.maxAmount);
			_multiUser.playMoney(e.params.amount);
			if (e.params.sit)
				{
				_table.dispatchEvent(new Event('SIT_ON_TABLE'));
				}
			else
				{
				_table.dispatchEvent(new Event("SIT_IN"));
				}
		}

		private function remoteCash():void
		{
		if (_me.totalExpired)
			{
			this.remoteCashCounter++;
			var _mrP:mRemote = new mRemote('total', {param: _me['userId'], key:_me['key']}, {id:this.remoteCashCounter});
			_mrP.addEventListener('RC_DATA_SAVED', remoteCashUpdated);
			_mrP.run();
			}
		}

		private function joinedLobby(e:Event) :void
		{
			_lobby.addEventListener('JOIN_BUTTON', intoGame);
main.log.info("joinedLobby");
			remoteCash();
//			getBuddies();
			updateBuddies();
			_multiUser.autoSit = false;
			_lobby.visible = true;
			_table.addEventListener('KILLSWITCH', killed, false, 0, true);
			_table.killSwitch();
		}

		private function killed(e:Event) :void
		{
main.log.info("killed");
			_table.removeEventListener('LEAVE_GAME', outofGame);
			removeChild(_table);
			_table = null;
		}
//==============================================================================
// Payment
//==============================================================================
		private function buyingDrink(e:Event) :void
		{
			var drink:Object = _table.drink;

			main.log.info('Gtable > main success');
			_multiUser.bartender(_table.drink);

			_multiUser.payYourDrink(drink.price);

//			_table.updateCash(_me['sfoxId'], _me['useableCash']);
			var mr:mRemote = new mRemote('decUserCash', {param: _me['userId'], param1:drink.price, param2:false, key:_me['key']});
			mr.run();
		}
//==============================================================================
//
//==============================================================================
		private function buddyClicked(e:impEvent) :void
		{
			if(Number(e.params.id) != Number(_multiUser.lobbyid)){

				if(e.params.pass != null && e.params.pass != ""){
					var tp:String = e.params.pass;

					var a:UIAlertPassword = new UIAlertPassword(this, 300, 90, e.params.id);
					a.addEventListener('CLOSE_ME', function closeAlert(e:impEvent):void
					{

						if(e.params.pass == tp){
							_multiUser.joinBuddyRoom( e.params.id, e.params.pass );
						}else{
							dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Üzgünüz, yanlış ya da eksik parola girdiniz."}));
						}

						e.target.parent.removeChild(e.target);
					});
				}else{
					_multiUser.joinBuddyRoom( e.params.id, '' );
				}

			}
		}

		private function sitTable(e:Event) :void
		{
			_table.loguser("sitTable");
			panelUpdate();
		}

		private function panelUpdate(notify:Boolean = true) :void
		{
			_multiUser.calcSeats(notify);
//			main.log.info("resulting seats: "+_me['seats']);
		}
//==============================================================================
// Game play
//==============================================================================
		private function addLogContent(e:impEvent) :void
		{
			_table.addLogContent(e.params.message);
		}

		private function playerCountUpdate(e:impEvent) :void
		{
			_table.loguser("playerCountUpdate: "+e.params.count);
			_table.playerCountUpdate(e.params.count);
		}

		private function joinOrdUpdate(e:impEvent) :void
		{
			_table.loguser("joinOrdUpdate: "+e.params.jo);
			_me.joinord = e.params.jo;
			if(_me['userId'] == e.params.roomOwner) {
				_me['amiowner'] = true;
				_table.ownerHere();
			} else {
				_me['amiowner'] = false;
			}
			panelUpdate(false);
			
		}

		private function cardsUpdate(e:impEvent) :void
		{
			_table.loguser("cardsUpdate");
			_table.dealCards(e.params.cards, true);
			cardsDealt = true;
		}
		private function gameStarted(e:impEvent) :void
		{
			_table.hideWinnerPopups();
			_table.loguser("gameStarted: "+tbrMuteStatus);
			if (tbrMuteStatus==-2)
				{
				tbrMuteStatus = _table._mute?1:0; // mute durumunu bekapla ve mute baslat
				_table._mute = true;
				_table.loguser("mute:"+_table._mute);
				}
			if (!cardsDealt) _table.dealCards([], false);
		}
		private function bidsAccepting(e:impEvent) :void
		{
			_table.loguser("bidsAccepting");
			_table.acceptBid(e.params);
		}
		private function biddingComplete(e:impEvent) :void
		{
			_table.loguser("biddingComplete: "+e.params.type);
			_multiUser.postHandResult(e.params);
			if (e.params.type == "fold" || e.params.type == "timeout" || e.params.type == "timeout-server")
				{
				_table._folded = true;
				if (e.params.type != "timeout-server")
					{
					_multiUser.gameFolded(e.params.type == "timeout");
					}
				else
					{
					_table.bidDoneTimeOut(null);
					}
				}
			else
				_multiUser.biddingRaised(e.params);
		}
		private function biddingHandled(e:Event) :void{
		}
		private function tableCardsUpdate(e:impEvent) :void
			{
			main.log.info("tableCardsUpdate: "+e.params.round+", "+e.params.cards.join(","));
try{
			dispatchEvent(new Event("SHOW_HEADS"));
			if (e.params.round == 2) //flop
				_table.tableCards(e.params.cards);
			else if (e.params.round>2) //turn and river
				_table.tableCardsTR(e.params.cards[0], e.params.round);
}catch(e:Error){main.log.info("tableCardsUpdate exception: "+e);}
			}

		private function updatedTableCash(e:impEvent):void
			{
			_table.updateTableCash(e.params.amount);
//			_table.loguser("tbrMuteStatus:"+tbrMuteStatus+" mute="+_table._mute);
			if (tbrMuteStatus>-1) //mute durumunu geri ayarla
				{
				_table._mute = tbrMuteStatus==1;
				tbrMuteStatus = -1;
				}
			}

		private function uCashUpdated(e:Event) :void {
			_table.loguser("uCashUpdated");
			_table.updatePanel( _me );
		}

		private function blindsPaid(e:impEvent):void
			{
			try{
			_table.blindsPaid(e.params.sfid, e.params.type, e.params.amount);
			}catch(e:Error){_table.loguser("blindsPaid exception: "+e);}
			}

		private function winnersWon(e:impEvent) :void
			{
			_table.winnersWon(e.params.list);
			}

		public function setPref(prop:String, val:Object):Boolean
		{
		try{
			if (settings!=null)
				{
				settings.data[prop] = val;
				settings.flush();
				}
			return(true);
			}
		catch(e:Error){main.log.info("error at setPref: "+e);}
		return(false);
		}

		public function getPref(prop:String, defaultVal:Object):Object
		{
		try{
			if (settings!=null && settings.data[prop]!=undefined)
				{
				return(settings.data[prop]);
				}
			}
		catch(e:Error){main.log.info("error at getPref: "+e);}
		return(defaultVal);
		}
		
		public function goFullScreen(e:impEvent):void {
			main.log.info('#goFull2');
			if (stage.displayState == 'normal') {
				stage.displayState = 'fullScreen';
				stage.scaleMode = StageScaleMode.SHOW_ALL;
				_table._cb._fsWarn.visible = true;
			} else {
				_table._cb._fsWarn.visible = false;
				stage.displayState = 'normal';
			}
		}
	}
}
