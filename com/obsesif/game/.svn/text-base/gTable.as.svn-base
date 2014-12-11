package com.obsesif.game
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageScaleMode
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import flash.events.TimerEvent;
    import flash.utils.Timer;

	import flash.events.*;
	import flash.utils.*;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;
	import net.stevensacks.utils.Web;

	import com.obsesif.utils.SimpleLoader;
	import com.obsesif.ui.UIButton;
	import com.bit101.components.Slider;
	import com.obsesif.game.gGlass;
	import com.obsesif.game.gStash;
	import com.obsesif.ui.UISlider;
	import com.obsesif.ui.UIGSlider;
	import com.obsesif.ui.UIAlertBuyInto;
	import com.obsesif.ui.UIAlert;
	import com.obsesif.ui.UIAlertWinner;
	import com.obsesif.game.PlayHand;
	import com.reintroducing.sound.SoundManager;
	import com.obsesif.events.impEvent;
	import com.bit101.components.CheckBox;

	public class gTable extends gBase
	{
      [Embed(source="/assets/UIElements.swf", symbol="winB")]
      private var rawWin:Class;
      [Embed(source="/assets/UIElements.swf", symbol="table")]
      private var rawTable:Class;
      [Embed(source="/assets/UIElements.swf", symbol="razor")]
      private var rawRazor:Class;
      [Embed(source="/assets/UIElements.swf", symbol="dealerled")]
      private var rawDealerLed:Class;
      [Embed(source="/assets/UIElements.swf", symbol="yamru")]
      private var rawYamru:Class;
      [Embed(source="/assets/UIElements.swf", symbol="xoff")]
      private var rawXOff:Class;
	  [Embed(source="/assets/UIElements.swf", symbol="fsButton")]
      private var fsButton:Class;
	  [Embed(source="/assets/UIElements.swf", symbol="buttonTcash")]
      private var buttonTcash:Class;
	  

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

		private var _ldr:SimpleLoader;
		private var preUrl:String = 'http://www.zukaa.com/';
		private var buttonSit:UIButton;
		private var buttonLogoff:UIButton;
		private var buttonLobby:UIButton;
		private var buttonStand:UIButton;
		private var buttonFull:UIButton;
		private var _vw:UIAlertWinner;
		private var _vbs:Array = [];
		private var _vws:Array = [];
		private var glasses:Array = [];
		private var glassHolder:Array = [];
		private var _tbl:Sprite;
		private var _bS:Slider;
		public var _bp:Sprite;
		private var _cardsUp:Sprite;
		public var _rz:UIGSlider;
		private var _nUBox:gSendDrink;
		private var _alert:Sprite;
		private var _wholeCards:Sprite = null;
		private var _bC:UIButton;
		private var _bF:UIButton;
		private var _bR:UIButton;
		private var _tc:TextField = null;
		private var format:TextFormat;
		private var ldrA:Loader;
		private var ldrB:Loader;
		private var sndMaker:SoundManager;
		private var stash:gStash;
		private var _dLed:Sprite;
		public var _mute:Boolean = false;

		private var _tableIndex:Number;
		private var roomId:Number;
		private var roomMax:Number;
		private var roomName:String;
		private var sitIndex:Number;
		private var gameType:String;
		private var myid:Number;
		private var myname:String;
		private var myindex:Number;
		private var _playerIndex:Number;
		private var seats:Object;
		private var sitOrder:Array;
		private const tcpre:String = "Masada: ";
		private var userInfos:Array;
		private var className:String;
		private var deck:Object = null;
		private var _nrFlag:Boolean = false;
		private var _drinkName:String;
		private var _drinkPrice:Number;
		private var _drinkReceiverAsVBS:Number;
		private var _drinkReceiverAsUO:Object;
		private var _bidMakerasVBS:Number;
		private var _drinkNo:Number;
		private var playerCount:Number;
		private var bar:Object;
		private var _cotx:Number;
		private var _coty:Number;
		private var xp:Array;
		private var yp:Array;
		private var _drink:Object;
		private var _timeLimit:Number;
		private var roomOwner:Number;
		public var _folded:Boolean = false;
		private var unfos:Array = [];
		private var blind:Number;
		private var sitting:Boolean = false;
		private var inGame:Boolean = false;
//		public var _buyInto:UIAlertBuyInto;
		public var myTurn:Boolean = false;
		public var bidParams:Object = null; //params received from doB and put together by mRoom
		public var betAmount:Number = 0;
		private var _back:String = "";
		private var _ad:String = "";
		private var ranks:Array;
		private var stashPos:Object = {x: 540, y: 235};
		private var tableCash:Number = 0;
		private var _minBuyIn:Number = 0;
		private var _maxBuyIn:Number = 0;
		public var mainRef:main = null;
		private var turnStatus:Number = 0;
		private var _kickWho:Number;
		private var _muted:Boolean = false;
		private var ready:Boolean = false;
		private var lastDealer:Number = -1;
		private var _fs:Sprite;
		private var _fsG:Sprite;
		private var _fsB:Sprite;
		private var _tcb:Sprite;
		private var _tcbG:Sprite;
		private var _tcbt:TextField;
		public var _cTimer:Timer;

		public function gTable(stage:Stage, back:String="", ad:String="") :void
		{
			this._back = back;	// "assets/nbacks.jpg";
			this._ad = ad;
			this._cTimer = new Timer(450, 3);

			super('TABLE');

			this.ranks = ['tek kart', 'per', 'döper', 'üçlü', 'straight', 'flush', 'full house', 'kare', 'straight floş', 'royal flush'];

			_vbs = new Array();
			_tableIndex = -1;
			this.tableCash = 0;

			sitIndex = 0;
			playerIndex = 1;
			seats = {};
			sitOrder = [[], [], [0,1], [0,1,2], [0,1,2,3], [0,1,2,3,4],
							[0,1,2,3,4,5], [0,1,2,3,4,5,6], [0,1,2,3,4,5,6,7],
							[0,1,2,3,4,5,6,7,8], [0,1,2,3,4,5,6,7,8,9]
							];

			xp = new Array(345, 171, 100, 100, 175, 344, 513, 582, 582, 518);
			yp = new Array(240, 260, 240,  82,  63,  63,  63,  82, 240, 260);

			sndMaker = SoundManager.getInstance();
			try  {
			main.log.info('## Start adding sounds');
			sndMaker.addExternalSound('../assets/sounds/card_shuffle01.mp3', 'shuffle');
			sndMaker.addExternalSound('../assets/sounds/card_deal01.mp3', 'deal');
			sndMaker.addExternalSound('../assets/sounds/coin_jingle07.mp3', 'coindrink');
			sndMaker.addExternalSound('../assets/sounds/coin_jingle15.mp3', 'coin');
			sndMaker.addExternalSound('../assets/sounds/coin_table_slide_01.mp3', 'tablecard');
			sndMaker.addExternalSound('../assets/sounds/beep.mp3', 'beep');
			sndMaker.addExternalSound('../assets/sounds/applause.mp3', 'applause');

			} catch(e:Error) {main.log.info('Sound Check 1: ' + e);}

			if(this._back != ""){
				_ldr = new SimpleLoader();
				_ldr.load(new URLRequest(this.preUrl+this._back));
				main.log.info('loading '+this.preUrl+this._back);
				_ldr.scale = false;
				addChildAt(_ldr, 1);
			}

		// create table
			_tbl = new rawTable();
			_tbl.x = (960-_tbl.width)/2 + 50;
			_tbl.y = 30;
			addChildAt(_tbl, 2);

			var _y:Sprite = new rawYamru();
			addChildAt(_y, 3);
			_y.x = 25;
			_y.y = 428;

			// Create table amount label
			var frm:TextFormat = new TextFormat();
			frm.font = "AirSansBold";
			frm.color = 0xffffff;
			frm.size = 18;

			_tc = new TextField();
			_tc.width = 250;
			_tc.embedFonts = true;
			_tc.autoSize = 'left';
			_tc.selectable = false;
			_tc.antiAliasType = AntiAliasType.ADVANCED;
			_tc.defaultTextFormat = frm;
			_tc.x = 410- _tbl.x - 40;
			_tc.y = 300- _tbl.y - 50;
			_tbl.addChild(_tc);
			_tc.text = this.tcpre + "0";

		}

		public function boot(tableData:Array, roomPlayers:Array, roomPlayerDatas:Array, others:Object) :void
		{
			try{

			this.roomMax		= tableData['players']+1;
			this.roomId			= tableData['id'];
			this.roomName		= tableData['name'];
			this.myid			= tableData['playerId'];
			this.myname			= tableData['playerName'];
			this.playerCount	= tableData['count'];
			this._timeLimit		= tableData['timelimit'];
			this.roomOwner		= tableData['ownerId'];
			this.gameType		= tableData['gameType'];
			this._minBuyIn		= tableData['buyIn'];
			this._maxBuyIn		= tableData['buyInT'];


			try{
				this.blind = Number(tableData['blindBig']);
				if (isNaN(this.blind)) throw Error("invalid blind");
				main.log.info("blind is "+this.blind);
			}catch(e:Error){
				this.blind=10;
				main.log.info("blind is invalid, setting to "+this.blind);
				}

		//  place ghosts
			for(var i:Number=0; i<this.roomMax; i++)
			{
				var _vb:vUser = new vUser(this, _tbl.x, _tbl.y, this.roomMax, i, this._timeLimit);
				_vb.addEventListener('TIMEOUT', bidDoneTimeOut);
				_vb.addEventListener(MouseEvent.CLICK, vbclick);

				_vbs[i] = _vb;
			}

			_cardsUp = new Sprite();
			addChild(_cardsUp);

			for(i=0; i<this.roomMax; i++)
			{
				_vw = new UIAlertWinner(this, _tbl.x, _tbl.y, this.roomMax, i);
				_vw.basey = _vw.y;
				_vw.hide();
				_vws[i] = _vw;
			}

			// join-table button
			this.buttonSit = new UIButton(this,  0, 0, "masaya otur", 'button', sitHere, 1.3, 1.1);
			this.buttonSit.x = 385;
			this.buttonSit.y = 220;
			if(main._noSit)
			{
				this.buttonSit.hide();
			}
			if (others.turnStatus==1)
				{
//				this.buttonSit.hide();
				_vbs[0].setStatus({empty:true, folded:true});
				}

			this._muted = (Number(others.muted) == 1) ? true : false;

			this.buttonLogoff = new UIButton(this,  880, -3, "çıkış", 'button', logOff, .6, .8);
			this.buttonLobby = new UIButton(this,  800, -3, "lobi", 'button', standUp, .6, .8);
			this.buttonStand = new UIButton(this,  720, -3, "izle", 'button', standWatch, .6, .8);
			this.buttonStand.hide();
			
			//---Full Screen Button---
			
			_fs = new Sprite();
			_fs.x = 900;
			_fs.y = 410;
			_fsG = new fsButton();
			_fs.addChild(_fsG);
			_fsB = new Sprite();
			_fs.addChild(_fsB);
			_fsB.buttonMode = true;
			_fsB.useHandCursor = true;
			_fsB.graphics.beginFill(0xff0000);
			_fsB.graphics.drawRect(0, 0, 40, 28);
			_fsB.graphics.endFill();
			_fsB.alpha = 0;
			_fsB.addEventListener(MouseEvent.CLICK, goFull);
			addChild(_fs);
			
			// Total Cash
			
			_tcb = new Sprite();
			_tcb.x = 410;
			_tcb.y = 572;
			_tcb.scaleX = 1.8;
			_tcb.scaleY = 1.8;
			_tcbG = new buttonTcash();
			_tcb.addChild(_tcbG);
			
			
			var frmc:TextFormat = new TextFormat();
			frmc.font = "AirSansBold";
			frmc.color = 0x000000;
			frmc.size = 8;
			frmc.align = 'center';

			_tcbt = new TextField();
			_tcbt.width = 80;
			_tcbt.embedFonts = true;
			//_tcbt.autoSize = 'center';
			_tcbt.selectable = false;
			_tcbt.antiAliasType = AntiAliasType.ADVANCED;
			_tcbt.defaultTextFormat = frmc;
			_tcbt.x = 0;
			_tcbt.y = 0;
			_tcb.addChild(_tcbt);
			_tcbt.text = 'Kasa: ' + main._me['total'];
			addChild(_tcb);
			
			// Total CSash End

			_bp = new Sprite();
			addChild(_bp);
			_rz = new UIGSlider(_bp, 305, 475);
			_rz.addEventListener('AUTO_TOGGLE', autoPlay);
			_rz.addEventListener('SOUND_ON', soundOn);
			_rz.addEventListener('SOUND_OFF', soundOff);
			_rz.addEventListener(PlayHand.COMPLETE, playHand);
			_vbs[0].addEventListener(PlayHand.COMPLETE, playHand);

			this._mute = mainRef.getPref("sounds", 1)!=1;
			loguser("mute is "+this._mute);
			_rz.setSound(!this._mute, false);

			var maxV:Number = 100;
			if(tableData['gameType'] == 'No') maxV = main._me['useableCash'];
			if(tableData['gameType'] == 'Pot') maxV = this.tableCash;
			if(tableData['gameType'] == 'Limit') maxV = this.tableCash;

			try
				{
				maxV = Number(maxV);
				if (isNaN(maxV)) throw Error("invalid maxV");
				}
			catch(e:Error)
				{
				maxV = 100;
				}

			var minV:Number = this.blind;
			if (minV > maxV)
				{
				var tmp:Number = minV;
				minV = maxV;
				maxV = tmp;
				}
			_rz.setSliderParams(minV, maxV, this.blind);

			_nUBox = new gSendDrink(this, 40, 120);
			_nUBox.visible = false;
			_nUBox.addEventListener('SENDING_DRINK', waiter);
			_nUBox.addEventListener('CLOSE_UINFO', showUBox);

main.log.info('min' + this._minBuyIn +' max' + this._maxBuyIn + ' tot'+ main._me['total']);

//			if(main._me['total'] < this._maxBuyIn) this._maxBuyIn = main._me['total'];
/*
			_buyInto = new UIAlertBuyInto(this, 270, 90, this._minBuyIn, this._maxBuyIn);		//FIXME: total'i guncelleyince bunu da update et
			_buyInto.addEventListener('BUY_INTO', buyInto);
			_buyInto.addEventListener('NO_BUY_INTO', noBuyInto);
*/
			_dLed = new rawDealerLed();
			_dLed.visible = false;
			addChild(_dLed);

			playerCountUpdate(this.playerCount);

//			logWriter('masa açıldı, şeytanınız bol olsun...', true);
			turnChange(false);
			if (this.deck!=null)
				{
//				for(i=0; i<this.roomMax; i++) _vbs[i].deck = this.deck;
				this.ready = true;
				dispatchEvent(new impEvent('TABLE_READY'));
				}
			}catch(e:Error){
				main.log.info("table.boot exception: "+e);
				}

			_wholeCards = new Sprite();
			_cardsUp.addChild(_wholeCards);
			this.ready = true;
			dispatchEvent(new impEvent('TABLE_READY'));
		}

		public function changeDealer(sfid:Number): void
		{
try{
			this.lastDealer = sfid;

			var idx:Number = grabSI( {need:'idx', have:'sfid', cmp:Number(sfid)});
			if (sfid==0 || idx<0)
				{
				loguser("changeDealer idx is -1! sfid = "+sfid);
				_dLed.visible = false;
				return;
				}
			idx += getSeatOffset();

			var modX:Number = (idx > 0) ? _vbs[0].quadrant(idx) : -1;
			var modY:Number = (idx > 0) ? _vbs[0].quadrant(idx, false) : -1;
			_dLed.x = _vbs[idx].x - (15 * ((idx == 0) ? 1 : .75)) + ((modX * modX - modX)/ 2) * (175 * ((idx == 0) ? 1 : .75)); // f(1) = 0, f(-1) = 1, f(modX) = ((modX * modX - modX) / 2);
			//main.log.info('UD Dealer quad for pos ' + idx + ' : '+ modX + ' f(modX) = ' + Number(((modX - (modX * modX)) / 2) * 53));
			_dLed.y = _vbs[idx].y - 14 * ((idx == 0) ? 1 : .75) +  ((modY + modY * modY)/ 2) * (120 * ((idx == 0) ? 1 : .75)); // f(-1) = 0, f(1) = 1, f(modY) = ((modY + modY * modY)/ 2)
			_dLed.visible = true;
}catch(e:Error){loguser("changeDealer exception: "+e);}
		}

		public function playerCountUpdate(count:Number):void
		{
		try{
		this.playerCount = count;
		if (turnStatus==0 && count<2) /* MINPLAYERS ------ */
			{
			loguser("count < minplayers, folding hand");
			cleanTable(true);
			_dLed.visible = false;
			hideWinnerPopups();
			}

		if (this.buttonSit!=null)
			{
			if (this.playerCount<this.roomMax-1)
				{
				if (!this.sitting)
					{
					if (main._noSit==false) this.buttonSit.show();
					}
				}
			else
				{
				this.buttonSit.hide();
				}
			}
		}catch(e:Error){loguser("playerCountUpdate exception: "+e);}
		}

		public function setupSittingUser() :void
		{
			this.sitting = true;
			updateCash(main._me['sfoxId'], main._me['useableCash']);
			updatePanel(main._me);

			_vbs[0].setStatus({empty:false, folded:true, dealt:false});
			this.buttonSit.hide();
			this.buttonStand.show();
		}

		public function lightItUp(sp:String, sg:String, sf:String) :void //arka arkaya anlamsizca elli milyon kere cagrilan fonksiyonumuz
		{
			var diff:Number = getSeatOffset();
//			loguser("lightItUp: "+sp+" sitting:"+this.sitting+" diff:"+diff+" sg:"+sg+" sf:"+sf);
			var spa:Array = sp.split(',');
			var sits:Array = this.sitOrder[this.roomMax].slice();
			var sits2:Array = sits.slice();

			sg = ","+sg+","; //indexof yapicaz buna asagida
			sf = ","+sf+","; //denden
			if (sp!='')
				{
				for(var i:Number=0; i<spa.length; i++)
					{
					var j:Number = Number(spa[i])+diff;
//					loguser("lighting for #"+j+", "+sits[j]);

					var ob:Object={empty:false, ghost:false};
					if (sg.indexOf(","+spa[i]+",")>-1)
						{
						ob.ghost = true;
						this._vws[ sits[j] ].hide();
						}
					else
						{
						if (sf.indexOf(","+spa[i]+",")>-1)
							{
							ob.folded=true;
							}
						else
							{
							ob.folded=false;
							}
						}
					if (turnStatus>0 && ob.ghost==false) ob.dealt = true;
					this._vbs[ sits[j] ].setStatus(ob);
					sits2[j] = -1;
					}
				}
			for(var x:String in sits2)
				{
				if (sits2[x]==-1) continue;
				try{
//				loguser("lighting DOWN for "+sits2[x]);
					this._vbs[ sits2[x] ].setStatus({empty:true});
					this._vws[ sits2[x] ].hide();
				}catch(e:Error){}
				}

		}

		public function getSeatOffset():Number
		{
		return(this.sitting?0:1);
		}

		public function showHeads(myseats:String, uObjs:Array) :void
		{
			if(myseats == "" || myseats == null)
				{
//loguser("showheads:FAIL");
				return;
				}

//			loguser("showheads: "+myseats);
try{
			var sits:Array = this.sitOrder[this.roomMax].slice();
			var seatArray:Array = myseats.split(';');
			var diff:Number = getSeatOffset();

/*
todo/fixme:
1. asagidaki loop'u buraya da al, alpha'si 0'dan buyuk vuser'lari scan et, matchlemeye calis
2. eger "yaratacagimiz adam" zaten baska bir vuser'da aktif (alpha>0) olarak varsa o vUser'in yerini yaratacagi adamin yeni yeri ile degistir, x/y'yi update et. bu 2 yer degistirmis vUser'dan alpha'si >0 olani/olanlari "yapildi" seklinde mark et
3. asagidaki loop da yalnica "yapildi olmayan" vuser'lari (yeni masaya oturmus adamlari) yaratir olsun. -k
update: 3. adim (seatArray2) gecerli degil, cunku bu sefer isimlerde yazdigimiz "artirdi" "bop" mesajlari resetlenmiyor. -k
*/
//			var seatArray2:Array = [];
			var sIx:Number, relos:Number = 0;
			var seat:String, sInfo:Array, sid:Number, uid:Number, idx:Number;

			for (sIx=0; sIx<seatArray.length; sIx++)
				{
				seat = seatArray[sIx];
				sInfo = seat.split(':');
				sid = sInfo[0];
				uid = sInfo[1];
				idx = sInfo[2];

				if (sid == main._me.sfoxId) continue; //vb0 icin relocate deneme (test, yeterli mi bu bilmiyoruz)
//loguser("looking for "+uid);
				var newpos:Number = sits[idx+diff];

				var fnd:Boolean = false;
				for(var i:Number=1; i<roomMax; i++) //kontrole 1'den basla, 0 her zaman yeniden yaratilsin //update:seatArray2'yi kapadiktan sonra gerekliligi kalmadi ama ellemiyorum. -k
					{
					if (this._vbs[i].alpha>0 && this._vbs[i].userid == String(uid))
						{
//loguser("matched "+_vbs[i].userid);
						if (i!=newpos)
							{
							//main.log.info("relocating "+uid+" ("+i+" vs. "+newpos+")");
traceuser("relocating "+uid+" ("+i+" vs. "+newpos+")");
							var tmp:vUser = this._vbs[i];
							this._vbs[i] = this._vbs[newpos];
							this._vbs[newpos] = tmp;

							this._vbs[i].relocate(_tbl.x, _tbl.y, i);
							this._vbs[newpos].relocate(_tbl.x, _tbl.y, newpos);
							relos++;
							}
						fnd = true;
						break;
						}
					}
/*
				if (!fnd)
					{
					seatArray2.push(seat);
					}
*/
				}

//loguser("new seats are "+seatArray2.join(";"));

			for (sIx=0; sIx<seatArray.length; sIx++)
				{
				seat = seatArray[sIx];
//loguser("showheads2:"+seat);
				sInfo = seat.split(':');
				sid = sInfo[0];
				uid = sInfo[1];
				idx = sInfo[2];
//loguser("showheads for uid #"+uid+" is "+uObjs[ Number(uid) ].uri);

				this._vbs[sits[idx+diff]].uObj = uObjs[ Number(uid) ];
				this._vbs[sits[idx+diff]].uInfo( uObjs[ Number(uid) ] );
				}

			if (relos>0)
				{
				this.changeDealer(this.lastDealer);
				}
}catch(e:Error){loguser("showheads exception:"+e.message);}
		}

		public function someoneLeft(sfid:Number) :void
		{
			try{
			var idx:Number = grabSI( {need:'idx', have:'sfid', cmp:Number(sfid)} );
			var diff:Number = getSeatOffset();
			idx += diff;
//loguser("idx is "+idx+" (diff="+diff+")");
			if (idx>=0) this._vbs[ idx ].setStatus({empty:true});
		}catch(e:Error){loguser("someoneLeft exception for "+sfid+": "+e);}
		}

		public function updatePanel(uo:Object) :void
		{
			this._vbs[0].uInfo( uo );
		}

		public function updateCash(uid:int, cash:String) :void
		{
			if (uid==this.myid) _vbs[0].uCash(cash);
//			(this._vbs[this.sitOrder[this.roomMax][pid]] as vUser).uCash(cash);
		}

		private function soundOn(e:Event) :void
		{
			mainRef.setPref("sounds", 1);
			this._mute = false;
		}
		private function soundOff(e:Event) :void
		{
			mainRef.setPref("sounds", 0);
			this._mute = true;
		}

		public function setupStandingPlayer() :void
		{
			this.sitting = false;
			if (tableCash==0)
				this._tc.text = "";
			_vbs[0].setStatus({empty:true});
			playerCountUpdate(this.playerCount);
			this.buttonStand.hide();
			if (main._me['useableCash']>0)
				{
				main._me['total'] += main._me['useableCash'];
				main._me['useableCash'] = 0;
				}
		}
		public function passOver(uObj:Object) :void
		{
			var sits:Array = this.sitOrder[this.roomMax].slice();
			this._vbs[ sits[ uObj.index-1 ] ].updateUserInfo( uObj );
		}

		public function sitHere(e:Event) :void {
			loguser('Join Table Button Clicked');
			this.buttonSit.hide();
			cimdikCek(true);
		}

		public function logOff(e:Event) :void {
			dispatchEvent(new Event('LOG_OFF'));
		}
		public function standUp(e:Event) :void {
			main._noSit = true;
			dispatchEvent(new Event('LEAVE_GAME'));
		}
		public function goFull(e:Event):void {
			main.log.info('#goFull');
			dispatchEvent(new impEvent('FULLSCREEN'));
		}
		public function standWatch(e:Event) :void { dispatchEvent(new Event('STAND_UP')); }
		public function set playerIndex(n:Number) :void	{ this.myindex = n; }

		public function getPlayerIndex(uid:Number) :Number
		{
			return this.seats.indexOf(uid);
		}

		public function killSwitch() :void
		{
			try{
				for(var i:Number=0; i<roomMax; i++){
					_vbs[i].killSwitch();
				}
			}catch(e:Error){};
			try{
				rawTable = null;
				this.buttonLobby = null;
				this.buttonSit = null;
				this.buttonStand = null;
				_vbs = null;
				sitOrder = null;
				seats = null;
			}catch(e:Error){};
			try{
				gcHack();
			}catch(e:Error){};
			dispatchEvent(new Event('KILLSWITCH'));
		}

		private function vbclick(e:Event) :void
		{
main.log.info('clcked on vUser at least');
			var vb:vUser = e.target.parent as vUser;
			var uObj:Object = vb.uObj;
			_nUBox.updateContent( uObj );
			if( uObj['userId'] != main._me['userId'] )
			{
//				main.log.info('clcked at least');
//				main.log.info('clcked on '+vb.no);			// its the index!
//				main.log.info('clcked on '+uObj['uri']);
//				main.log.info('clcked on '+main._me['userId']+' / '+uObj['userId']);

				if(uObj['uri']!=null && vb.alpha>0){
					Web.getURL("http://www.zukaa.com/"+uObj['uri'], '_new');
				}

//				switchVisibility();
			}else{
				main.log.info('SELF???');
			}
			toWhom(vb.no, uObj);
		}

		private function toWhom(r:Number, uO:Object) :void
		{
			this._drinkReceiverAsVBS = r;
			this._drinkReceiverAsUO = uO;
		}

		private function waiter(e:Event) :void
		{

			var fromPosX:Number;
			var fromPosY:Number;
			var drinkTo:Number = this._drinkReceiverAsVBS;
			var modX:Number = _vbs[0].quadrant(drinkTo);
			var modY:Number = _vbs[0].quadrant(drinkTo, false);

			main.log.info('send drink fired arrived at table');
			switchVisibility();
			/*
			this._drink = {	no: e.target.no, title: e.target.title, price: e.target.price,
									sender: {id: main._me['userId'], ix: 0, posx: (_vbs[0].x - 20), posy: _vbs[0].y},
									receiver: {id:0, ix: 0, posx: _vbs[this._drinkReceiverAsVBS].x, posy: _vbs[this._drinkReceiverAsVBS].y}
								};*/
			try {
			this._drink = {no: e.target.no, title: e.target.title, price: e.target.price, from: main._me.sfoxId, to: grabSI({need:'sfid', have:'idx', cmp:Number(drinkTo)})};
			} catch (e:Error) {main.log.info('_Drink error:' + e.message);}

			var toPosX:Number = _vbs[drinkTo].x - (15 * ((drinkTo == 0) ? 1 : .75)) + ((modX * modX - modX)/ 2) * (175 * ((drinkTo == 0) ? 1 : .75)); // f(1) = 0, f(-1) = 1, f(modX) = ((modX * modX - modX) / 2);
			var toPosY:Number = _vbs[drinkTo].y + 10 * ((drinkTo == 0) ? 1 : .75) +  ((modY + modY * modY)/ 2) * (120 * ((drinkTo == 0) ? 1 : .75)); // f(-1) = 0, f(1) = 1, f(modY) = ((modY + modY * modY)/ 2)

			if(glassHolder[drinkTo] == true){
				glasses[drinkTo].glassEmpty(null);
			}
			var glass:gGlass = new gGlass(this, {no: e.target.no, title: e.target.title, price: e.target.price, fromposx: (_vbs[0].x - 20), fromposy: _vbs[0].y, toposx: toPosX, toposy: toPosY, sendTo: drinkTo});
									/*receiver: {id: 0, ix: 0, posx: (_vbs[0].x - 20), posy: _vbs[0].y},
									sender: {id: main._me['userId'], ix: 0, posx: _vbs[this._drinkReceiverAsVBS].x, posy: _vbs[this._drinkReceiverAsVBS].y}
						});*/
			glasses[drinkTo] = glass;
			glassHolder[drinkTo] = true;
			glass.addEventListener('GLASS_KILLED', glassRemoved);

			if(!_mute)sndMaker.playSound('coindrink');

			logWriter('içki gönderdi: '+this._drink['title']);
			e.target.parent.parent.dispatchEvent(new Event('SENDING_DRINK'));

		}

		private function glassRemoved(e:impEvent) :void
		{
			glassHolder[e.params.sendTo] = false;
		}

		public function passBid(b:Object) :void // Masaya giden bid
		{
			if (b.type == "timeout-server") b.type = "timeout";

			var idx2:Number = grabSI( {need:'uid', have:'sfid', cmp:Number(b.who)});
			loguser("passbid: "+idx2+" / "+b.amount+" ZB$");
			var idx:Number = grabSI( {need:'idx', have:'sfid', cmp:Number(b.who)});
			main.log.info('passBid Initiated with idx: '+ idx + ' & amount: '+ b.amount);
			if (idx != -1)
			{
				main.log.info('idx retreived successfully: ' +  idx);
				var diff:Number = getSeatOffset();
				idx += diff;
				if (diff!=0) main.log.info('seatOffset is '+diff+', included');
				var mc:Sprite = this._vbs[ idx ];

				var vu:vUser = this._vbs[ idx ] as vUser;
				var str:String = b.type;
				if (b.type == "check") str="bop";
				else if (b.type == "call") str="Gördü: "+b.amount;
				else if (b.type == "raise") str="Arttırdı: +"+b.raisedAmount;
				else if (b.type == "allin") str="Rest: "+b.amount;
				else if (b.type == "fold") str="FOLD";
				else if (b.type == "timeout") str="Zaman Bitti";
				vu.uName(str);

				if((b.type == "call") || (b.type == "raise") || (b.type == "allin")){
					if(!_mute)sndMaker.playSound('coin');
				}

				if (b.type == "fold" || b.type == "timeout") {
				
					this._vbs[ idx ].setStatus({folded:true});
				
				} else { //fold
					var cn:Array = [2000, 1000, 500, 100, 50, 25, 10, 5];
					var offset:Number = 40;
					var v:Number = Number(b.amount);
					var k:Number = 0;
					//Chip coordinates are x: 520, y: 290
					var modX:Number= _vbs[idx].quadrant(idx);
					var initX:Number = this._vbs[ idx ].x + 53.5 + 53.5 * modX + ((modX - (modX * modX)) / 2) * 53.5;
					var initY:Number = Number(this._vbs[ idx ].y + offset);
					var offsetX:Number = stashPos.x - initX;
					var offsetY:Number = stashPos.y + 10 - initY;
					
					for(var j:Number=0; j<cn.length; j++) {
						if( v >= cn[j] ) {
							var t:Number = Math.floor(v/cn[j]) * cn[j];
							{
							
								var stashOpponent:gStash;
								stashOpponent = new gStash(this, t, initX, initY);
								var twa:GTween = new GTween(stashOpponent, 0.1, {alpha: 0});
								twa.paused = true;
								var tw:GTween = new GTween(stashOpponent,  .5 - (0.03 * k), {x: offsetX, y: offsetY, ease:Sine.easeOut}, {snapping: true});
								tw.delay = (0.1 * k);
								//twa.delay = 1;
								tw.nextTween = twa;
								v -= t;
								k ++	
								if(v < 5) {
									tw.addEventListener(Event.COMPLETE, function(e:Event):void {
										dispatchEvent(new Event('BIDDING_HANDLED'));
									});
								}
					
							}
						}
					}
					
					}//not fold
			} else {
				//Animation fail safe
					dispatchEvent(new Event('BIDDING_HANDLED'));
			}

		}

		public function passDrink(d:Object) :void
		{
			var gObj:Object = d;
			var drinkFrom:Number = grabSI({need: 'idx', have:'sfid', cmp: d.from});
			var drinkTo:Number = grabSI({need: 'idx', have:'sfid', cmp: d.to});

			var modX:Number = (drinkTo > 0) ? _vbs[0].quadrant(drinkTo) : -1;
			var modY:Number = (drinkTo > 0) ? _vbs[0].quadrant(drinkTo, false) : -1;
			var toPosX:Number;
			var toPosY:Number;
			var fromPosX:Number;
			var fromPosY:Number;
			toPosX = _vbs[drinkTo].x - (15 * ((drinkTo == 0) ? 1 : .75)) + ((modX * modX - modX)/ 2) * (175 * ((drinkTo == 0) ? 1 : .75)); // f(1) = 0, f(-1) = 1, f(modX) = ((modX * modX - modX) / 2);
			toPosY = _vbs[drinkTo].y + 10 * ((drinkTo == 0) ? 1 : .75) +  ((modY + modY * modY)/ 2) * (120 * ((drinkTo == 0) ? 1 : .75)); // f(-1) = 0, f(1) = 1, f(modY) = ((modY + modY * modY)/ 2)
			fromPosX = _vbs[drinkFrom].x;
			fromPosY = _vbs[drinkFrom].y;
			gObj.toposx = toPosX;
			gObj.toposy = toPosY;
			gObj.fromposx = fromPosX;
			gObj.fromposy = fromPosY;
			new gGlass(this, gObj);
		}


		private function logWriter(m:String, local:Boolean=false) :void
		{
		if (local)
			dispatchEvent(new impEvent('LOG_CONTENT', {message:m})); //display the message locally
		else
			dispatchEvent(new impEvent('LOG_MESSAGE', {message:m})); //display and distribute the message
		}

		private function sliderScroll(s:Slider, l:TextField) :void { l.text = String(Math.floor(s.value)); }
		public function get sliderAmount():Number	{ return Math.floor(_rz.value); }
		public function get drinkName() :String { return this._drinkName; }
		public function get drinkPrice() :Number { return this._drinkPrice; }
		public function get drinkReceiverVBS() :Number { return this._drinkReceiverAsVBS; }
		public function get drinkReceiverUO() :Object { return this._drinkReceiverAsUO; }
		public function get drink() :Object { return this._drink; }

		private function showUBox(e:Event) :void
		{
			switchVisibility();
		}

		public function switchVisibility() :void
		{
			_nrFlag = !_nrFlag;
			_nUBox.visible = !_nUBox.visible;
		}

		private function autoPlay(e:impEvent):void {
			main.log.info('autoPlay fn started');
			if(e.params.action != null) {
				if(_vbs[0]._autoMode == e.params.action) {
					main.log.info('Automode active with: ' + _vbs[0]._autoMode + ' stopping now!')
					_vbs[0]._autoMode = 'stop';
				} else {
					main.log.info('Automode active with: ' + _vbs[0]._autoMode + ' changing it to ' + e.params.action);
					_vbs[0]._autoMode = e.params.action;
				}
			} else {
				main.log.info('AUTO_TOGGLE @param failed!');
			}
		}

		private function playHand(e:PlayHand): void {
			main.log.info('##playHand##');
			if(e.params.action != null) {
				var amt:Number = this.sliderAmount;

				if (e.params.action == "raise2")
					{
					e.params.action = "raise";
					amt = e.params.raiser;
					}

				main.log.info('$$$' + e.params.action + '$$$ ('+amt+')');


				if (e.params.action == "checkfold")
					{
					if (this.bidParams.toCall==0)
						{
						e.params.action = "check";
						amt = 0;
						}
					else
						{
						e.params.action = "fold";
						}
					}
				else if (e.params.action == "callany")
					{
					amt = this.bidParams.toCall;
					e.params.action = "call";
					}

				if (amt <= 0 && e.params.action!="fold" && e.params.action!="allin" && e.params.action!='call')
					{
					amt = 0;
					e.params.action = "check";
					}
				/*else if (amt == this.bidParams.toCall && e.params.action=="raise") // amt can be equal even smaller than toCall
					{
					e.params.action = "call";
					}
				else if (amt < this.bidParams.toCall && e.params.action!='call' && e.params.action!='fold')
					{
					e.params.action = "allin";
					}*/

				if (e.params.action == "check" && this.bidParams.toCall>0)
					{
					loguser('error: cannot CHECK (toCall:'+this.bidParams.toCall+')');
					return;
					}

				if (e.params.action == "call" && main._me.useableCash <= this.bidParams.toCall) {
					e.params.action = "allin";
				}

				turnChange(false);

				var outp:Object = this.bidParams;
				var cashArray:Array = new Array();
				outp.raisedAmount = 0;

				switch(e.params.action) {
					case "check":
						logWriter('bop');
						amt = 0;

						break;
					case "call":
						amt = this.bidParams.toCall;
/*
						if (this.bidParams.openingBet) //not used
							logWriter('ortaya '+amt+' koydu');
						else
*/
							logWriter('eli gördü');

						break;
					case "raise":
						//var diff:Number = amt - this.bidParams.toCall;
						outp.raisedAmount = amt;
						amt = amt + this.bidParams.toCall;

						if (this.bidParams.toCall>0)
							logWriter('gördü ve '+outp.raisedAmount+' arttırdı');
						else
							logWriter(outp.raisedAmount+' arttırdı');

						break;
					case "allin":
						amt = this.bidParams.maxBet;
						if(amt<main._me.useableCash && amt>this.bidParams.toCall) {
							logWriter('gördü ve '+String(amt - this.bidParams.toCall)+' arttırdı');
						} else {
							logWriter(amt+' ile rest çekti');
						}

						break;
					case "fold":
						logWriter('eli bıraktı');
						amt = 0;
						this._folded = true;
						_vbs[0].setStatus({folded:true});
						break;
				}


			this.betAmount = amt;
			outp.amount = amt;
			outp.type = e.params.action;
			if (amt>0) animateMyCash();
			dispatchEvent(new impEvent('BIDDING_COMPLETE', outp));

			} else {
				main.log.info('FAIL Getting Object');
			}
		}

		private function animateMyCash():void {
			//var stashMine:gStash;
			var cn:Array = [2000, 1000, 500, 100, 50, 25, 10, 5];
			var v:Number = Number(this.betAmount);
			var k:Number = 0;
			for(var j:Number=0; j<cn.length; j++)
			{
				if( v >= cn[j] )
				{
					var t:Number = Math.floor(v/cn[j]) * cn[j];
					/*
					for(var i:Number=1; i <= t; i++)
					{
						cns.push( 'chip0' + String(this.cn[j]) );
						v -= this.cn[j];
					}
					*/
					{
					//main.log.info('##### T : ' + t);
					var stashMine:gStash = new gStash(this, t, this._vbs[0].x - 25, this._vbs[0].y + 40, false);
					var twa:GTween = new GTween(stashMine, 0.1, {alpha: 0});
					twa.paused = true;
					var tw:GTween = new GTween(stashMine, .5 - (0.03 * k), {x: stashPos.x - this._vbs[0].x + 25, y: stashPos.y - this._vbs[0].y - 80, ease:Sine.easeOut}, {snapping: true});
					//var twa:GTween = new GTween(stashMine, 0.1, {alpha: 0});
					tw.delay = (0.1 * k);
					//twa.delay = 1;
					tw.nextTween = twa;
					v -= t;
					k++;
					}
				}
			}
			//cns.reverse();
			
			//stashMine = new gStash(this, Number(this.betAmount), this._vbs[0].x - 25, this._vbs[0].y + 40, false);
			/*
			var tw:GTween = new GTween(stashMine, 0.5, {x: stashPos.x - this._vbs[0].x + 25, y: stashPos.y - this._vbs[0].y - 80}, {snapping: true});
			var twa:GTween = new GTween(stashMine, 0.1, {alpha: 0});
			twa.delay = 1;
			tw.nextTween = twa;
			*/
		}

		public function bidDoneTimeOut(e:Event) :void {
		try{
			logWriter('zamanı bitti (Fold)');
			this._folded = true;
			if (e==null)
				{
				_vbs[0].endTimer();
				}
			_rz.turnOthers();
			if (e!=null)
				{
				dispatchEvent(new impEvent("BIDDING_COMPLETE", {type:'timeout'}));
				}
			}catch(ex:Error){loguser("bidDoneTimeOut exception: "+ex);}
		}

		public function updateTableCash(c:Number) :void // Cash re-calculator
		{
		if(!_mute)sndMaker.playSound('coin');
		try{
			if (!sitting && c==0)
				this._tc.text = "";
			else
				this._tc.text = this.tcpre + String(c);
			tableCash = c;
			if (stash) removeChild(stash);
		}catch(e:Error){}
			stash = new gStash(this, c, stashPos.x, stashPos.y/*_tbl.x+40+_tbl.width/2, _tbl.y+_tbl.height-160*/);
		}

		public function loguser(s:String):void
		{
		main.log.info("["+main._me['userId']+"] "+s);
		}

		public function traceuser(s:String):void
		{
		main.log.trace("["+main._me['userId']+"] "+s);
		}

		public function blindsPaid(sfid:Number, type:String, amount:Number) :void
		{
			var idx:Number = grabSI( {need:'idx', have:'sfid', cmp:sfid} );
			if (idx<0) return;
			idx += getSeatOffset();

			var ob:Object = this._vbs[idx].uObj;

			logWriter("["+ob.uri+"] blind ödedi: "+amount, true);
		}

		public function handleMultiTurnUI(sfid:Number) :void
		{
			var who:Number = -1;
			if (sfid>-1) who = grabSI( {need:'uid', have:'sfid', cmp:Number(sfid)});

			var ix:Number = 0;
			var st:String = main._me['seats'];

//			loguser("led/who:"+who+", sfid="+sfid+", uid="+main._me['userId']+", seats: "+st);
			if (st==null) return;

			var sta:Array = st.split(';');
			for(var i:Number=0; i<this.roomMax; i++){
				if(this._vbs[i])
					{
					(_vbs[i] as vUser).ledOff();
					(_vbs[i] as vUser).endTimer(false);
					}
			}

			if (who<0) return;

			var sits:Array = this.sitOrder[this.roomMax].slice();
			var diff:Number = getSeatOffset();

			for(var stax:String in sta){
				var ea:String = sta[stax];
				var eax:Array = ea.split(':');

				if(who == Number(eax[1]))
				{
					if(who == main._me['userId']){
//						traceuser("led1");
						(this._vbs[ 0 ] as vUser).led(true);
						break;
					}else{
//						traceuser("led2");
						(this._vbs[ sits[ Number(eax[2])+diff ] ] as vUser).led(true);
						(this._vbs[ sits[ Number(eax[2])+diff ] ] as vUser).startTimer(false);
						break;
					}
				}

			}
		}

		public function turnChange(isMine:Boolean):void
		{
		try{
		if (isMine) {
			if(!_mute)sndMaker.playSound('beep');
			myTurn = true;
			// Stop auto functions at Turn Off checkbox
			_rz.uncheckBoxes();
			_rz.turnMine(this.bidParams.toCall, this.bidParams.minRaise, this.bidParams.maxRaise, this.bidParams.maxBet, this.gameType, this.bidParams.firstToAct);
			this.handleMultiTurnUI(main._me['sfoxId']);
			_vbs[0].startTimer();
			}
		else
			{
			myTurn = false;
//			loguser("turn: not my turn");
			_vbs[0].endTimer();
			_rz.turnOthers();
			}
		}catch(e:Error){loguser("turnChange exception: "+e);}
		}

		public function acceptBid(params:Object) :void
		{
		this.bidParams = params;
		traceuser("acceptBid toCall:"+params.toCall+", minRaise:"+params.minRaise+", maxRaise:"+params.maxRaise+", maxBet:"+params.maxBet+" "+(params.firstToAct?"FIRST TO ACT":""));
			if(!this._folded){
				turnChange(true);
			}else{
				dispatchEvent(new impEvent("BIDDING_COMPLETE", {type:'fold'}));
			}
		}

		public function moveFinalStash(sfid:Number) :void
		{
			this._folded = false;
			var idx:Number = grabSI( {need:'idx', have:'sfid', cmp:Number(sfid)} );
			idx += getSeatOffset();

			var offset:Number = (idx === 0) ? 130 : 40;

			try{

			var modX:Number= _vbs[idx].quadrant(idx);
			var initX:Number = (idx === 0) ? this._vbs[idx].x - 25 : this._vbs[ idx ].x + 53.5 + 53.5 * modX + ((modX - (modX * modX)) / 2) * 53.5;
			var initY:Number = Number(this._vbs[ idx ].y + offset);

			var offsetX:Number = initX - stashPos.x;
			var offsetY:Number = initY - stashPos.y;

			var tw:GTween = new GTween(stash, 0.5, {x: offsetX, y: offsetY}, {snapping: true});
			var twa:GTween = new GTween(stash, 0.1, {alpha: 0});

			twa.delay = 1;
			tw.nextTween = twa;

			tw.addEventListener(Event.COMPLETE, finstashMoved);
			}catch(e:Error){finstashMoved(null);}
		}

		private function finstashMoved(e:Event) :void
		{
		}

		public function dealCards(c:Array, setInGame:Boolean = false) :void
		{
			try {
			if(!_mute)sndMaker.playSound('shuffle');
			if(!_mute)sndMaker.playSound('deal');
			} catch(err:Error) {main.log.info('Sound Check 2: ' + err.toString());}

			logWriter('kağıtlar dağıtıldı', true);

			if (setInGame) this.inGame = (c.length>0);

//			traceuser("dealcards: set:"+setInGame+" res:"+this.inGame+" len:"+c.length);

			if (this.inGame) this._vbs[0].cards = c.slice();

			for(var i:Number=0; i<this._vbs.length; i++)
				{
				if (i>0 && !_mute) sndMaker.playSound('deal');
				this._vbs[i].setStatus({dealt:true});
				}
			}

		public function tableCards(c:Array) :void
		{
			var i:Number = 0;
			//var cTimer:Timer = new Timer(450, c.length);
			this._cTimer.reset();
			this._cTimer.start();
			this._cTimer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void{
				showCard(c[i],	_tbl.x + (_tbl.width-(65*5))/2 + 65*i - 50, _tbl.y + 120);
				i++;
			});
			
			this._cTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void{
				//this._cTimer.stop();
			});
           
            // starts the timer ticking
            
			/*
			while(c.length>0)
			{
				showCard(c.shift(),	_tbl.x + (_tbl.width-(65*5))/2 + 65*i++ - 50, _tbl.y + 120);
			}
			*/
		}

		public function tableCardsTR(c:String, m:Number) :void
		{
				//main.log.info("###ZAMAN: " + this._cTimer.running);
				if(this._cTimer.running) {
					//main.log.info("###ZAMAN ZAMAN####");
					var cTimer:Timer = new Timer((450*3) + ((m - 2) * 450), 1);
					cTimer.start();
					cTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void{
						showCard(c, _tbl.x + (_tbl.width-(65*5))/2 + 65*m - 50, _tbl.y + 120);
					});
				} else {
					if(m == 4) {
						var rTimer:Timer = new Timer(425, 1);
						rTimer.start();
						rTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void{
							showCard(c, _tbl.x + (_tbl.width-(65*5))/2 + 65*m - 50, _tbl.y + 120);
						});
					} else {
						showCard(c, _tbl.x + (_tbl.width-(65*5))/2 + 65*m - 50, _tbl.y + 120);
					}
				}
		}

		private function showCard(c:String, px:Number, py:Number) :void
		{
		
			var conB:Sprite = new Sprite();
			conB.x = px;
			conB.y = py;
			_wholeCards.addChild(conB);
			
			var con:Sprite = new Sprite();
			con.x = px + (54.5 / 2);
			con.y = py;
			con.alpha = 0;
			con.scaleX = 0.04;
			_wholeCards.addChild(con);
			
			var sc:Class = this['card'+c] as Class;
			var symbol:Sprite = new sc() as Sprite;
			con.addChild(symbol);
			
			//var scb:Class = 'cardback' as Class;
			var back:Sprite = new cardback();
			conB.addChild(back);
			
			var twb:GTween = new GTween(con, 0.1, {scaleX: 1, x: px, alpha:1});
			twb.paused = true;
			var twa:GTween = new GTween(conB, 0.1, {scaleX: 0.04, x: px + (54.5 / 2)});
			twa.nextTween = twb;
			/*
			twa.onComplete = function (twn:GTween) {
				con.alpha = 1;
				conB.alpha = 0;
			}
			*/
			
			
			if(!_mute)sndMaker.playSound('tablecard');
		}

		public function cleanTable(ownToo:Boolean = false) :void
		{
		if (!this.ready)
			{
			loguser("skipping cleanTable");
			return;
			}
		try{
			for(var i:Number=ownToo?0:1; i<this._vbs.length; i++)
				{
				this._vbs[i].setStatus({dealt:false, folded:true});
				}

			if (_wholeCards!=null) _cardsUp.removeChild(_wholeCards);
			_wholeCards = new Sprite();
			_cardsUp.addChild(_wholeCards);

			/*
			try{
			removeChild(stash);
			}catch(e:Error){};
			*/

			_tc.text = this.tcpre + "0";
		}catch(e:Error){loguser("cleanTable exception: "+e.message);}
		}

		public function newGameSoon(): void
		{
/*
		if (this.sitting && main._me['useableCash']<this.blind)
			{
			cimdikCek();
			}
*/
		logWriter('yeni el başlar...', true);
		}

		public function cimdikCek(sit:Boolean = false):void // Possible bug investigate
		{
		try{
			if (isNaN(main._me['useableCash']) || main._me['useableCash']<1) main._me['useableCash'] = 0;
			if (isNaN(main._me['total']) || main._me['total']<1) main._me['total'] = 0;
			main._me['total'] += main._me['useableCash'];
			main._me['useableCash'] = 0;

			var _amount:Number = mainRef.cekilecekCimdik(this._minBuyIn, this._maxBuyIn);
			main.log.info('AMOUNT: '+_amount+'...'+this._minBuyIn+'/'+this._maxBuyIn);
			if (_amount>0)
				{
				dispatchEvent(new impEvent('BUY_INTO_DONE', {amount: _amount, sit:sit}));
				if (!sit)
					{
					logWriter('kasasından '+String(_amount)+' çimdik çekti', false);
					}
				}
			else
				{
				main._noSit = true;
				this.buttonSit.hide();
				if (!sit)
					{
					dispatchEvent(new Event('STAND_UP'));
					logWriter('kasasında çimdik kalmadı, oyuna izleyici oldu', false);
					dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Oynamak için alabileceğiniz çimdik kalmadı, üzgünüz."}));
					}
				else
					{
					dispatchEvent(new impEvent('DISPLAY_ALERT', {message: "Elinizdeki çimdikler seçtiğiniz oda için yeterli değil."}));
					}
				}
		}catch(e:Error){loguser("cimdikCek exception: "+e);}
		}

		public function forcedSitOut(params:Object): void
		{
			loguser("forced sit out, reason: "+params.reason);
			if (params.reason == 'cash') cimdikCek();
		}

		public function turnEnded() :void
		{
			this.turnStatus = 0;
//			loguser("turnEnded() called: sitting="+this.sitting);
try{
			turnChange(false);
			this._folded = false;
//			_dLed.visible = false;
			handleMultiTurnUI(-1);
			this.inGame = false;
			playerCountUpdate(this.playerCount);
			_rz.uncheckBoxes();
}catch(e:Error){loguser("turnEnded exception:"+e.message);}
		}

		public function hideWinnerPopups() :void
		{
			for(var s:String in this._vws)
			{
				this._vws[s].hide();
			}
		}

		public function turnStarted() :void
		{
			this.turnStatus = 1;
try{
			this.cleanTable();
}catch(e:Error){loguser("turnStarted cleanTable exception:"+e.message);}
try{
			loguser("turnStarted() called");

			this._folded = false;
			_dLed.visible = true;
//			this.buttonSit.hide();
}catch(e:Error){loguser("turnStarted exception:"+e.message);}

		_tcbt.text = 'Kasa: ' + main._me['total'];
		}

		private function buyInto(e:impEvent) :void
		{
			dispatchEvent(new impEvent('BUY_INTO_DONE', {amount: e.params.amount}));
		}

		private function noBuyInto(e:impEvent) :void
		{
			standUp(null);
		}

		public function winnersWon(winners:Array) :void
		{
		var bigHand:Boolean = false;
		var stashMoved:Boolean = false;

		loguser("winnersWon: "+winners.length);

		var wili:Number = winners.length;
		var winnerList:Array = [];
		var msgs:Array = [];
		for(var wi:Number=0;wi<wili;wi++)
			{
			try{
			loguser("WI:"+winners[wi]);
			var w:Array = winners[wi].split(':'); // sfid / amountwon / deckscore / hand
			var sfid:Number = w[0], amount:Number = w[1], deckscore:Number = w[2], pocketcards:Array = w[3].split(',');
			
			main.log.info('Kartlar: ' + pocketcards[0] + ' ' + pocketcards[1]);
			
			var rank:String = "";
			if (deckscore>-1)
				{
				var pc:Number = Number(deckscore) >> 12;
				var ps:Number = Number(deckscore) & 0x00000fff;
				rank = this.ranks[pc-1];
				}

			var idx:Number = grabSI( {need:'idx', have:'sfid', cmp:Number(sfid)});

			// kendisi kazandıysa alkış
			if(this._cTimer.running) {
				var cTimer:Timer = new Timer(425 * 6, 1);
				cTimer.start();
				cTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
					if(idx==0) if(!_mute) sndMaker.playSound('applause');
				});
			} else {
				var rTimer:Timer = new Timer(425, 1);
				rTimer.start();
				rTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
					if(idx==0) if(!_mute) sndMaker.playSound('applause');
				});
			}
			
			
			if (idx<0)
				{
				loguser("winnersWon idx is -1! sfid = "+sfid);
				continue;
				}

			if (!stashMoved)
				{
				moveFinalStash(sfid);
				stashMoved = true;
				}
			idx += getSeatOffset();

			var ob:Object = this._vbs[idx].uObj;

			main.log.trace("winner: "+ob.uri+" ("+sfid+") / hand: "+rank+" / "+deckscore+" / won: "+amount);

			var msg:String = "";

			if (rank!="")
				msg = ob.uri+' '+rank+' eliyle '+amount+' kazandı';
			else
				msg = ob.uri+' '+amount+' kazandı';

			if (msg!="")
				{
				msgs.push(msg);
				logWriter(msg, true);
				winnerList.push({msg:msg, name:ob.uri, sfid:sfid, amount:amount, hand:rank, pocketcards:pocketcards});
				}

			}catch(e:Error){loguser("winnersWon exception: "+e+" wi="+wi);}
			}

