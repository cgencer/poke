package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import com.obsesif.ui.UIFactory;
	import com.obsesif.events.impEvent;

	public class UIDropdown extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="dropdown")]
      private var rawDropdown:Class;

		private var _menuitems:Array = [];
		private var _x:Number;
		private var _y:Number;
		private var _shifty:Number;
		public var _down:Boolean = false;
		private var _no:Number;
		private var _skip:Number;
		private var _label:TextField;
		private var _size:Number = 60;

		private var _over:Boolean = false;
		private var _selected:Boolean = false;
		private var _toggle:Boolean = false;
		public var _items:Sprite;
		private var _iover:Boolean = false;

		public function UIDropdown(parent:DisplayObjectContainer, xpos:Number, ypos:Number, size:Number, mi:Array, no:Number, handler:Function = null) :void
		{
			this._menuitems = mi;
			this._x = xpos;
			this._y = ypos;
			this._no = no;
			this._size = size;

			super(parent, xpos, ypos);
			if(handler != null)	addEventListener(MouseEvent.CLICK, handler);
		}

		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
		}

		override protected function addChildren() :void
		{
			var _on:Sprite = new rawDropdown();
			addChild(_on);

			var format:TextFormat = new TextFormat();
			format.font = "AirSans";
			format.color = 0xFFFFFF;
			format.size = 12;

			_label = new TextField();
			_label.width = _on.width;
			_label.embedFonts = true;
			_label.autoSize = 'left';
			_label.antiAliasType = AntiAliasType.ADVANCED;
			_label.defaultTextFormat = format;
			_label.text = this._menuitems[0];
			addChild(_label);
			_label.x = 6;
			_label.y = 2;
//			_label.y = this._shifty;

			var _hidden:Sprite = new Sprite();
			addChild(_hidden);
			_hidden.alpha = 0;
			_hidden.graphics.beginFill(0xff0000);
			_hidden.graphics.drawRect(0, 0, _on.width, _on.height);
			_hidden.graphics.endFill();

			_items = new Sprite();
			addChild(_items);
			_items.y = 1000;
			_items.graphics.lineStyle(3, 0x000000);
			_items.graphics.beginFill(0x406070);
			_items.graphics.drawRoundRect(0, _on.height, 110, this._size, 20);
			_items.graphics.endFill();

			_hidden.addEventListener(MouseEvent.CLICK, onMouseDown);
			_items.addEventListener(MouseEvent.MOUSE_OVER, mover);
			_items.addEventListener(MouseEvent.MOUSE_OUT, mout);

			var lineHeight:Number = 15;
			for(var index:Number=0; index < this._menuitems.length; index++)
			{
				writeLine(_items, {
						lineNo:		index,
						columns:		5,
						labels:		this._menuitems[index],
						ypos:			22 + index*18,
						lineWidth:	100,
						marginLeft:	5,
						maxLines:	4,
						roomObj:		{id: index, title: this._menuitems[index]},
						back:			true,
						handler:		itemClicked
					},
					{color: 0xffffff, size: 12}, false);
			}
		}

		public function close():void
		{
			_down = false;
			_items.y = 1000;
		}

		private function itemClicked(e:Event):void
		{
			_down = false;
			dispatchEvent(new impEvent('FILTER_SET', {menu: this._no, item: e.target.parent.id}));
//			_label.text = e.target.parent.id;
			_items.y = _down ? 0 : 1000;
		}

		private function mover(e:MouseEvent):void
		{
			_over = true;
			_down = true;
			_items.y = _down ? 0 : 1000;
		}
		private function mout(e:MouseEvent):void
		{
			_over = false;
			_down = false;
			_items.y = _down ? 0 : 1000;
		}

		private function onMouseDown(e:MouseEvent):void
		{
			_down = !_down;
			_items.y = _down ? 0 : 1000;
			e.target.parent.parent.parent.dispatchEvent(new Event('CLOSE_PULLDOWNS'));
		}
	}
}