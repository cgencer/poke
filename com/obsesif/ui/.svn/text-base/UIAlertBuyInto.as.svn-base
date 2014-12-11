package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;

	import com.obsesif.ui.UIFactory;
	import com.obsesif.ui.UIInputText;
	import com.bit101.components.Slider;
	import com.obsesif.events.impEvent;

	public class UIAlertBuyInto extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="winB")]
      private var rawWin:Class;

		private var _win:Sprite;
		private var _msk:Shape;
		private var _val:Sprite;

		private var _bis:Slider;
		private var _biAdd:UIButton;
		private var _biCancel:UIButton;
		private var _clck:Timer;

		private var _buyCash:Number = 0;
		private var _minAmount:Number = 0;
		private var _maxAmount:Number = 1000;
		private var _secs:Number;
		private var _visible:Boolean = false;

		public function UIAlertBuyInto(parent:DisplayObjectContainer, xpos:Number, ypos:Number, min:Number=0, max:Number=1000) :void
		{
			this._minAmount = Math.floor(min/5)*5;
			this._maxAmount = Math.floor(max/5)*5;
			super(parent, xpos, ypos);
		}

		override protected function init():void { super.init(); }

		override protected function addChildren() :void
		{
			this.y = 1000;

			_win = new rawWin();
			addChild(_win);

			_msk = new Shape();
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, _win.width, _win.height);
			_msk.graphics.endFill();
			addChild(_msk);

			_win.mask = _msk;

			_bis = new Slider(Slider.HORIZONTAL, this, parent.x+40, parent.y+150, biSlide);
			_bis.setSize(250, 20);
			_bis.setSliderParams(this._minAmount, this._maxAmount, this._minAmount);
			this._buyCash = this._minAmount;

			singleLine(_win, "PARA EKLE:", _win.width-40, 'AirSansBold', 0xffffff, 24, 24, 50);
			var msg:String = "Oyun paranız bitmiştir, oyuna devam etmek için almak istediğiniz miktarı girin:";
			singleLine(_win, msg, 300, 'AirSans', 0xffffff, 14, 20, 90);
			msg = "bu odada en az "+String(this._minAmount)+ " ve en fazla "+String(this._maxAmount)+" çimdik ekleyebilirsiniz.";
			singleLine(_win, msg, 320, 'AirSans', 0xffffff, 11, 20, _bis.y-20);

			_val = new Sprite();
			_win.addChild(_val);
			singleLine(_val, "eklediğiniz miktar: "+String(this._minAmount), _win.width-40, 'AirSans', 0xffffff, 14, 100, 170);

			_biAdd = new UIButton(_win,  40, 200, "ekle (30)", 'button', biAdd);
			_biCancel = new UIButton(_win, 180, 200, "vazgeç", 'button', biCancel);

			_clck = new Timer(1000, 31);
			_clck.addEventListener(TimerEvent.TIMER, this.timeUpdate);
			_clck.addEventListener(TimerEvent.TIMER_COMPLETE, this.timeFin);
		}

		private function timeUpdate(e:TimerEvent) :void
		{
			_biAdd.label = "ekle (" + this._secs-- + ")";
		}
		private function timeFin(e:TimerEvent) :void
		{
			this.hide();
		}
		private function biSlide(e:Event) :void
		{
			if(_val is Sprite) _win.removeChild(_val);
			_val = new Sprite();
			_win.addChild(_val);
			this._buyCash = Math.floor(_bis.value/5)*5;
			singleLine(_val, "eklediğiniz miktar: "+String(this._buyCash), _win.width-40, 'AirSans', 0xffffff, 14, 100, 170);
		}
		private function biAdd(e:Event) :void
		{
			dispatchEvent(new impEvent('BUY_INTO', {amount:this._buyCash}));
			this.hide();
		}
		private function biCancel(e:Event) :void
		{
			dispatchEvent(new impEvent('NO_BUY_INTO'));
			this.hide();
		}
		public function setVals(min:Number, max:Number): void
		{
			this._minAmount = Math.floor(min/5)*5;
			this._maxAmount = Math.floor(max/5)*5;
			this._buyCash = this._minAmount;
			if (_bis) _bis.setSliderParams(this._minAmount, this._maxAmount, this._minAmount);
		}
		public function show() :void
		{
				this._buyCash = this._minAmount;
				this._visible = true;
				_secs = 30;
				this.y = 90;
				_clck.reset();
				_clck.start();
		}
		public function hide() :void
		{
			this._visible = false;
			_clck.stop();
			_clck.reset();
			this.y = 1000;
		}
		public function get buyCash():Number		{ return this._buyCash; }
		public function get minAmount():Number		{ return this._minAmount; }
		public function get maxAmount():Number		{ return this._maxAmount; }
		public function get myvisible():Boolean	{ return this._visible; }
	}
}
