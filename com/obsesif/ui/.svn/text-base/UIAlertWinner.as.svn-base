package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	
	import flash.events.TimerEvent;
    import flash.utils.Timer;

	import com.gskinner.motion.GTween;
	import com.obsesif.ui.UIFactory;

	public class UIAlertWinner extends UIFactory
	{
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

		private var _win:Sprite;
		private var _ws:Sprite;
		private var _back:Sprite;
		private var deck:Object;
		private var _wholeCards:Sprite;
		private var symbol:Sprite;
		private var ldrA:Loader;
		private var _msg:String;
		private var _winner:Object;
		private var _deckLoaded:Boolean = true;
		private var xp:Array;
		private var yp:Array;
		private var zap:Array;
		public var basey:Number = 0;
		private var _no:Number = -1;

		public function UIAlertWinner(parent:DisplayObjectContainer, xpos:Number=0, ypos:Number=0, total:Number=9, no:Number=-1) :void
		{
			this._no = no;
			xp = new Array(269, 112, -30, -30, 128, 298, 468, 625, 625, 484);
			yp = new Array(275, 290, 220,  62, -10, -10, -10,  62, 220, 290);
			zap = [ [], [], [1,2,3,4,6,7,8,9], [1,2,3,5,7,8,9], [1,3,4,6,7,9], [1,3,5,7,9], [1,2,8,9], [2,5,8], [2,8], [5], [] ];
			var z:Array = (zap[total] as Array).sort(Array.NUMERIC).reverse();
			for each(var t:Number in z){
				this.xp.splice(t, 1);
				this.yp.splice(t, 1);
			}
/*
			ldrA = new Loader();
			ldrA.contentLoaderInfo.addEventListener(Event.COMPLETE, cardsLoaded);
			var request:URLRequest = new URLRequest('../assets/gDeck.swf');
			ldrA.load(request);
*/
			super(parent, Math.round(this.xp[no]+xpos), Math.round(this.yp[no]+ypos-20));
		}

		override protected function init():void
		{
			super.init();
			buttonMode = false;
			useHandCursor = false;
		}

		override protected function addChildren() :void
		{
			_win = new Sprite();
			addChild(_win);

			_back = new Sprite();
			_win.addChild(_back);
			_back.graphics.lineStyle(3, 0x19262E);
			_back.graphics.beginFill(0x547183);
			_back.graphics.drawRoundRect(0, 0, ((this._no == 0) ? 170 : 140), 160, 20);
			_back.graphics.endFill();
			_back.alpha = .8;

			_ws = new Sprite();
			_win.addChild(_ws);
		}
/*
		private function cardsLoaded(e:Event) :void
		{
			var rc:Class = ldrA.contentLoaderInfo.applicationDomain.getDefinition('gDeck') as Class;
			this.deck = new rc();
			this._deckLoaded = true;
		}
*/
// winnerList.push({msg:msg, name:ob.uri, sfid:sfid,
// amount:amount, hand:rank, pocketcards:pocketcards});

		public function hide() :void
		{
			y = 1000;
			if(_ws != null) if(_ws is Sprite) _win.removeChild(_ws);

			_ws = new Sprite();
			_win.addChild(_ws);
		}

		public function show(t:String, u:Object, time:Boolean = false) :void
		{
		
			if(time) {
				var check:Boolean = this._deckLoaded;
				var delay:Timer = new Timer((425 * 6), 1);
				delay.start()
				delay.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
					singleLine(_ws, 'Son eli kazanan', 130, "AirSansBold", 0x0, 15, 5, 5);
					singleLine(_ws, t+', elindekiler: '+renameCards(u.pocketcards.join(' ve ')), ((this._no == 0) ? 150 : 130), "AirSans", 0x0, 12, 5, 100);
					
					if(check){
						main.log.info(u['pocketcards'][0] + ' | ' +u['pocketcards'][1]);
						var w:Object = u['pocketcards'];
						for(var i:Number = 0; i<w.length; i++){
							showCard(w[i], 20+i*60, 25, .85);
						}
					}
					y = basey;
				});
			} else {
				singleLine(_ws, 'Son eli kazanan', 130, "AirSansBold", 0x0, 15, 5, 5);
				singleLine(_ws, t+', elindekiler: '+renameCards(u.pocketcards.join(' ve ')), ((this._no == 0) ? 150 : 130), "AirSans", 0x0, 12, 5, 100);
				
				if(this._deckLoaded){
					main.log.info(u['pocketcards'][0] + ' | ' +u['pocketcards'][1]);
					var w:Object = u['pocketcards'];
					for(var i:Number = 0; i<w.length; i++){
						showCard(w[i], 20+i*60, 25, .85);
					}
				}
				y = basey;
			}
		}
		private function showCard(c:String, px:Number, py:Number, s:Number) :void
		{
			//main.log.info('#########showCard#########: ' + c);
			var con:Sprite = new Sprite();
			con.x = px;
			con.y = py;
			con.scaleX = s;
			con.scaleY = s;
			_ws.addChild(con);

			try {
				var sc:Class = this['card'+c];// as Class;
				var symbol:Sprite = new sc() as Sprite;
			} catch (e:Error) {
				main.log.info('#########hata: ' + e);
			}
			
			try {
				//main.log.info('#card: ' + c);
				con.addChild(symbol);
			} catch (e:Error) {
				main.log.info('hata: ' + e);
			}
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
