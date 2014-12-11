package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import com.obsesif.ui.UIFactory;
	import com.bit101.components.Slider;
	import com.obsesif.events.impEvent;

	public class UIModeratorBox extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="windowOutput")]
      private var rawOutput:Class;

		[Embed(source="/assets/AIRSANS.TTF", fontName="AirSans", mimeType="application/x-font")]
		private var AirSans:Class;

		private var _cb:Sprite;
		private var _con:String;
		private var _spr:Sprite;
		private var _msk:Shape;
		private var _slider:Slider;
		private var _index:Number = 0;

		public function UIModeratorBox (parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0) :void
		{
			super(parent, xpos, ypos);
		}

		override protected function init():void
		{
			super.init();
		}

		override protected function addChildren() :void
		{
			_cb = new Sprite();
			_cb.graphics.lineStyle(3, 0x000000);
			_cb.graphics.beginFill(0x406070);
			_cb.graphics.drawRoundRect(0, 0, 125, 200, 20);
			_cb.graphics.endFill();
			addChild(_cb);

			_spr = new Sprite();
			_spr.x = 5;
			_spr.y = 5;
			addChild(_spr);
			_msk = new Shape();
			_msk.x = 5;
			_msk.y = 5;
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, 125, 200);
			_msk.graphics.endFill();
			addChild(_msk);
			_spr.mask = _msk;
		}

		public function cleanContent() :void
		{
			_con = "";
			removeChild(_spr);
			removeChild(_msk);
			this._index = 0;

			_spr = new Sprite();
			_spr.x = 5;
			_spr.y = 5;
			addChild(_spr);
			_msk = new Shape();
			_msk.x = 5;
			_msk.y = 5;
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, 120, 200);
			_msk.graphics.endFill();
			addChild(_msk);
			_spr.mask = _msk;
		}

		public function addContent(c:String, id:Number, l:Number, userid:Number) :void
		{
			_con += c;

			writeLine(_spr, {
					lineNo:		this._index,
					columns:		0,
					labels:		c,
					ypos:			this._index*17+2,
					lineWidth:	120,
					marginLeft:	0,
					maxLines:	7,
					roomObj:		{sfid: id, title: c, level: l, id: userid},
					back:			true,
					handler:		itemClicked
				},
				{color: 0xcccccc, size: 12}, false);
			this._index++;
		}

		private function itemClicked(e:Event):void
		{
main.log.info('from modlist: '+e.target.parent.id);
			try {
			dispatchEvent(new impEvent('MODLIST_CLICKED', { sfid: e.target.parent.sfid, level: e.target.parent.level,title: e.target.parent.title, uid: e.target.parent.id} ));
			} catch (e:Error) {}
		}
	}
}