package com.obsesif.game
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import com.obsesif.game.PlayHand;

	import com.obsesif.ui.UIFactory;
	import com.obsesif.game.gStash;
	import com.obsesif.utils.SimpleLoader;
	import com.obsesif.events.impEvent;

	public class vUser extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="winC")]
		private var rawUserBox:Class;
      [Embed(source="/assets/UIElements.swf", symbol="nametag_white")]
		private var rawNameTagW:Class;
      [Embed(source="/assets/UIElements.swf", symbol="nametag_green")]
		private var rawNameTagG:Class;
      [Embed(source="/assets/UIElements.swf", symbol="led_white")]
		private var rawLedW:Class;
      [Embed(source="/assets/UIElements.swf", symbol="led_orange")]
		private var rawLedO:Class;

		[Embed(source="/assets/UIElements.swf", symbol="c2c")]
		public var card2c:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c2h")]
		public var card2h:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c2d")]
		public var card2d:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c2s")]
		public var card2s:Class;

		[Embed(source="/assets/UIElements.swf", symbol="c3c")]
		public var card3c:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c3h")]
		public var card3h:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c3d")]
		public var card3d:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c3s")]
		public var card3s:Class;

		[Embed(source="/assets/UIElements.swf", symbol="c4c")]
		public var card4c:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c4h")]
		public var card4h:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c4d")]
		public var card4d:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c4s")]
		public var card4s:Class;

		[Embed(source="/assets/UIElements.swf", symbol="c5c")]
		public var card5c:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c5h")]
		public var card5h:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c5d")]
		public var card5d:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c5s")]
		public var card5s:Class;

		[Embed(source="/assets/UIElements.swf", symbol="c6c")]
		public var card6c:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c6h")]
		public var card6h:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c6d")]
		public var card6d:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c6s")]
		public var card6s:Class;

		[Embed(source="/assets/UIElements.swf", symbol="c7c")]
		public var card7c:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c7h")]
		public var card7h:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c7d")]
		public var card7d:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c7s")]
		public var card7s:Class;

		[Embed(source="/assets/UIElements.swf", symbol="c8c")]
		public var card8c:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c8h")]
		public var card8h:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c8d")]
		public var card8d:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c8s")]
		public var card8s:Class;

		[Embed(source="/assets/UIElements.swf", symbol="c9c")]
		public var card9c:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c9h")]
		public var card9h:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c9d")]
		public var card9d:Class;
		[Embed(source="/assets/UIElements.swf", symbol="c9s")]
		public var card9s:Class;

		[Embed(source="/assets/UIElements.swf", symbol="cTc")]
		public var cardTc:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cTh")]
		public var cardTh:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cTd")]
		public var cardTd:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cTs")]
		public var cardTs:Class;

		[Embed(source="/assets/UIElements.swf", symbol="cJc")]
		public var cardJc:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cJh")]
		public var cardJh:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cJd")]
		public var cardJd:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cJs")]
		public var cardJs:Class;

		[Embed(source="/assets/UIElements.swf", symbol="cQc")]
		public var cardQc:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cQh")]
		public var cardQh:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cQd")]
		public var cardQd:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cQs")]
		public var cardQs:Class;

		[Embed(source="/assets/UIElements.swf", symbol="cKc")]
		public var cardKc:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cKh")]
		public var cardKh:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cKd")]
		public var cardKd:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cKs")]
		public var cardKs:Class;

		[Embed(source="/assets/UIElements.swf", symbol="cAc")]
		public var cardAc:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cAh")]
		public var cardAh:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cAd")]
		public var cardAd:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cAs")]
		public var cardAs:Class;

		[Embed(source="/assets/UIElements.swf", symbol="cback")]
		public var cardback:Class;

		private var preUrl:String = 'http://www.zukaa.com/picture.aspx?p=u/profilepictures/';

		public var _w:Sprite;
		private var _u:Sprite;
		private var _tagSet:Sprite;
		private var _bck:Sprite = null;

		private var username:String;
		private var _userid:String;
		private var _cash:String = "?";
		private var _no:Number;
		private var _tot:Number;
		private var _sfpid:Number;
		private var _format:TextFormat;
		private var _userName:TextField;
		private var _userCash:TextField;
		private var _container:Sprite;
		private var loader:Loader;
		private var stash:gStash;
		private var ldr:SimpleLoader;
		private var ldrUserId:String = null;
		private var _led_on:Sprite;
		private var _led_off:Sprite;
		private var _tagW:Sprite;
		private var _tagG:Sprite;
		private var _tagMask:Sprite;
		private var _sn:Number = 0;
		private var _finer:Number = 4;		// 1=per sec	2=per half sec		4=per quarter sec
		private var _clck:Timer;
		private var _timeLimit:Number = 0;
		private var _isMyTurn:Boolean;
		public var _autoMode:String = "stop";
		public var _sfoxid:Number;
		private var status:Object;
		private var handset:Sprite = null;
		private var _deck:Object = null;
		public var cards:Array = [];

		private var xp:Array;
		private var yp:Array;
		private var zap:Array;
		public var _uObj:Object;
		private static var _suObj:Object;

		// Coordinates with respect to parent: gTable

		//private var tablePos:Array = new Array({x: 345, y:240}, {x: 171, y:260}, {x: 100, y:240}, {x: 100, y:82}, {x: 175, y:63}, {x: 344, y:63}, {x: 513, y:63}, {x: 582, y:82}, {x: 582, y:240});
		private var tablePos:Array = new Array(345, 171, 100, 100, 175, 344, 513, 582, 582, 518);
		private var tablePosY:Array = new Array(240, 260, 240, 82, 63, 63, 63, 82, 240, 260);

		public function vUser(parent:DisplayObjectContainer=null, xOff:Number=0, yOff:Number=0, total:Number=9, no:Number=-1, timelimit:Number=30) :void
		{
			this.status = {};

			xp = new Array(269, 112, -30, -30, 128, 298, 468, 625, 625, 484);
			yp = new Array(296, 318, 220,  62, -20, -20, -20,  62, 220, /*318*/290);

			zap = [ [], [], [1,2,3,4,6,7,8,9], [1,2,3,5,7,8,9], [1,3,4,6,7,9], [1,3,5,7,9], [1,2,8,9], [2,5,8], [2,8], [5], [] ];

			this._no = no;
			this._tot = total;
			this._timeLimit = timelimit;

			var z:Array = (zap[total] as Array).sort(Array.NUMERIC).reverse();
			for each(var t:Number in z){
				this.xp.splice(t, 1);
				this.yp.splice(t, 1);
			}
			super( parent, Math.round(this.xp[this._no]+xOff), Math.round(this.yp[this._no]+yOff));
		}

		public function relocate(xOff:Number=0, yOff:Number=0, no:Number=-1) :void
		{
//yukarida da burda da splice var
			xp = new Array(269, 112, -30, -30, 128, 298, 468, 625, 625, 484);
			yp = new Array(296, 318, 220,  62, -20, -20, -20,  62, 220, 318);

			this._no = no;

			var z:Array = (zap[this._tot] as Array).sort(Array.NUMERIC).reverse();
			for each(var t:Number in z){
				this.xp.splice(t, 1);
				this.yp.splice(t, 1);
			}

			this.x = Math.round(this.xp[this._no]+xOff);
			this.y = Math.round(this.yp[this._no]+yOff);

			this.setScale();
			this.addBck();
			this.uInfo(this.uObj, true);
		}

		override protected function init():void
		{
			super.init();
			buttonMode = false;
			useHandCursor = false;
		}

		private function showUBox(e:Event):void {
			vUser._suObj = this._uObj;
			e.target.parent.parent.dispatchEvent(new Event('SHOW_USERBOX'));
		}

		override protected function addChildren() :void
		{
				_w = new rawUserBox();
				addChild(_w);

				_tagSet = new Sprite();
				addChild(_tagSet);

				_tagW = new rawNameTagW();
				_tagSet.addChild(_tagW);
				_tagW.x = 12;
				if(this._no>0) _tagW.x-=5;
				_tagG = new rawNameTagG();
				_tagSet.addChild(_tagG);
				_tagG.x = 12;
				if(this._no>0)_tagG.x-=5;
				_tagMask = new Sprite();
				_tagMask.x = _tagG.x-2;
				_tagMask.y = _tagG.y;
            _tagMask.graphics.beginFill(0xff0000);
            _tagMask.graphics.drawRect(0, 0, _tagG.width+4, _tagG.height);
            _tagMask.graphics.endFill();
				_tagMask.width = 1;
				_tagG.mask = _tagMask;
				_tagSet.addChild(_tagMask);

				_led_off = new rawLedW();
				_tagSet.addChild(_led_off);
				_led_off.x = 23;
				_led_off.y = 5;
				_led_on = new rawLedO();
				_tagSet.addChild(_led_on);
				_led_on.visible = false;
				_led_on.x = 23;
				_led_on.y = 5;

				this.setScale();

				uName('');
				uCash('');

				this.addBck();
				this.setStatus({empty:true});
		}

		private function setScale():void
		{
			if (this._no == 0)
				{
				_w.scaleX = 1.4;
				_w.scaleY = 1.4;
				_tagSet.scaleX = 1;
				_tagSet.scaleY = 1;
				_tagW.x = 12;
				_tagG.x = 12;
				}
			else
				{
				_w.scaleX = 1;
				_w.scaleY = 1;
				_tagSet.scaleX = 0.75;
				_tagSet.scaleY = 0.75;
				_tagW.x = 7;
				_tagG.x = 7;
				}
			_tagMask.x = _tagG.x - 2;
		}

		private function addBck():void
		{
			if (_bck!=null) removeChild(_bck);
			_bck = new Sprite();
			addChild(_bck);
			var s:Number = (this._no == 0) ? 1 : 1.4;
			_bck.graphics.beginFill(0xff0000);
			_bck.graphics.drawRect(0, 0, _w.width - (30 / s), _w.height - (40 / s));
			_bck.graphics.endFill();
			_bck.alpha = 0;
			_bck.addEventListener(MouseEvent.CLICK, showUBox);
		}

		public function led(m:Boolean) :void
		{
			_led_on.visible = m;
		}
		public function ledOff() :void
		{
			_led_on.visible = false;
		}
		public function tagOff() :void
		{
			_tagMask.width = 1;
		}

		public function startTimer(isMyTurn:Boolean = true) :void
		{
			main.log.info('startTimer');
			this.endTimer(false);
			this._isMyTurn = isMyTurn;
			this.tagOff();
			_sn = 0;
			_clck = new Timer(1000/this._finer, (this._timeLimit+1)*this._finer);
			_clck.addEventListener(TimerEvent.TIMER, timeBar);
			_clck.addEventListener(TimerEvent.TIMER_COMPLETE, timerFin);
			_clck.start();
		}

		public function endTimer(verbose:Boolean = true) :void
		{
			if (verbose) main.log.info('endTimer');
			this.tagOff();
			_sn = 0;
			if (_clck)
				{
				_clck.removeEventListener(TimerEvent.TIMER, timeBar);
				_clck.removeEventListener(TimerEvent.TIMER_COMPLETE, timerFin);
				if(_clck.running){
					_clck.reset();
					_clck.stop();
				}
				_clck = null;
				}
		}

		private function timeBar(e:TimerEvent) :void
		{
			_tagMask.width = Math.floor(((_tagG.width+4)/(this._timeLimit*this._finer))*_sn++);

//			if(_sn==1*this._finer && this._isMyTurn){			// cg:changed to shorten autotimer-time

			if(_sn==2 && this._isMyTurn){
				switch (this._autoMode)
				{
					case 'fold':
						main.log.info('>> fold');
						endTimer();
						main.log.info('Timer complete should fire PlayHand Event');
						dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'fold'}));
						main.log.info('-- Event Should have fired!');
						this._autoMode = 'stop';
					break;
					case 'call':
						main.log.info('>> call');
						endTimer();
						dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'call'}));
						this._autoMode = 'stop';
					break;
					case 'check':
						main.log.info('>> check');
						dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'check'}));
						this._autoMode = 'stop';
						break;
					case 'checkfold':
						main.log.info('>> checkfold');
						dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'checkfold'}));
						this._autoMode = 'stop';
						break;
				}
			}
		}

		private function timerFin(e:TimerEvent) :void
		{
			endTimer();
			if (_isMyTurn)
				{
 				dispatchEvent(new Event('TIMEOUT'));
				}
		}

		public function uCash(cash:String, force:Boolean = false) :void
		{

			var modX:Number = 1;

			var nc:Number = 0;
			try
				{
				nc = Number(cash);
				if (isNaN(nc)) nc = 0;
				}
			catch(e:Error)
				{
				nc = 0;
				}
			cash = String(nc);

			if (force==false && nc!=0 && cash == this._cash) return;

			if(_userCash != null) if(_userCash is TextField) removeChild(_userCash);

			_format = new TextFormat();
			_format.font = "AirSans";
			_format.color = 0xcbdd00;
			_format.size = 14;
			_format.align = TextFormatAlign.CENTER;

			_userCash = new TextField();
			_userCash.width = 120;
			_userCash.height = 15;
			_userCash.embedFonts = true;
			_userCash.selectable = false;
			_userCash.antiAliasType = AntiAliasType.ADVANCED;
			_userCash.defaultTextFormat = _format;
			_userCash.text = String(cash);

			var sx:Number = -25;
			var sy:Number;
			var split:Boolean = true;
			if(this._no == 0){
				_userCash.x = 18;
				_userCash.y = 105;
				sy = 40;
				split = false;
			}else{
				_userCash.x = 10;
				_userCash.y = 74;
				sy = 40;
				modX = quadrant(this._no);
				sx = (_w.width*.75/2) + ((_w.width*.75/2)) * modX + ((modX - (modX * modX)) / 2) * 53.5; // 2nd calculation 1 > 0, -1 > -1
			}
			addChild(_userCash);
			
			/*
			var oldstash:gStash = null;
			if (stash) oldstash = stash;
			stash = new gStash(this, Number(cash), sx, sy, split);
//			main.log.info('sw:' + stash.width);
			if (oldstash) removeChild(oldstash);
			*/
			this._cash = cash;
		}

		public function uName(name:String) :void
		{
			if (_userName != null && _userName is TextField)
				{
				if (this.username == name) return;
				removeChild(_userName);
				}

			_format = new TextFormat();
			_format.font = "AirSans";
			_format.color = 0x000000;
			_format.size = 14;
			_format.align = TextFormatAlign.CENTER;

			_userName = new TextField();
			_userName.width = 120;
			_userName.embedFonts = true;
			_userName.selectable = false;
			_userName.antiAliasType = AntiAliasType.ADVANCED;
			_userName.defaultTextFormat = _format;
			_userName.text = String(name);
			if(this._no == 0){
				_userName.x = 18;
				_userName.y = 2;
			}else{
				_userName.x = 10;
				_userName.y = 0;
			}
			addChild(_userName);
			this.username = name;
		}

		public function uInfo(uObj:Object, force:Boolean = false) :void
		{
			if (!uObj || uObj.userId==undefined) return;

			uName(uObj.uri);
			uCash(uObj.useableCash, force);
			this._sfoxid = uObj.sfoxId;

			if (force || this.ldrUserId != uObj.userId)
				{
				if(ldr!=null) if (ldr is SimpleLoader) removeChild(ldr);
				ldr = new SimpleLoader();
				ldr.x = 5;
				ldr.y = (this._no == 0) ? 35 : 25;
				var scl:String= (this._no == 0) ? "7" : "5";
				ldr.load(new URLRequest(this.preUrl+uObj.userId+'.jpg&b=0,'+scl));
				ldr.scale = true;
				addChild(ldr);

				this.ldrUserId = uObj.userId;
				}
		}

		public function set sfpid(n:Number) :void {this._sfpid = n;}
		public function get sfpid() :Number {return this._sfpid;}
		public function get no() :Number {return this._no;}
		public function get uObj() :Object {return this._uObj;}
		public function set uObj(o:Object) :void {this._uObj = o;}

		public function killSwitch() :void
		{
			rawUserBox = null;
			_w = null;
			username = null;
			_userid = null;
			xp = null;
			yp = null;
			zap = null;
			ldrUserId = null;
			_sfoxid = 0;

			gcHack();
			dispatchEvent(new Event('KILLSWITCH'));
		}

		private function isPositive(n:Number):Number {
			if(n < 0) return -1;
			return 1;
		}

		public function quadrant(idx:Number, isX:Boolean = true):Number{
			if(isX) {
				return (tablePos[idx] < 300) ? -1 : 1;
			} else {
				return (tablePosY[idx] > 200) ? -1 : 1;
			}
		}

		public function set deck(dck:Object):void
		{
		this._deck = dck;
		this.setStatus(this.status);
		}

		public function get deck():Object { return this._deck; }

		public function setStatus(sts:Object, copy:Boolean=false):void
		{
		try{
		if (copy)
			{
			this.status = sts;
			}
		else
			{
			var props:Array = ['folded', 'ghost', 'empty', 'dealt'];
			for(var px:String in props)
				{
				var prp:String = props[px];
				if (sts[prp] is Boolean) this.status[prp] = sts[prp];
				}
			}

//debug
/*
		var tmp:Array = [];
		for(var tx:String in this.status)
			{
			tmp.push(tx+"="+this.status[tx]);
			}
		main.log.trace("["+this.userid+"] vUser["+this._no+"] = "+tmp.join(" / "));
*/

		if (this.status.empty == false)
			{
			this.alpha = 1;

			if (this._no>0)
				{
				this.buttonMode = true;
				this.useHandCursor = true;
				}
			}
		else
			{
			this.alpha = 0;

			this.buttonMode = false;
			this.useHandCursor = false;

			this.status.ghost = false;
			this.status.folded = true;
			}
		if (this.status.ghost == true)
			{
			this.alpha = 0.7;
			this.status.folded = true;
			}

		if (this.handset!=null)
			{
			try{
				removeChild(this.handset);
			}catch(e:Error){}
			this.handset = null;
			}
//main.log.info("["+this.userid+"] dbg 6: clen = "+this.cards.length+" (dealt:"+this.status.dealt+")");
		if (this.status.dealt == false)
			{
			this.cards = [];
			}

		if (this.status.folded == false)
			{
/*
			if (this.status.dealt==true && this.deck==null)
				{
				main.log.info("["+this.userid+"] this.deck is null! ("+this._no+")");
				}
*/
			if (this.status.dealt==true)
				{
				this.handset = new Sprite();
				if (this._no == 0 && this.cards.length==2)
					{
					showCard(this.cards[0], 80, 28, .9);
					showCard(this.cards[1], 110, 28, .9);
					}
				else if (this._no > 0)
					{
					showCard('back', 60, 21, .64);
					showCard('back', 75, 21, .64);
					}
				addChild(this.handset);
				}
			}
		}catch(e:Error){main.log.info("["+this.userid+"] vUser["+this._no+"].setStatus exception: "+e);}
		}
		private function showCard(c:String, px:Number, py:Number, s:Number) :void
		{
			var con:Sprite = new Sprite();
			con.x = px;
			con.y = py;
			con.scaleX = s;
			con.scaleY = s;
			this.handset.addChild(con);

			var sc:Class = this['card'+c] as Class;
			var symbol:Sprite = new sc() as Sprite;
			con.addChild(symbol);
		}

		public function get userid():String	{ return this.ldrUserId; }
	}
}
