package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.LocalConnection;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;
	import com.jidd.display.DashedLine;
	import com.obsesif.ui.LineMarker;

	public class UIFactory extends Sprite
	{
		[Embed(source="/assets/pf_ronda_seven.ttf", fontName="PF Ronda Seven", mimeType="application/x-font")]
		private var Ronda:Class;

		[Embed(source="/assets/AIRSANB.TTF", fontName="AirSansBold", mimeType="application/x-font")]
		private var AirSansBold:Class;

		[Embed(source="/assets/AIRSANS.TTF", fontName="AirSans", mimeType="application/x-font")]
		private var AirSans:Class;

		protected var _width:Number = 0;
		protected var _height:Number = 0;

		public static const DRAW:String		= 'draw';

		public static var BACKGROUND:uint	= 0xCCCCCC;
		public static var BUTTON_FACE:uint	= 0xFFFFFF;
		public static var INPUT_TEXT:uint	= 0x333333;
		public static var LABEL_TEXT:uint	= 0x666666;
		public static var DROPSHADOW:uint	= 0x000000;
		public static var PANEL:uint			= 0xF3F3F3;
		public static var PROGRESS_BAR:uint	= 0xFFFFFF;

		public function UIFactory(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, ldr:Function=null):void
		{
			move(xpos, ypos);
			if(parent != null)
			{
				parent.addChild(this);
			}
			init();
		}

		protected function init():void
		{
			addChildren();
			invalidate();
		}

		protected function addChildren():void
		{
		}

		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate, false, 0, true);
		}

		public function move(xpos:Number, ypos:Number):void
		{
			x = Math.round(xpos);
			y = Math.round(ypos);
		}

		public function setSize(w:Number, h:Number):void
		{
			_width = w;
			_height = h;
			invalidate();
		}

		public function draw():void
		{
			dispatchEvent(new Event(UIFactory.DRAW));
		}

		public function writeLine(p:Sprite, lineData:Object, tformat:Object, sep:Boolean=false) :void
		{
			var format:TextFormat = new TextFormat();
			format.font = "AirSans";
			if(tformat.font)			format.font			= tformat.font;
			if(tformat.color)			format.color		= tformat.color;
			if(tformat.size)			format.size			= tformat.size;
			if(tformat.align)			format.align		= tformat.align;
			if(!lineData.lineNo)		lineData.lineNo	= 0;

			if(lineData.labels is String){
				lineData.labels	= [lineData.labels];
				lineData.columns	= [lineData.columns];
			}

			for(var col:String in lineData.labels)
			{
				var _column:TextField = new TextField();
				_column.width					= lineData.lineWidth;
				_column.embedFonts			= true;
				_column.autoSize				= 'left';
				_column.selectable			= false;
				_column.antiAliasType		= AntiAliasType.ADVANCED;
				_column.defaultTextFormat	= format;
				_column.text	= lineData.labels[col];
				_column.x		= lineData.xpos ? lineData.xpos : lineData.columns[col];
				_column.y		= lineData.ypos ? lineData.ypos+4 : 0;
				p.addChild(_column);
			}

			var eol:Number = lineData.ypos + _column.height + 2;
			if(sep)
			{
				var dashed:DashedLine = new DashedLine((sep=='dashed'?4:1), 4, 655 - lineData.marginLeft, 1, "000000");
				dashed.x = lineData.marginLeft;
				dashed.y = eol;
				p.addChild(dashed);
			}

			if(lineData.back)
			{
				var _backlite:LineMarker = new LineMarker(
					{roomObj: lineData.roomObj, no: lineData.lineNo, handler: lineData.handler}
				);
				_backlite.setSize(lineData.lineWidth+4, _column.height-2);
				_backlite.x = lineData.marginLeft + 2;
				_backlite.y = lineData.ypos + 2;
				p.addChild(_backlite);
			}
		}

		public function singleLine(p:Sprite, t:String, w:Number, f:String="AirSans", c:uint=0xffffff, s:Number=24, xpos:Number=10, ypos:Number=10) :TextField
		{
			var _format:TextFormat = new TextFormat();
			_format.font = f;
			_format.color = c;
			_format.size = s;
			_format.align = TextFormatAlign.LEFT;

			var _header:TextField = new TextField();
			_header.width = w;
			_header.height = 30;
			_header.embedFonts = true;
			_header.wordWrap = true;
			_header.autoSize = TextFieldAutoSize.LEFT;
			_header.selectable = false;
			_header.antiAliasType = AntiAliasType.ADVANCED;
			_header.defaultTextFormat = _format;
			_header.text = t;
			_header.x = xpos;
			_header.y = ypos;
			p.addChild(_header);

			return _header;
		}
		
		public function singleLine2(p:Sprite, t:String, f:String="AirSans", c:uint=0xffffff, s:Number=24, xpos:Number=10, ypos:Number=10) :TextField
		{
			var _format:TextFormat = new TextFormat();
			_format.font = f;
			_format.color = c;
			_format.size = s;
			_format.align = TextFormatAlign.LEFT;

			var _header:TextField = new TextField();
			_header.height = 30;
			_header.embedFonts = true;
			_header.autoSize = TextFieldAutoSize.LEFT;
			_header.selectable = false;
			_header.antiAliasType = AntiAliasType.ADVANCED;
			_header.defaultTextFormat = _format;
			_header.text = t;
			_header.x = xpos;
			_header.y = ypos;
			p.addChild(_header);

			return _header;
		}

		private function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}

		override public function set width(w:Number):void
		{
			_width = w;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get width():Number
		{
			return _width;
		}

		override public function set height(h:Number):void
		{
			_height = h;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get height():Number
		{
			return _height;
		}

		override public function set x(value:Number):void
		{
			super.x = Math.round(value);
		}

		override public function set y(value:Number):void
		{
			super.y = Math.round(value);
		}

		public function gcHack():void
		{
			try {
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			} catch (e:Error) {}
		}
	}
}