package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.obsesif.ui.UIFactory;
	import com.obsesif.ui.UIInputText;
	import com.bit101.components.Slider;

	public class UIAlert extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="winB")]
      private var rawWin:Class;
      [Embed(source="/assets/UIElements.swf", symbol="xoff")]
      private var rawXOff:Class;

		private var _win:Sprite;
		private var _msk:Shape;
		private var _msg:String;
		private var _timer:Timer;
		private var _buttonT:String = "";
		private var _biOK:UIButton;

		public function UIAlert(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, msg:String="", buttonT:String = "") :void
		{
			this._msg = msg;
			this._buttonT = buttonT;
			super(parent, xpos, ypos);
		}

		override protected function init():void { super.init(); }

		override protected function addChildren() :void
		{
			_win = new rawWin();
			addChild(_win);

			_msk = new Shape();
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, _win.width, _win.height);
			_msk.graphics.endFill();
			addChild(_msk);

			_win.mask = _msk;

			var _w1:Sprite = new rawXOff();
			_win.addChild(_w1);
			_w1.addEventListener(MouseEvent.CLICK, closeThis);
			_w1.buttonMode = true;
			_w1.useHandCursor = true;

			_w1.x = _win.width-50;
			_w1.y = 15;

			singleLine(_win, "UYARI", 280, "AirSansBold", 0xffffff, 24, 35, 50);
			singleLine(_win, this._msg, 280, "AirSans", 0xffffff, 15, 35, 130);

			if(this._buttonT != ""){
				_biOK = new UIButton(_win,  120, 190, this._buttonT, 'button', closeThis);
			}
		}

		private function closeThis(e:MouseEvent) :void
		{
			dispatchEvent(new Event('CLOSE_ME'));
		}
	}
}
