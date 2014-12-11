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

	public class UIBuddiesBox extends UIFactory
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

		public function UIBuddiesBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0) :void
		{
			super(parent, xpos, ypos);
		}

		override protected function init():void
		{
			super.init();
		}

		override protected function addChildren() :void
		{
			_cb = new rawOutput();
			addChild(_cb);

			_slider = new Slider(Slider.VERTICAL, this);
			_slider.setSize(10, 120);
			_slider.x = 170;
			_slider.y = 35;
			_slider.alpha = 1;

			writeLine(this, {labels: "Arkadaşlarım", xpos: 45, ypos:-2}, {color: 0xffffff, size: 15});

			_spr = new Sprite();
			_spr.x = 10;
			_spr.y = 35;
			addChild(_spr);
			_msk = new Shape();
			_msk.x = 10;
			_msk.y = 35;
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, 158, 120);
			_msk.graphics.endFill();
			addChild(_msk);
			_spr.mask = _msk;

			_slider.minimum = -(_spr.height-120);
			_slider.maximum = 0;
			_slider.value = _slider.maximum;
			_slider.visible = (_spr.height>120) ? true : false;
			_slider.addEventListener(Event.CHANGE, function(e:Event):void{sliderScroll(_slider, _spr);});
		}

		private function sliderScroll(s:Slider, l:Sprite) :void { l.y = Math.floor(s.value); }

		public function cleanContent() :void
		{
			_con = "";
			removeChild(_spr);
			removeChild(_msk);
			this._index = 0;

			_spr = new Sprite();
			_spr.x = 10;
			_spr.y = 35;
			addChild(_spr);
			_msk = new Shape();
			_msk.x = 10;
			_msk.y = 35;
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, 158, 120);
			_msk.graphics.endFill();
			addChild(_msk);
			_spr.mask = _msk;

			_slider.minimum = (-(_spr.height-120) > 0)? 145.7 - _spr.height : -(_spr.height-145.7);
			_slider.maximum = 0 + 17.3 * 2;
			_slider.value = _slider.maximum;
			_slider.visible = (_spr.height>120) ? true : false;
			_slider.addEventListener(Event.CHANGE, function(e:Event):void{sliderScroll(_slider, _spr);});
		}

		public function addContent(c:String, id:Number, pw:String="") :void
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
					roomObj:		{id: id, title: c, pass: pw},
					back:			true,
					handler:		itemClicked
				},
				{color: 0xcccccc, size: 12}, false);
			this._index++;

			_slider.minimum = (-(_spr.height-120) > 0)? 145.7 - _spr.height : -(_spr.height-145.7);
			_slider.maximum = 0 + 17.3 * 2;
			_slider.value = _slider.maximum;
			_slider.visible = (_spr.height>120) ? true : false;
		}

		private function itemClicked(e:Event):void
		{
main.log.info('from buddylist: '+e.target.parent.id);
			dispatchEvent(new impEvent('BUDDY_CLICKED', {	id:	Number(e.target.parent.id),
																			pass:	e.target.parent.pass }
			));
		}
	}
}