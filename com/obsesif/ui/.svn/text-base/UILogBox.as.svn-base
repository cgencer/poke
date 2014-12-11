package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.obsesif.ui.UIFactory;
	import com.obsesif.ui.UIInputText;
	import com.bit101.components.Slider;

	public class UILogBox extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="windowOutput2")]
      private var rawOutput:Class;

		private var _cb:Sprite;
		private var _spr:Sprite;
		private var _msk:Shape;
		private var _slider:Slider;
		private var _p:String;
		private var _l:String;

		public function UILogBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, part:String="TABLE", l:String='Hamleler') :void
		{
			this._p = part;
			this._l = l;
			super(parent, xpos, ypos);
		}

		override protected function init():void { super.init(); }

		override protected function addChildren() :void
		{
			_cb = new rawOutput();
			addChild(_cb);
			
			if(this._l == 'Hamleler') {
				writeLine(this, {labels: this._l, xpos: 35}, {color: 0xffffff, size: 13});
			} else {
				writeLine(this, {labels: "Uyelikler", xpos: 38}, {color: 0xffffff, size: 13});
			}
			_spr = new Sprite();
			_spr.x = 5;
			_spr.y = 35;
			addChild(_spr);

			_msk = new Shape();
			_msk.x = 5;
			_msk.y = 35;
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, 130, 170);
			_msk.graphics.endFill();
			addChild(_msk);

			_spr.mask = _msk;
		}

		public function addContent(c:String) :void
		{
			var oldh:Number = _spr.height;
//			writeLine(_spr, {labels: c, ypos:_spr.height-7}, {color: 0xffffff, size: 10});
			singleLine(_spr, c, 126, "AirSans", 0xffffff, 9, 0, _spr.height);
			if(_spr.height > 130) _spr.y -= _spr.height-oldh;
		}
	}
}
