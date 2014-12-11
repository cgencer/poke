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
	import com.bit101.components.CheckBox;
	import com.bit101.components.Slider;
	import com.obsesif.events.impEvent;

	public class UIGSlider extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="razor")]
      private var rawRazor:Class;
      [Embed(source="/assets/UIElements.swf", symbol="razorB1")]
      private var rawRazorA:Class;
      [Embed(source="/assets/UIElements.swf", symbol="razorB2")]
      private var rawRazorB:Class;
      [Embed(source="/assets/UIElements.swf", symbol="razorB3")]
      private var rawRazorC:Class;
      [Embed(source="/assets/UIElements.swf", symbol="mute")]
		private var rawMute:Class;
      [Embed(source="/assets/UIElements.swf", symbol="muted")]
		private var rawMuted:Class;
      [Embed(source="/assets/UIElements.swf", symbol="handle")]
		private var rawHandle:Class;

		private var _p:Sprite;
		private var _rz:Sprite;
		private var _con:Sprite;
		private var _rzCheck:Sprite;
		private var _rzCheckA:Sprite;
		private var _rzCheckB:Sprite;
		private var _rzCheckC:CheckBox;
		private var _rzCall:Sprite;
		private var _rzCallA:Sprite;
		private var _rzCallB:Sprite;
		private var _rzCallC:CheckBox;
		private var _rzFold:Sprite;
		private var _rzFoldA:Sprite;
		private var _rzFoldB:Sprite;
		private var _rzFoldC:CheckBox;
		private var _rzCallAny:Sprite;
		private var _rzCallAnyA:Sprite;
		private var _rzCallAnyB:Sprite;
		private var _rzCallAnyC:CheckBox;
		private var _rzCheckFold:Sprite;
		private var _rzCheckFoldA:Sprite;
		private var _rzCheckFoldB:Sprite;
		private var _rzCheckFoldC:CheckBox;
		private var _rzRaiseDisplay:Sprite;
		private var _rzRaisePlus:Sprite;
		private var _rzRaiseMinus:Sprite;
		private var _rzSlider:Slider;
		private var _rzRaise12:Sprite;
		private var _rzRaise12A:Sprite;
		private var _rzRaise12B:Sprite;
		private var _rzRaise34:Sprite;
		private var _rzRaise34A:Sprite;
		private var _rzRaise34B:Sprite;
		private var _rzAllIn:Sprite;
		private var _rzAllInA:Sprite;
		private var _rzAllInB:Sprite;
		private var _tf12:TextField;
		private var _tf34:TextField;
		private var _tfCall:TextField;
		private var _mute:Sprite;
		private var _muteon:Sprite;
		private var _muteoff:Sprite;
		private var _mhidden:Sprite;
		private var _label:TextField = new TextField();
		private var _muteSelected:Boolean = true;
		public var _checkboxInstances:Array = [];

		protected var _handle:Sprite;
		protected var _oldValue:Number = 0;
		protected var _value:Number = 0;
		protected var _max:Number = 100;
		protected var _min:Number = 0;
		protected var _toCall:Number = 0;

		public var isAllIn:Boolean = false;

		public function UIGSlider(parent:Sprite, xpos:Number, ypos:Number)
		{
			super(parent, xpos, ypos);
		}

		override protected function init():void
		{
			super.init();
			setSize(220, 10);
		}

		override protected function addChildren():void
		{
			_rz = new rawRazor();
			addChild(_rz);

			//===================================== CHECK button
			_rzCheck = new Sprite();
			_rzCheck.x = 13;
			_rzCheck.y = 10;
				_rzCheckA = new rawRazorA();
				_rzCheck.addChild(_rzCheckA);
				singleLine(_rzCheck, "CHECK", 76, 'AirSans', 0xffffff, 10, 20, 0);

				_rzCheckC = new CheckBox(_rzCheck, 3, 1, '', function(e:MouseEvent):void {
					dispatchEvent(new impEvent("AUTO_TOGGLE", {action: 'check'}));
				}, 0.8); // AutoCheck Event Handling

				_rzCheckB = new Sprite();
				_rzCheck.addChild(_rzCheckB);
				_rzCheckB.x = 25;
				_rzCheckB.buttonMode = true;
				_rzCheckB.useHandCursor = true;
				_rzCheckB.graphics.beginFill(0xff0000);
				_rzCheckB.graphics.drawRect(0, 0, 75, 18);
				_rzCheckB.graphics.endFill();
				_rzCheckB.alpha = 0;
				_rzCheckB.addEventListener(MouseEvent.CLICK, function(e:Event):void{
					dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'check'}));
				});
			addChild(_rzCheck);

			//===================================== FOLD button
			_rzFold = new Sprite();
			_rzFold.x = 94;
			_rzFold.y = 10;
				_rzFoldA = new rawRazorA();
				_rzFold.addChild(_rzFoldA);
				singleLine(_rzFold, "FOLD", 76, 'AirSans', 0xffffff, 10, 27, 0);

				_rzFoldC = new CheckBox(_rzFold, 3, 4, '', function(e:MouseEvent):void {
					dispatchEvent(new impEvent("AUTO_TOGGLE", {action: 'fold'}));
				}, 0.8); 	// AutoFold Event Handling

				_rzFoldB = new Sprite();
				_rzFold.addChild(_rzFoldB);
				_rzFoldB.buttonMode = true;
				_rzFoldB.useHandCursor = true;
				_rzFoldB.x = 10;
				_rzFoldB.graphics.beginFill(0xff0000);
				_rzFoldB.graphics.drawRect(0, 0, 65, 18);
				_rzFoldB.graphics.endFill();
				_rzFoldB.alpha = 0;
				_rzFoldB.addEventListener(MouseEvent.CLICK, function(e:Event):void{
					dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'fold'}));
				});
			addChild(_rzFold);

			//===================================== CALL button
			_rzCall = new Sprite();
