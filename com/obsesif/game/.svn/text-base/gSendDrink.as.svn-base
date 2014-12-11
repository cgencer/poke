package com.obsesif.game
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	import flash.net.URLRequest;
	import flash.net.URLLoader;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.gskinner.motion.GTween;
	import net.stevensacks.utils.Web;

	import com.obsesif.ui.UIFactory;
	import com.obsesif.ui.UIButton;
	import com.obsesif.game.gCoctail;

	public class gSendDrink extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="winA")]
      private var rawUserWin:Class;
      [Embed(source="/assets/UIElements.swf", symbol="winB")]
      private var rawDrinksWin:Class;
      [Embed(source="/assets/UIElements.swf", symbol="xoff")]
      private var rawXOff:Class;

		private var preUrl:String = 'http://www.zukaa.com/u/profilepictures/';
		private var uObj:Object;
		private var _ba:Sprite;
		private var _bb:Sprite;
		private var _dwFlag:Boolean = false;
		private var _wu:Sprite;
		private var _wd:Sprite;
		private var _wm:Sprite;
		private var _ww:Sprite;
		private var _wx:Sprite;

		private var drinks:Array = [];
		private var ldr:Loader;
		private var ldrB:Loader;
		private var deck:Object;
		private var bar:Object;
		private var sentNo:Number;
		private var sentName:String;
		private var sentPrice:Number;
		private var _wus:Sprite;
		private var unfos:Array = [];
		private var _uri:String = "";

		public function gSendDrink(parent:DisplayObjectContainer, xpos:Number, ypos:Number) :void
		{
			super(parent, xpos, ypos);
		}

		override protected function addChildren() :void
		{
			_ww = new Sprite();
			_ww.y = 0;
			addChild(_ww);

			_wu = new rawUserWin();
			_ww.addChild(_wu);
			_wu.x = 0-_wu.width;
			_ww.x = _wu.width;

			_wd = new rawDrinksWin();
			_ww.addChild(_wd);
			_wd.x = 0-_wd.width;

			_wm = new Sprite();
			_wm.graphics.beginFill(0xff0000);
			_wm.graphics.drawRect(0, 0, _wd.width+20, _wu.height+20);
			_wm.graphics.endFill();
			_ww.addChild(_wm);

			var _w1:Sprite = new rawXOff();
			_w1.addEventListener(MouseEvent.CLICK, closeUserInfo, false, 0, true);
			_wu.addChild(_w1);
			_w1.x = _wd.width-205;
			_w1.y = 15;

			_wd.mask = _wm;

			var _w0:Sprite = new rawXOff();
			_w0.addEventListener(MouseEvent.CLICK, closeDrinks, false, 0, true);
			_wd.addChild(_w0);
			_w0.x = _wd.width-45;
			_w0.y = 15;

			var tf:TextFormat = new TextFormat('AirSansBold', 14, 0xffffff);
			_ba = new UIButton(_wu, 30, 200, "hediye gönder", 'button', openDrinks, 1,0.8,0,tf,'n',false, 0x100);
			_bb = new UIButton(_wu, 50, 230, "profil", 'button', gotoProfile, 0.6,0.8,0,tf,'n',false, 0x010);


			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, drinksLoaded, false, 0, true);
			var request:URLRequest = new URLRequest('../assets/gDrinks.swf');
			ldr.load(request);
		}

		private function drinksLoaded(e:Event) :void
		{
			var rc:Class = ldr.contentLoaderInfo.applicationDomain.getDefinition('gDrinks') as Class;
			this.bar = new rc();

			var sc:Class;
			var glass:Sprite;
			var coc:Sprite;

			for (var i:Number=0; i<7; i++)
			{
				coc = new gCoctail(_wd, (this.bar['rawDrink'+String(i)] as Class), i, sendDrink);
				drinks.push(coc);
			}
		}

		public function updateContent( uO:Object ) :void
		{
			this._uri = uO['uri'];
			var mc:Sprite;
			for(var mx:String in unfos)
			{
				mc = unfos[mx] as Sprite;
				mc.visible = false;
			}
			if( unfos[uO['userId']] is Sprite)
			{
				mc = unfos[uO['userId']] as Sprite;
				mc.visible = true;

			}else{

				mc = new Sprite();
				_wu.addChild(mc);
				unfos[uO['userId']] = mc;

				writeLine(mc, {labels: uO.uri, xpos: 60, ypos: 120}, {font: 'AirSansBold', color: 0xffffff, size: 18});
				writeLine(mc, {labels: uO.useableCash, xpos: 80, ypos: 145}, {font: 'AirSansBold', color: 0xffffff, size: 16});
				writeLine(mc, {labels: 'Level '+uO.levels, xpos: 90, ypos: 165}, {font: 'AirSans', color: 0xffffff, size: 14});

				ldrB = new Loader();
				var reqB:URLRequest = new URLRequest(this.preUrl+uO.userId+'.jpg');
				ldrB.load(reqB);
				mc.addChild(ldrB);
				ldrB.x = 15;
				ldrB.y = 25;

			}
		}

		private function sendDrink(e:Event) :void
		{
			if(main._me['useableCash'] > e.target.parent.parent.price){
				this.sentNo = e.target.parent.parent.no;
				this.sentName = e.target.parent.parent.title;
				this.sentPrice = e.target.parent.parent.price;
				main.log.info('drink '+this.sentName+' serving...');
				e.target.parent.parent.parent.parent.parent.parent.dispatchEvent(new Event('SENDING_DRINK'));
				_wd.x = 0-_wd.width;
				_dwFlag = false;
				dispatchEvent(new Event('SENDING_DRINK'));
			}
		}

		private function closeUserInfo(e:MouseEvent) :void
		{
			dispatchEvent(new Event('CLOSE_UINFO'));
		}

		private function closeDrinks(e:MouseEvent) :void
		{
			if(_dwFlag){
				_dwFlag = false;
				new GTween(_wd, .2, {x:-_wd.width});
			}
		}

		private function openDrinks(e:Event) :void
		{
			if(!_dwFlag){
				_dwFlag = true;
				new GTween(_wd, .2, {x:0}, {completeListener:drinksOpened});
			}
		}

		private function drinksOpened(e:Event) :void
		{
		}

		private function gotoProfile(e:Event) :void
		{
			Web.getURL("http://www.zukaa.com/"+this._uri);
		}

		public function get no() :Number { return this.sentNo; }
		public function get title() :String { return this.sentName; }
		public function get price() :Number { return this.sentPrice; }
	}
}
