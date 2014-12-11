package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import com.bit101.components.Slider;
	import com.obsesif.ui.UIFactory;

	public class UIMultiPane extends UIDataPane
	{
		private var _slider:Slider;
		private var _root:Sprite;

		private var _x:Number;
		private var _y:Number;

		private var _paneset:Array = new Array();
		private var _selectedPane:Number;
		private var _paneData:Object;

		public function UIMultiPane(paneData:Object, parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, handler:Function = null) :void
		{
			this._paneData = paneData;
			this._x = xpos;
			this._y = ypos;

/*	paneData:
{
	columns: [
					{xpos: marginLeft+ 10, title: "Masa"},
					{xpos: marginLeft+300, title: "Oyuncu"},
					{xpos: marginLeft+450, title: "Durum"}
				],
	textFormat:	{color: 0xffffff, size: 14},
	headFormat:	{color: 0x000000, size: 14},
}
*/

			super(parent, xpos, ypos);
			if(handler != null)	addEventListener(MouseEvent.CLICK, handler);
		}

		override protected function init():void
		{
			super.init();
		}

		override protected function addChildren() :void
		{


			_slider = new Slider(Slider.VERTICAL, _base);
			_slider.setSize(20, 167);
			_slider.x = _base.width - 39;
			_slider.y = 80;
			_slider.alpha = 0.5;

			writeLine(_base, {
					lineNo:		0,
					columns:		[marginLeft+ 10, marginLeft+300, marginLeft+450],
					labels:		["Masa", "Oyuncu", "Durum"],
					ypos:			60,
					lineWidth:	maxWidth-_slider.width-4,
					marginLeft:	6,
					marginTop:	55,
					maxLines:	1
				}, {color: 0xffffff, size: 14}
			);

			var _pane:Sprite;
			for each (var r:String in this.panelTypes)
			{
				_pane = createPane(r);
				_pane.alpha = 0;
				_paneset.push(_pane);
				_base.addChild(_pane);
			}

			_pane = _paneset[0];
			_pane.alpha = 1;
			_selectedPane = 0;

			_slider.minimum = -(_pane.height-maxHeight+2);
			_slider.maximum = 0;
			_slider.value = _slider.maximum;
			_slider.addEventListener(Event.CHANGE, function(e:Event):void{sliderScroll(_slider, _pane);});
		}

		private function createPane(typ:String) :Sprite
		{
			var lineHeight:Number = 15;
			var maxLines:Number = 3;
			var maxWidth:Number = 666;
			var borderWidth:Number = 8;
			var headerHeight:Number = 23;

			var cx:Number=0;
			var _s:Sprite = new Sprite();

			for(var index:Number=0; index<this._rooms[typ].length; index++)
			{
				var pset:Object = this._rooms[typ][index];
				_labelset = new Sprite();
				_s.addChild(_labelset);

				writeLine(_labelset, {
						lineNo:		index,
						columns:		[borderWidth+marginLeft, borderWidth+marginLeft+290, borderWidth+marginLeft+440],
						labels:		[pset.id+": "+pset.title, pset.stat, (pset.privacy ? "özel" : "açık")],
						ypos:			headerHeight + marginTop + index * (lineHeight + 2) - 2,
						lineWidth:	maxWidth - _slider.width - borderWidth,
						roomName:	pset.title,
						roomId:		pset.id,
						roomType:	pset.type,
						marginLeft:	6,
						maxLines:	10,
						back:			true,
						handler:		andler
					}, {color: 0x000000, size: 12}
				);
			}

			var _mask:Sprite = new Sprite();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(marginLeft+4, marginTop+2, maxWidth - _slider.width-4, maxHeight);
			addChild(_mask);
			_s.mask = _mask;

			return(_s);
		}

		private function sliderScroll(s:Slider, l:Sprite) :void
		{
			l.y = s.value;
		}

	}
}