//			_rzCall.x = 235;
			_rzCall.x = 13;
			_rzCall.y = 10;
				_rzCallA = new rawRazorA();
				_rzCall.addChild(_rzCallA);
				_tfCall = singleLine(_rzCall, "CALL", 76, 'AirSans', 0xffffff, 10, 14, 0);

				_rzCallC = new CheckBox(_rzCall, 3, 2, '', function(e:MouseEvent):void {
					dispatchEvent(new impEvent("AUTO_TOGGLE", {action: 'call'}));
				}, 0.8); 	// AutoFold Event Handling

				_rzCallB = new Sprite();
				_rzCall.addChild(_rzCallB);
				_rzCallB.x = 10;
				_rzCallB.buttonMode = true;
				_rzCallB.useHandCursor = true;
				_rzCallB.graphics.beginFill(0xff0000);
				_rzCallB.graphics.drawRect(0, 0, 65, 18);
				_rzCallB.graphics.endFill();
				_rzCallB.alpha = 0;
				_rzCallB.addEventListener(MouseEvent.CLICK, function(e:Event):void{
					dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'call'}));
				});
			addChild(_rzCall);

			//===================================== RAISE Button
			_rzRaiseDisplay = new rawRazorB();
			_rzRaiseDisplay.buttonMode = true;
			_rzRaiseDisplay.useHandCursor = true;
			_rzRaiseDisplay.x = 180;
			_rzRaiseDisplay.y = 1000;
			_rzRaiseDisplay.scaleX = 0.7;
			_rzRaiseDisplay.scaleY = 0.7;
			_rzRaiseDisplay.addEventListener(MouseEvent.CLICK, function(e:Event):void{
					clickOn();
			});
			addChild(_rzRaiseDisplay);

			//===================================== CALL ANY button
			_rzCallAny = new Sprite();
			_rzCallAny.x = 175;
			_rzCallAny.y = 10;
				_rzCallAnyA = new rawRazorA();
				_rzCallAny.addChild(_rzCallAnyA);
				singleLine(_rzCallAny, "CALL ANY", 76, 'AirSans', 0xffffff, 10, 14, 0);
				_rzCallAnyC = new CheckBox(_rzCallAny, 3, 4, '', null, 0.8);
				_rzCallAnyB = new Sprite();
				_rzCallAny.addChild(_rzCallAnyB);
				_rzCallAnyB.buttonMode = true;
				_rzCallAnyB.useHandCursor = true;
				_rzCallAnyB.graphics.beginFill(0xff0000);
				_rzCallAnyB.graphics.drawRect(0, 0, 75, 18);
				_rzCallAnyB.graphics.endFill();
				_rzCallAnyB.alpha = 0;

				_rzCallAnyB.addEventListener(MouseEvent.CLICK, function(e:Event):void{
					var ns:Boolean = !_rzCallAnyC.selected;
					uncheckBoxes();
					_rzCallAnyC.selected = ns;
					dispatchEvent(new impEvent("AUTO_TOGGLE", {action: 'call'}));
				});

			addChild(_rzCallAny);
			_rzCallAny.y = 1000;

			//===================================== CHECK/FOLD button
			_rzCheckFold = new Sprite();
			_rzCheckFold.x = 255;
			_rzCheckFold.y = 10;
				_rzCheckFoldA = new rawRazorA();
				_rzCheckFold.addChild(_rzCheckFoldA);
				singleLine(_rzCheckFold, "CHECK/FOLD", 76, 'AirSans', 0xffffff, 10 , 10, 0);

				_rzCheckFoldC = new CheckBox(_rzCheckFold, 3, 4, '', null, 0.8);
				_rzCheckFoldB = new Sprite();
				_rzCheckFold.addChild(_rzCheckFoldB);
				_rzCheckFoldB.buttonMode = true;
				_rzCheckFoldB.useHandCursor = true;
				_rzCheckFoldB.graphics.beginFill(0xff0000);
				_rzCheckFoldB.graphics.drawRect(0, 0, 75, 18);
				_rzCheckFoldB.graphics.endFill();
				_rzCheckFoldB.alpha = 0;

				_rzCheckFoldB.addEventListener(MouseEvent.CLICK, function(e:Event):void{
					var ns:Boolean = !_rzCheckFoldC.selected;
					uncheckBoxes();
					_rzCheckFoldC.selected = ns;
					dispatchEvent(new impEvent("AUTO_TOGGLE", {action: 'checkfold'}));
				});

			addChild(_rzCheckFold);
			_rzCheckFold.y = 1000;

			_rzRaiseMinus = new rawRazorC();
			_rzRaiseMinus.x = 10;
			_rzRaiseMinus.y = 45;
			_rzRaiseMinus.buttonMode = true;
			addChild(_rzRaiseMinus);
			singleLine(_rzRaiseMinus, "-", 100, 'AirSansBold', 0x0, 18, 14, -4);
			_rzRaiseMinus.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				if(_value - 5 >= _min) {
					_value = rounder(Math.floor(_value - 5));
/*
//CG: Overflow-Control
					if(Number(_value) < 0){_rzRaiseDisplay.y = 1000;}
*/
					_rzRaiseDisplay.y = 70;
					_label.text = 'RAISE '+(Math.floor(rounder(_value + _toCall)));
					//main.log.info('New Value: ' +  _value);
					positionHandle();
				}
			});



			_rzRaisePlus = new rawRazorC();
			_rzRaisePlus.x = 300;
			_rzRaisePlus.y = 45;
			_rzRaisePlus.buttonMode = true;
			addChild(_rzRaisePlus);
			singleLine(_rzRaisePlus, "+", 100, 'AirSansBold', 0x0, 18, 10, -4);
			_rzRaisePlus.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				if(_value + 5 <= _max) {
					_value = Math.floor(_value + 5);
/*
//CG: Overflow-Control
			if(Number(_value) > Number(main._me['useableCash'])){_rzRaiseDisplay.y = 1000;}
*/
					_rzRaiseDisplay.y = 70;
					_label.text = 'RAISE '+ (Math.floor(rounder(_value + _toCall)));
					//main.log.info('New Value: ' +  _value);
					positionHandle();
				}
			});

			//===================================== ALLIN button
			_rzAllIn = new Sprite();
			_rzAllIn.x = 258;
			_rzAllIn.y = 10;
				_rzAllInA = new rawRazorA();
				_rzAllIn.addChild(_rzAllInA);
				singleLine(_rzAllIn, "ALL IN", 76, 'AirSans', 0xffffff, 10, 20, 0);

				_rzAllInB = new Sprite();
				_rzAllIn.addChild(_rzAllInB);
				_rzAllInB.buttonMode = true;
				_rzAllInB.useHandCursor = true;
				_rzAllInB.graphics.beginFill(0xff0000);
				_rzAllInB.graphics.drawRect(0, 0, 76, 18);
				_rzAllInB.graphics.endFill();
				_rzAllInB.alpha = 0;
				_rzAllInB.addEventListener(MouseEvent.CLICK, function(e:Event):void{
					uncheckBoxes();
					dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'allin'}));
				});
			addChild(_rzAllIn);

			_mute = new Sprite();
			addChild(_mute);
			_mute.x = 10;
			_mute.y = 70;
			_mute.scaleX = 0.5;
			_mute.scaleY = 0.5;
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
			_mute.addEventListener(MouseEvent.CLICK, muter);

			var format:TextFormat = new TextFormat();
			format.font = "AirSans";
			format.color = 0xffffff;
			format.size = 16;
			format.align = TextFormatAlign.CENTER;

			_label.width = 200;
			_label.embedFonts = true;
			_label.autoSize = 'left';
			_label.antiAliasType = AntiAliasType.ADVANCED;
			_label.defaultTextFormat = format;
			_label.text = 'RAISE: '+"00000000";
			_label.selectable = false;
			_label.x = 50;
			_label.y = 1;
			_rzRaiseDisplay.addChild(_label);

			_con = new Sprite();
			addChild(_con);
			_con.x = 50;
			_con.y = 45;

			_con.graphics.clear();
			_con.graphics.lineStyle(2,0);
			_con.graphics.moveTo(5,10);
			_con.graphics.lineTo(240,10);
			_con.graphics.endFill();

			_handle = new rawHandle();
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			_handle.buttonMode = true;
			_handle.useHandCursor = true;
			_con.addChild(_handle);

			//===================================== RAISE(1-2) button
			_rzRaise12 = new Sprite();
			_rzRaise12.x = 172;
			_rzRaise12.y = 1000;
				_rzRaise12A = new rawRazorA();
				_rzRaise12.addChild(_rzRaise12A);
				_tf12 = singleLine(_rzRaise12, "RAISE ", 76, 'AirSans', 0xffffff, 10, 20, 0);

				_rzRaise12B = new Sprite();
				_rzRaise12.addChild(_rzRaise12B);
				_rzRaise12B.buttonMode = true;
				_rzRaise12B.useHandCursor = true;
				_rzRaise12B.graphics.beginFill(0xff0000);
				_rzRaise12B.graphics.drawRect(0, 0, 100, 22);
				_rzRaise12B.graphics.endFill();
				_rzRaise12B.alpha = 0;
				_rzRaise12B.addEventListener(MouseEvent.CLICK, function(e:Event):void{
					dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action:'raise2', raiser:_min}));
				});
			addChild(_rzRaise12);

			//===================================== RAISE(3-4) button
			_rzRaise34 = new Sprite();
			_rzRaise34.x = 258;
			_rzRaise34.y = 1000;
				_rzRaise34A = new rawRazorA();
				_rzRaise34.addChild(_rzRaise34A);
				_tf34 = singleLine(_rzRaise34, "RAISE ", 76, 'AirSans', 0xffffff, 10, 20, 0);

				_rzRaise34B = new Sprite();
				_rzRaise34.addChild(_rzRaise34B);
				_rzRaise34B.buttonMode = true;
				_rzRaise34B.useHandCursor = true;
				_rzRaise34B.graphics.beginFill(0xff0000);
				_rzRaise34B.graphics.drawRect(0, 0, 100, 22);
				_rzRaise34B.graphics.endFill();
				_rzRaise34B.alpha = 0;
				_rzRaise34B.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
					dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action:'raise2', raiser:_max}));
				});
			addChild(_rzRaise34);

			_tf12.text = "RAISE #1";
			_tf34.text = "RAISE #2";

			this._checkboxInstances = _rzCheckC.instances;
		}

		public function turnMine(callValue:Number, minRaiseValue:Number, maxRaiseValue:Number, maxBetValue:Number, gameType:String, isFirst:Boolean):void {
			var canRaise:Boolean = true;
			var canCall:Boolean = true;
			var canCheck:Boolean = false;
			var canAllIn:Boolean = true;
			var canMaxRaise:Boolean = true;

			this._toCall = callValue;

			if(maxRaiseValue > 0 && gameType == 'Limit') {
/*
FIXME: bu kod tam dogru degil (serverdan gelen maxBetValue dismiss ediliyor)
ama all-in case'inde playhand amount'u duzelttigi icin duzgun calisiyor.
diger case'lerde sorun yaratabilir mi incelemek gerek. -k
*/
				maxBetValue = maxRaiseValue + callValue;
				if(maxBetValue > main._me['useableCash']) {
					canMaxRaise = false;
				}
			}

			if(callValue == 0) { // Check cannot call
				canCheck = true;
				canCall = false;
			}  else {
				canCheck = false;
				canCall = true;
				_tfCall.text = "CALL "+String(rounder(callValue));
			}

			if(main._me['useableCash'] > maxBetValue) {
				//canAllIn = false;
			}

			if(main._me['useableCash'] < (minRaiseValue + callValue)) { //call only cannot raise
				canRaise = false;
			}

			if(main._me['useableCash'] < callValue) { // allin cannot call or raise
				//canCall = false;
				_tfCall.text = "CALL "+String(rounder(main._me['useableCash']));
				canRaise = false;
			}

			if(minRaiseValue > maxBetValue - callValue) {
				canRaise = false;
			}

			//Initial Button Settings
			_rzCallAny.y = 1000;
			_rzCheckFold.y = 1000;
			_rzFoldB.y = 0;

			//Check Button
			_rzCheck.y = (canCheck) ? 10 : 1000;
			_rzCheckB.y = (canCheck) ? 0 : 1000;
			_rzCheckC.y = (canCheck) ? 5 : 1000;

			//Call Button
			_rzCall.y = (canCall) ? 10 : 1000;
			_rzCallB.y = (canCall) ? 0 : 1000;
			_rzCallC.y = (canCall) ? 5 : 1000;

			//Raise Slider / Buttons
			if(gameType == 'Limit') {
				_rzRaise12.y = (canRaise) ? 10 : 1000;
				_rzRaise34.y = (canMaxRaise && minRaiseValue != (maxBetValue - callValue)) ? 10 : 1000;
			} else {
				_rzRaiseMinus.y = (canRaise) ? 45 : 1000;
				_rzRaisePlus.y = (canRaise) ? 45 : 1000;
				_con.y = (canRaise) ? 45 : 1000;
				_rzRaiseDisplay.y = (canRaise && isFirst) ? 70 : 1000;
			}

			//Allin Button
			_rzAllIn.y = (canAllIn) ? 10 : 1000;


			this.minimum = (canRaise) ? minRaiseValue : 0;
			this.maximum = (canRaise) ? maxBetValue - callValue : 0;
			this.value = (canRaise) ? minRaiseValue : 0;

		}

		public function turnOthers():void
		{
			_rzCheckB.y = 0;//tiklanma
			_rzCheck.y = 10;//buton
			_rzCheckC.y = 5//checkbox

			_rzCall.y = 1000;
			_rzCallB.y = 0;
			_rzCallC.y = 5;

			_rzRaiseDisplay.y = 1000;
			_rzCheckFold.y = 10;
			_rzCallAny.y = 10;
			_rzCheckB.y = 1000;
			_rzFoldB.y = 1000;
			_rzAllIn.y = 1000;
			_rzRaiseMinus.y = 1000;
			_rzRaisePlus.y = 1000;
			_con.y = 1000;
			_rzRaise12.y = 1000;
			_rzRaise34.y = 1000;
		}

		public function setSound(enabled:Boolean, dispatch:Boolean = true):void
		{
			_muteSelected = !enabled;

			if(_muteSelected){
				_muteoff.visible = false;
				if (dispatch) dispatchEvent(new Event('SOUND_OFF'));
			}else{
				_muteoff.visible = true;
				if (dispatch) dispatchEvent(new Event('SOUND_ON'));
			}
		}

		private function muter(e:Event):void
		{
		this.setSound(_muteSelected, true);
		}

		private function clickOn():void
		{
		dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'raise'}));
