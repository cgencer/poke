package com.obsesif.game
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	import com.obsesif.utils.LoggingFactory;
	import com.obsesif.utils.SimpleLoader;

	import com.obsesif.ui.LobbyPanel;
	import com.obsesif.ui.UIChatBox;
	import com.obsesif.ui.UIBuddiesBox;
	import com.obsesif.ui.UITopList;
	import com.obsesif.events.impEvent;

	public class gLobby extends gBase
	{
		public static const log :Logger = LogContext.getLogger(gLobby);

		private var preUrl:String = 'http://www.zukaa.com/';
		public var gameSelected:Boolean = false;

		private var rooms:Array;
		private var lobbyPanels:Array;
		private var inGame:Sprite;
		private var inRoom:Sprite;
		private var _selectedGame:String;
		private var _selectedGameObj:Object;
		private var _lobby:LobbyPanel;
		private var _topList:UITopList;
		private var UCounter:Sprite;
		private var _userCount:Number;
		private var _nrProp:Object;
		private var _topListRetrieved:Boolean = false;
		private var _ulevel:Number = 0;
		private var _ad:String = "";
		private var _adurl:String = "";

		public function gLobby(stage:Stage, ad:String = "assets/full-banner.gif", adurl:String = "") :void
		{
			this._ad = ad;
			this._adurl = adurl;
			super('LOBBY');
		}

		public function cleanRooms() :void
		{
			_lobby.cleanRooms();
		}

		public function build(rooms:Object, ulevel:Number=0) :void
		{
			this._ulevel = ulevel;
			if(_lobby != null) removeChild(_lobby);
			_lobby = new LobbyPanel(rooms, this, 15, 110, ulevel);
			addChild(_lobby);

			var _con:Sprite = new Sprite();
			addChild(_con);
			_con.x = 475;
			_con.y = 25;
			var _ldr:SimpleLoader = new SimpleLoader();
			_ldr.load(new URLRequest(this.preUrl+this._ad));
			_ldr.scale = false;
			_con.addChild(_ldr);

			_lobby.addEventListener('GAME_SELECTED', gameSelect);
			_lobby.addEventListener('JOIN_BUTTON', joinButton);
			_lobby.addEventListener('CREATE_ROOM', createRoom);

			if(!_topListRetrieved){
				_topList = new UITopList(this, 720, 135);
				addChild(_topList);
				_topListRetrieved = true;
			}
		}

		private function createRoom(e:impEvent):void
		{
			this._nrProp = _lobby.nrProp;
			e.target.parent.dispatchEvent(new impEvent('CREATE_ROOM', {roomAttr: _nrProp}));
		}

		public function tops(t:Array):void
		{
			_topList.buildEntries(t);
		}

		private function toggleUBox(e:Event) :void
		{
			main.log.info('hell yeah!');
		}

		public function joinButton(e:Event) :void
		{
			removeEventListener('JOIN_BUTTON', joinButton);
			e.target.parent.dispatchEvent(new Event('JOIN_BUTTON'));
		}

		public function gameSelect(e:Event) :void
		{
			this._selectedGame = e.target.selectedGame;
			this._selectedGameObj = e.target.selectedGameObj;
			e.target.parent.dispatchEvent(new Event('ROOM_SELECTED'));
		}

		public function closeNewRoomWindow() :void
		{
			_lobby.closeNewRoomWindow();
		}

		public function get selectedGameObj() :Object{ return(this._selectedGameObj); }
		public function get selectedGame() :String{ return(this._selectedGame); }
		public function set userCount(n:Number) :void { this._userCount = n; }
		public function get nrProp() :Object{ return(this._nrProp); }

	}
}
