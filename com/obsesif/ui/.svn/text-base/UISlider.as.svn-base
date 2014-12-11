package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;

	import br.com.stimuli.string.printf;
	import com.obsesif.ui.UIFactory;
	import com.obsesif.game.PlayHand;
	import com.bit101.components.RadioButton;

	public class UISlider extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="raiser")]
		private var rawRaiser:Class;
      [Embed(source="/assets/UIElements.swf", symbol="raiser_ok")]
		private var rawRaiserOK:Class;
      [Embed(source="/assets/UIElements.swf", symbol="raiser_ko")]
		private var rawRaiserKO:Class;

		private var _p:Sprite;
		private var _rz:Sprite;
		private var _rzOK:Sprite;
		private var _rzKO:Sprite;
		private var _rzOKB:Sprite;
		private var _rzKOB:Sprite;
		private var _ulabel:TextField = new TextField();
		private var _label:TextField = new TextField();
		private var _raised:Boolean = false;
		private var _autoCallR:RadioButton;
		private var _autoFoldR:RadioButton;
		private var _autoCall:Boolean = false;
		private var _autoFold:Boolean = false;

		protected var _handle:Sprite;
		protected var _oldValue:Number = 0;
		protected var _value:Number = 0;
		protected var _max:Number = 100;
		protected var _min:Number = 0;

		public var isAllIn:Boolean = false;

		public function UISlider(parent:Sprite, xpos:Number, ypos:Number)
		{
			super(parent, xpos-200, ypos-60);
		}

		override protected function init():void
		{
			super.init();
			setSize(175, 10);
		}

		override protected function addChildren():void
		{
			_rz = new rawRaiser();
			addChild(_rz);

			_autoFoldR = new RadioButton(_rz, 30, 90, "AutoFold", false, afClicked);
			_autoCallR = new RadioButton(_rz, 325, 90, "AutoCall", false, acClicked);

			_rzKO = new rawRaiserKO();
			_rz.addChild(_rzKO);
			_rzKO.x = 29;
			_rzKO.y = 42.1;
			_rzKO.alpha = 0;

			_rzKOB = new Sprite();
			_rz.addChild(_rzKOB);
			_rzKOB.x = 29;
			_rzKOB.y = 42.1;
			_rzKOB.graphics.beginFill(0xff0000);
			_rzKOB.graphics.drawRect(0, 0, _rzKO.width, _rzKO.height);
			_rzKOB.graphics.endFill();
			_rzKOB.alpha = 0;
			_rzKOB.addEventListener(MouseEvent.ROLL_OVER, function(e:MouseEvent):void{_rzKO.alpha=1;});
			_rzKOB.addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void{_rzKO.alpha=0;});
			_rzKOB.addEventListener(MouseEvent.CLICK, function(e:Event):void{clickOn(false);});

			_rzOK = new rawRaiserOK();
			_rz.addChild(_rzOK);
			_rzOK.x = 326.9;
			_rzOK.y = 42;
			_rzOK.alpha = 0;

			_rzOKB = new Sprite();
			_rz.addChild(_rzOKB);
			_rzOKB.x = 326.9;
			_rzOKB.y = 42;
			_rzOKB.graphics.beginFill(0xff0000);
			_rzOKB.graphics.drawRect(0, 0, _rzOK.width, _rzOK.height);
			_rzOKB.graphics.endFill();
			_rzOKB.alpha = 0;
			_rzOKB.addEventListener(MouseEvent.ROLL_OVER, function(e:MouseEvent):void{_rzOK.alpha=1;});
			_rzOKB.addEventListener(MouseEvent.ROLL_OUT, function(e:MouseEvent):void{_rzOK.alpha=0;});
			_rzOKB.addEventListener(MouseEvent.CLICK, function(e:Event):void{clickOn(true);});

			_p = new Sprite();
			addChild(_p);
			_p.x = 115;
			_p.y = 87;

			_handle = new Sprite();
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			_handle.buttonMode = true;
			_handle.useHandCursor = true;
			_p.addChild(_handle);
			_handle.alpha = .5;

			// uper text (xxx to Call)
			var format:TextFormat = new TextFormat();
			format.font = "AirSans";
			format.color = 0xffffff;
			format.size = 20;
			format.align = TextFormatAlign.CENTER;

			_ulabel.width = 200;
			_ulabel.embedFonts = true;
			_ulabel.autoSize = 'left';
			_ulabel.antiAliasType = AntiAliasType.ADVANCED;
			_ulabel.defaultTextFormat = format;
			_ulabel.text = String(2500)+" to Call";
			_ulabel.selectable = false;
			_ulabel.x = 145;
			_ulabel.y = 14;
			_rz.addChild(_ulabel);

			//Slider value display
			format = new TextFormat();
			format.font = "AirSans";
			format.color = 0xffffff;
			format.size = 24;
			format.align = TextFormatAlign.CENTER;

			_label.width = 200;
			_label.embedFonts = true;
			_label.autoSize = 'left';
			_label.antiAliasType = AntiAliasType.ADVANCED;
			_label.defaultTextFormat = format;
			_label.text = "00000000";
			_label.selectable = false;
			_label.x = 145;
			_label.y = 45;
			_rz.addChild(_label);
		}

		private function acClicked(e:Event):void
		{
			if(_autoCallR.selected){
				dispatchEvent(new Event('AUTO_CALL'));
				this._autoCall = true;
				//dispatchEvent(new Event('TURN_CALL'));
				dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'call'}));
			}
		}

		private function afClicked(e:Event):void
		{
			if(_autoFoldR.selected){
				dispatchEvent(new Event('AUTO_FOLD'));
				this._autoFold = true;
				dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'fold'}));
			}
		}

		private function clickOn(bx:Boolean):void
		{
			if(!bx){
				// flush
				//main.log.info('its a flush');
				dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'fold'}));
			}else{
				if(!this._raised){
					// call
					//main.log.info('its a call');
					dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'call'}));
				}else{
					//raise
					//main.log.info('its a raise');
					dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'raise'}));
				}
			}
		}

		public function toCall(n:Number):void
		{
			_ulabel.text = String(n)+" to Call";
		}

		protected function drawHandle():void
		{
			_handle.graphics.clear();
			_handle.graphics.beginFill(0xffffff);
			_handle.graphics.drawRect(1, 1, _height - 2, _height - 2);
			_handle.graphics.endFill();
			positionHandle();
		}

		private function correctValue():void
		{
			if(_max > _min)
			{
				_value = Math.min(_value, _max);
				_value = Math.max(_value, _min);
			} else {
				_value = Math.max(_value, _max);
				_value = Math.min(_value, _min);
			}
		}

		protected function positionHandle():void
		{
			var range:Number;
			range = width - height;
			_handle.x = (_value - _min) / (_max - _min) * range;
		}

		override public function draw():void
		{
			super.draw();
			drawHandle();
		}

		public function setSliderParams(min:Number, max:Number, value:Number):void
		{
			this.minimum = min;
			this.maximum = max;
			this.value = value;
		}

		protected function onDrag(event:MouseEvent):void
		{
			//main.log.info('drag started');
			dispatchEvent(new Event('AUTO_STOP'));
			this._autoCall = false;
			this._autoFold = false;
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			_handle.startDrag(false, new Rectangle(0, 0, width - height, 0));
		}

		protected function onDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			stopDrag();
		}

		protected function onSlide(event:MouseEvent):void
		{
			var oldValue:Number = _value;
			var md:int;
			_value = _handle.x / (width - height) * (_max - _min) + _min;
			md = _value % 5;
			_value = _value - md;
			//main.log.info('Deger: '+ Math.floor(_value));
			//main.log.info('handle.x: '+ _handle.x + '|width-height: ' + width + '-'  + height);
			if(_value != oldValue)
			{
				_label.text = String( printf('%08d', Math.floor(_value)) );
				dispatchEvent(new Event(Event.CHANGE));
			}
			if(_value > oldValue)
			{
				_raised = true;
			}
		}

		public function set value(v:Number):void // Text printer
		{
			_value = v;
			correctValue();
			positionHandle();
				_label.text = String( printf('%08d', Math.floor(v)) );
			if(this.isAllIn) {
				_ulabel.text = 'All In!';
			} else {
				_ulabel.text = String(v) + " to Call";
			}
		}

		public function set maximum(m:Number):void
		{
			_max = m;
			correctValue();
			positionHandle();
		}

		public function set minimum(m:Number):void
		{
			_min = m;
			correctValue();
			positionHandle();
		}

		public function get autoCall() :Boolean { return _autoCall; }
		public function get autoFold() :Boolean { return _autoFold; }
		public function get value() :Number { return _value; }
		public function get minimum() :Number { return _min; }
		public function get maximum() :Number { return _max; }
	}
}
