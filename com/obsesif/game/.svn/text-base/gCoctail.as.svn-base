package com.obsesif.game
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObjectContainer;

	import com.obsesif.ui.UIFactory;
	import com.senocular.drawing.DashedLine;

	public class gCoctail extends UIFactory
	{
		private var _no:Number;
		private var _name:String;
		private var _price:Number;
		private var sc:Class;
		private var _spr:Sprite;
		private var _box:Sprite;
		private var _grp:Sprite;
		private var _bck:Sprite;
		private var over:Sprite;
		private var _handler:Function;
		private var drinkNames:Array = ['Bira', 'Şarap', 'Konyak', 'Viski', 'Votka', 'Kokteyl', 'Tekila'];
		private var drinkPrices:Array = [20, 50, 120, 100, 60, 80, 70];

		public function gCoctail(parent:DisplayObjectContainer, sc:Class, no:Number, handler:Function)
		{
			_no = no;
			_name = drinkNames[no];
			_price = drinkPrices[no];
			_handler = handler;
			this.sc = sc;
			super(parent, 0, 0);
		}

		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
		}

		override protected function addChildren() :void
		{
			_grp = new Sprite();
			addChild(_grp);

			_bck = new Sprite();
			_grp.addChild(_bck);

			_spr = new sc() as Sprite;
			_grp.addChild(_spr);

				_bck.graphics.beginFill(0xff0000);
				_bck.graphics.drawRect(-20, 0, 70, _spr.height);
				_bck.graphics.endFill();
				_bck.alpha = 0;

			_grp.x = 30+(80*(no%4));
			_grp.y = (100 + (Math.floor(no/4)*110)) - _spr.height;

			_box = new Sprite();
			_grp.addChild(_box);
			_box.graphics.lineStyle(1, 0xaa0000);
			_box.graphics.drawRect(-10, -10, _spr.width+20, _spr.height+20);
			_box.visible = false;

			_grp.addEventListener(MouseEvent.MOUSE_OVER, function(e:Event):void{_box.visible = true;});
			_grp.addEventListener(MouseEvent.MOUSE_OUT, function(e:Event):void{_box.visible = false;});

			writeLine(_grp, {labels: this._name, xpos: 0, ypos: _spr.height+10}, {color: 0xffffff, size: 12});
			writeLine(_grp, {labels: String(this._price), xpos: 0, ypos: _spr.height+25}, {color: 0x44ff44, size: 12});

			_grp.addEventListener(MouseEvent.CLICK, this._handler);
		}

		public function get no() :Number { return this._no; }
		public function get title() :String { return this._name; }
		public function get price() :Number { return this._price; }
	}
}