// winnerList.push({msg:msg, name:ob.uri, sfid:sfid,
// amount:amount, hand:rank, pocketcards:pocketcards});


			var vu:UIAlertWinner;
			var diff:Number;

			if(this._cTimer.running) {
				for(wi=0;wi<wili;wi++) {
					idx = grabSI( {need:'idx', have:'sfid', cmp:Number(winnerList[wi].sfid)});

					diff = getSeatOffset(); idx += diff;
					vu = this._vws[ idx ] as UIAlertWinner;

					// layerindex yüksek olması için sonradan build ediliyor
					vu.show(msgs[wi], winnerList[wi], true);				
				}
			} else {
				for(wi=0;wi<wili;wi++) {
					idx = grabSI( {need:'idx', have:'sfid', cmp:Number(winnerList[wi].sfid)});

					diff = getSeatOffset(); idx += diff;
					vu = this._vws[ idx ] as UIAlertWinner;

					// layerindex yüksek olması için sonradan build ediliyor
					vu.show(msgs[wi], winnerList[wi]);				
				}
			}

//			_winnerWin.show(msgs.join("; "), winnerList); //FIXME: al winnerList'i bisey yap

		}

		// main._me.seats setinden verilen bilginin karşılık değerlerini getirir
		// bir nevi smartfoxid & profileid & seatno arasında converter

		public function grabSI(o:Object=null, debug:Boolean = false) :Number
		{
			var aPos:uint;
			var st:String = main._me.seats;
			var sta:Array = st.split(';');
			var result:Number = -1;
			var need:Number;
			var have:Number;

			if(o.cmp && o.need && o.have)
			{
				switch(o.need)
				{
					case 'sfid':	need = 0;	break;
					case 'uid':		need = 1;	break;
					case 'idx':		need = 2;	break;
				}
				switch(o.have)
				{
					case 'sfid':	have = 0;	break;
					case 'uid':		have = 1;	break;
					case 'idx':		have = 2;	break;
				}
			if(debug) {main.log.info('grabSI: ' + o.have + ' | ' + o.need + ' | ' + o.cmp)}
				for(var stax:String in sta)
				{
					var ea:String = sta[stax];
					var eaa:Array = ea.split(':');
					if( o.cmp == Number(eaa[have]) ){
						result = Number(eaa[need]);
						break;
					}
				}
			}
			return result;
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
	
	}

}
