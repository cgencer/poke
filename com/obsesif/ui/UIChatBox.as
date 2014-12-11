package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.ui.Keyboard;

	import com.obsesif.ui.UIFactory;
	import com.obsesif.ui.UIInputText;
	import com.obsesif.ui.UIButton;
	import com.bit101.components.Slider;
	import com.obsesif.events.impEvent;

	public class UIChatBox extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="windowChat")]
      private var rawChat:Class;
      [Embed(source="/assets/UIElements.swf", symbol="keysoff")]
		private var rawMute:Class;
      [Embed(source="/assets/UIElements.swf", symbol="keysoffd")]
		private var rawMuted:Class;

		private var _oldMsg:String;

		private var _cb:Sprite;
		private var _spr:Sprite;
		private var _msk:Shape;
		private var _slider:Slider;
		private var _btn:UIButton;
		private var _input:UIInputText;
		private var _p:String;
		private var _mute:Sprite;
		private var _muteon:Sprite;
		private var _muteoff:Sprite;
		private var _mhidden:Sprite;
		private var _muteSelected:Boolean = false;
		private var _muted:Boolean = false;
		public var _fsWarn:Sprite;

		public function UIChatBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, part:String='LOBBY', muted:Boolean=false) :void
		{
			this._p = part;
			this._muted = muted;
			super(parent, xpos, ypos);
		}

		override protected function init():void { super.init(); }

		override protected function addChildren() :void
		{
			_cb = new rawChat();
			addChild(_cb);

			_input = new UIInputText(this, 4, 32, "", function(e:Event):void{}, new TextFormat("AirSans", 12, 0x000000));
			_input.setSize(246, 22);
			_input.addEventListener(KeyboardEvent.KEY_UP, kbHandler);


			_fsWarn = new Sprite();
			_fsWarn.x = 6;
			_fsWarn.y = 36;
			addChild(_fsWarn);
			singleLine(_fsWarn, 'Sohbet tam ekranda çalışmamaktadır',200, 'AirSans', 0x333333, 9.5, 0, 0);
			_fsWarn.visible = false;
			
			var _send:UIButton = new UIButton(this,  178, 34, "Gönder", 'send', sendMsg, 1.3, 1.3, 0, new TextFormat("AirSans", 10, 0xffffff), 'input');


			_slider = new Slider(Slider.VERTICAL, this);
			_slider.setSize(10, 123);
			_slider.x = 239;
			_slider.y = 53;
			_slider.alpha = 0.5;

			singleLine(this, "Sohbet", 140, "AirSans", 0xffffff, 15, 45 + 50, 4);

			_spr = new Sprite();
			_spr.x = 10;
			_spr.y = 55;
			addChild(_spr);

			_msk = new Shape();
			_msk.x = 10;
			_msk.y = 55;
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, 230, 120);
			_msk.graphics.endFill();
			addChild(_msk);

			_spr.mask = _msk;

			_slider.minimum = 0;
			_slider.maximum = 120;
			_slider.value = 0;
			_slider.visible = false;
			_slider.addEventListener(Event.CHANGE, function(e:Event):void{sliderScroll(_slider, _spr);});

			_mute = new Sprite();
			addChild(_mute);
			_mute.x = 116;
			_mute.y = 2;
			_mute.scaleX = .6;
			_mute.scaleY = .7;

			_muteon = new rawMuted();
			_mute.addChild(_muteon);
			_muteoff = new rawMute();
			_mute.addChild(_muteoff);
			_mhidden = new Sprite();
			_mute.addChild(_mhidden);
			_mhidden.graphics.beginFill(0xff0000);
			_mhidden.graphics.drawRect(0,0,50,28);
			_mhidden.graphics.endFill();
			_mhidden.alpha = 0;
			_mute.buttonMode = true;
			_mute.useHandCursor = true;
//			_mute.addEventListener(MouseEvent.CLICK, muter);
_muteoff.visible = false;
_muteon.visible = false;
		}

		private function muter(e:Event):void
		{
			_muteSelected = !_muteSelected;

			if(_muteSelected){
				_muteoff.visible = false;
				e.target.parent.parent.parent.dispatchEvent(new impEvent('MUTE_CHATBOX', {muted: 1}));
			}else{
				_muteoff.visible = true;
				e.target.parent.parent.parent.dispatchEvent(new impEvent('MUTE_CHATBOX', {muted: 0}));
			}
		}

		public function addContent(c:String, t:String, s:Number) :void
		{
			//main.log.info('##cb addcontent:' + c + ' ' + t);	
			var fc:uint;
			switch(t){
				case 'private':	fc = 0xaa0000;	break;
				case 'admin':		fc = 0x0000aa;	break;
				case 'public':
				default:				fc = 0xffffff;	break;
			}
			var oldSize:Number = _spr.height;
//			writeLine(_spr, {labels: c, ypos:_spr.height-2}, {color: fc, size: 10});
			/*
			var sender:Number = main._table.getPlayerIndex(s);
			*/
			//main.log.info('## UserIdx: ' + s)
			var message:Array = c.split(':!#');
			var colours:Array = new Array(0xcccccc, 0xfff799, 0xa3d39c, 0x7accc8, 0x8393ca, 0xa186b, 0xf49ac1, 0x8dc63f, 0x0072bc, 0xf26522);
			var cl:uint = (s != -1) ? colours[s] : 0xffffff;
			var tn:TextField = singleLine2(_spr, message[0] + ':', "AirSans", cl, 11, 0, _spr.height);
			var tt:TextField = singleLine(_spr, message[1], 230 - tn.width, "AirSans", 0xffffff, 11, tn.width, _spr.height - tn.height);
			//main.log.info('##hgt: ' + _spr.height + '##hgt2: ' + tt.height);
			if(_spr.height>120) _spr.y = 120 - (oldSize + tt.height) + 55;

			//_slider.minimum = (-(_spr.height-100-50) > 0)? 145.7 - _spr.height : -(_spr.height-100-50);
			_slider.minimum = 120 - (oldSize + tt.height) + 55;
			_slider.maximum = 55;
			_slider.value = -(_spr.height-120);
 			_slider.visible = (_spr.height>120) ? true : false;
			//main.log.info('min: ' + _slider.minimum + 'max: ' + _slider.maximum + 'val: ' + _slider.value + 'spr h: ' + _spr.height)
		}

		private function kbHandler(e:KeyboardEvent) :void
		{
			if (e.keyCode === Keyboard.ENTER){
				sendMsg(null);
			}
		}

		private function sendMsg(e:MouseEvent) :void
		{
			var msg:String = _input.text;
			if(msg != _oldMsg && msg != ""){
//				if(!this._muted){
//					_muteoff.visible = true;
					dispatchEvent(new impEvent('MESSAGE', {target: 'right', screen: this._p, message: msg}));
					_oldMsg = msg;
//				}else{
//					_muteoff.visible = false;
//				}
			}
			clearInput();
		}

		public function clearInput() :void { _input.text = ""; }
		private function sliderScroll(s:Slider, l:Sprite):void {
			//main.log.info('Slider value:' + s.value);
			l.y = s.value;
		}

	}
}
