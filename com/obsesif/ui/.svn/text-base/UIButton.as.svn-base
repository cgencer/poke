package com.obsesif.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.filters.ColorMatrixFilter;
	import flash.events.Event;

	import com.obsesif.ui.UIFactory;

	public class UIButton extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="button")]
      private var rawButton:Class;
	  [Embed(source="/assets/UIElements.swf", symbol="inputButton")]
      private var inputButton:Class;

		[Embed(source="/assets/AIRSANB.TTF", fontName="AirSansBold", mimeType="application/x-font")]
		private var AirSansBold:Class;

		private var _timerShape:Sprite;
		private var _timerMask:Sprite;
		private var _button:Sprite;
		private var _label:TextField;
		private var _title:String = "";
		private var _description:String = "";
		private var _tf:TextFormat;
		private var _x:Number;
		private var _y:Number;
		private var _scalex:Number;
		private var _scaley:Number;
		private var _shifty:Number;
		private var _over:Boolean = false;
		private var _down:Boolean = false;
		private var _selected:Boolean = false;
		private var _toggle:Boolean = false;
		private var _timerMode:Boolean = false;
		private var _colorize:uint;
		private var _btype:String;

		public function UIButton(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, title:String="", description:String="", handler:Function = null, sx:Number=1, sy:Number=1, shy:Number=0, tf:TextFormat=null, btype:String='n', timerMode:Boolean=false, colorize:uint=0) :void
		{
			this._btype = btype;
			this._title = title;
			this._description = description;
			this._x = xpos;
			this._y = ypos;
			this._scalex = sx;
			this._scaley = sy;
			this._shifty = shy;
			this._timerMode = timerMode;
			this._colorize = colorize;
			if(tf==null){
				var format:TextFormat = new TextFormat();
				format.font = "AirSansBold";
				format.color = 0xFFFFFF;
				format.size = 20;
				this._tf = format;
			}else{
				this._tf = tf;
			}

			super(parent, xpos, ypos);
			if(handler != null)	addEventListener(MouseEvent.CLICK, handler, false, 0, true);
		}

		public function show():void
		{
			buttonMode = true;
			visible = true;
			useHandCursor = true;
		}

		public function hide():void
		{
			buttonMode = false;
			visible = false;
			useHandCursor = false;

		}

		override protected function init():void
		{
			super.init();
			this.show();
		}

		override protected function addChildren() :void
		{
			if(this._timerMode)
			{
				_timerShape = new Sprite();
				addChild(_timerShape);
//				_timerMask = new Sprite();
//				addChild(_timerMask);
//				_timerShape.mask = _timerMask;
			}
			var _on:Sprite;
			if(this._btype == 'n') {
				_on = new rawButton();
			} else {
				_on = new inputButton();
			}
			addChild(_on);

			if(this._colorize & 0x00f) applyBlue(_on);
			if(this._colorize & 0x0f0) applyGreen(_on);
			if(this._colorize & 0xf00) applyRed(_on);

			_on.scaleX = this._scalex;
			_on.scaleY = this._scaley;
			_on.name = "on";

			if(this._timerMode)
			{
				_timerShape.graphics.beginFill(0xff0000);
				_timerShape.graphics.drawRoundRect(0, 0, _on.width, _on.height, 20);
				_timerShape.graphics.endFill();
				_timerShape.scaleX = this._scalex + 0.1;
				_timerShape.scaleY = this._scaley + 0.3;
				_timerShape.x = _on.x-((_timerShape.width-_on.width)/2);
				_timerShape.y = _on.y-((_timerShape.height-_on.height)/2);

				_timerShape.graphics.drawRoundRect(0, 0, _on.width, _on.height, 20);
			}

			_label = new TextField();
			_label.width = _on.width;
			_label.embedFonts = true;
			_label.autoSize = 'center';
			_label.antiAliasType = AntiAliasType.ADVANCED;
			_label.defaultTextFormat = this._tf;
			_label.text = this._title;
			addChild(_label);
			_label.y = this._shifty;

			var _hidden:Sprite = new Sprite();
			addChild(_hidden);
			_hidden.alpha = 0;
			_hidden.graphics.beginFill(0xff0000);
			_hidden.graphics.drawRect(0, 0, _on.width, _on.height);
			_hidden.graphics.endFill();

			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
		}

		private function onMouseOver(event:MouseEvent):void
		{
			_over = true;
			_button.getChildByName('out').alpha = 0;
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
		}

		private function onMouseOut(event:MouseEvent):void
		{
			_over = false;
			_button.getChildByName('out').alpha = 0;
		}

		private function onMouseDown(event:MouseEvent):void
		{
			_down = true;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
		}

		private function onMouseUp(event:MouseEvent):void
		{
			if(_toggle  && _over)
			{
				_selected = !_selected;
			}
			_down = _selected;
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		private function applyRed(child:DisplayObject):void {
			var matrix:Array = new Array();
			matrix = matrix.concat([1, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 1, 0]);
			applyFilter(child, matrix);
		}

		private function applyBlue(child:DisplayObject):void {
			var matrix:Array = new Array();
			matrix = matrix.concat([0, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 1, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 1, 0]);
			applyFilter(child, matrix);
		}

		private function applyGreen(child:DisplayObject):void {
			var matrix:Array = new Array();
			matrix = matrix.concat([0, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 1, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 1, 0]);
			applyFilter(child, matrix);
		}

		private function applyFilter(child:DisplayObject, matrix:Array):void {
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			var filters:Array = new Array();
			filters.push(filter);
			child.filters = filters;
		}

		public function set label(str:String):void			{	_title = str; _label.text = str;draw();}
		public function get label():String						{	return _title;		}
		public function set toggle(value:Boolean) :void		{	_toggle = value;	}
		public function get toggle():Boolean					{	return _toggle;	}
		public function set desc(i:String) :void				{	_description = i;	}
		public function get desc():String						{	return _description;	}

	}
}

