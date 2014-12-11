package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;

	import com.obsesif.ui.UIFactory;
	import com.obsesif.ui.UIInputText;
	import com.bit101.components.Slider;
	import com.obsesif.events.impEvent;

	public class UIAlertPassword extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="winB")]
      private var rawWin:Class;
      [Embed(source="/assets/UIElements.swf", symbol="xoff")]
      private var rawXOff:Class;

		private var _win:Sprite;
		private var _msk:Shape;
		private var _timer:Timer;
		private var _biOK:UIButton;
		public var _nrPass:UIInputText;
		public var _rid:Number;

		public function UIAlertPassword(parent:DisplayObjectContainer, xpos:Number, ypos:Number, roomId:Number) :void
		{
			this._rid = roomId;
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
			singleLine(_win, "Girmek istediğiniz oda, şifrelidir. Şifreniz varsa aşağıya yazarak girebilirsiniz.", 280, "AirSans", 0xffffff, 14, 35, 130);

			_nrPass = new UIInputText(_win, 110, 180, "", null, new TextFormat("AirSans", 18, 0x000000), 120, 24, 0xffffff);
			_nrPass.password = true;

			_biOK = new UIButton(_win,  110, 220, "odaya gir", 'button', closeThis);
		}

		private function closeThis(e:MouseEvent) :void
		{
			dispatchEvent(new impEvent('CLOSE_ME', {id: this._rid, pass: _nrPass.text}));
		}
	}
}