//		dispatchEvent(new PlayHand(PlayHand.COMPLETE, {action: 'raise2', raiser:this.value}));
		}

		protected function drawHandle():void
		{
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
			this.minimum = rounder(min);
			this.maximum = rounder(max);
			this.value = rounder(value);
		}

		public function uncheckBoxes():void
		{
			for(var s:String in this._checkboxInstances){
				(this._checkboxInstances[s] as CheckBox).selected = false;
			}
		}
		protected function onDrag(event:MouseEvent):void
		{
			this.uncheckBoxes();

			dispatchEvent(new impEvent("AUTO_TOGGLE", {action: 'stop'}));
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
			_rzRaiseDisplay.y = 70;
			_value = _handle.x / (width - height) * (_max - _min) + _min;
			md = _value % 5;
			_value = _value - md;
//			main.log.info('Deger: '+ Math.floor(_value));
			//main.log.info('handle.x: '+ _handle.x + '|width-height: ' + width + '-'  + height);
			if(_value != oldValue)
			{
				_label.text = 'RAISE '+ (Math.floor(rounder(_value + this._toCall)));
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		public function set value(v:Number):void // Text printer
		{
			_value = v;
			correctValue();
			positionHandle();
			_label.text = 'RAISE '+(Math.floor(rounder(v + this._toCall)));
		}

		public function set maximum(m:Number):void
		{
			_max = m;
			_tf34.text = "RAISE "+String(rounder(m + this._toCall));
			if(m==0){_rzRaise34.y = 1000;}
//CG: Overflow-Control
if(Number(main._me['useableCash']) < Number(rounder(m + this._toCall))){
	_rzRaise34.y = 1000;
}

			correctValue();
			positionHandle();
		}

		public function set minimum(m:Number):void
		{
			_min = m;
			_tf12.text = "RAISE "+String(rounder(m + this._toCall));
			if(m==0){_rzRaise12.y = 1000;}
//CG: Overflow-Control
if(Number(main._me['useableCash']) < Number(rounder(m + this._toCall))){
	_rzRaise12.y = 1000;
}
			correctValue();
			positionHandle();
		}

		public function get value() :Number { return _value; }
		public function get minimum() :Number { return _min; }
		public function get maximum() :Number { return _max; }
		private function rounder(v:Number) :Number { return(Math.floor(v/5)*5); }
	}
}
