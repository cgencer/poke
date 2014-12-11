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
	import com.jidd.display.DashedLine;

	public class UIDataPane extends UIFactory
	{
		private var _slider:Slider;

		private var _title:String;
		private var _x:Number;
		private var _y:Number;

		public function UIDataPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, handler:Function = null) :void
		{
			this._title = title;
			this._x = xpos;
			this._y = ypos;

			super(parent, xpos, ypos);
			if(handler != null)	addEventListener(MouseEvent.CLICK, handler, false, 0, true);
		}

		override protected function init():void
		{
			super.init();
		}

		override protected function addChildren() :void
		{
			var _base:Sprite = new Sprite();
			addChild(_base);

			var _back:Sprite = new Shape();
			_back.graphics.beginFill(0xffffff);
			_back.graphics.drawRect(0, 0, 10, 10);
			_back.alpha = 0;
			_base.addChild(_back);

			while(eol<this.maxHeight)
			{
				var eol:Number = 0;
				switch(sep){
					case 'line':
						var line:Shape = new Shape();
						line.graphics.lineStyle(1, 0x000000, 0.5);
						line.graphics.moveTo(lineData.marginLeft, eol);
						line.graphics.lineTo(655, eol);
						_base.addChild(line);
						break;
					case 'dashed':
					case 'dotted':
						var dashed:DashedLine = new DashedLine((sep=='dashed'?4:1), 4, 655 - lineData.marginLeft, 1, "000000");
						dashed.x = lineData.marginLeft;
						dashed.y = eol;
						_base.addChild(dashed);
						break;
				}
				eol += lineHeight;
			}


			_slider = new Slider(Slider.VERTICAL, _panel);
			_slider.setSize(20, 167);
			_slider.x = _panel.width - 39;
			_slider.y = 80;
			_slider.alpha = 0.5;

			writeLine(_panel, {
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
				_panel.addChild(_pane);
			}

			_pane = _paneset[0];
			_pane.alpha = 1;
			_selectedPane = 0;

			_slider.minimum = -(_pane.height-maxHeight+2);
			_slider.maximum = 0;
			_slider.value = _slider.maximum;
			_slider.addEventListener(Event.CHANGE, function(e:Event):void{sliderScroll(_slider, _pane);});
		}

		private function sliderScroll(s:Slider, l:Sprite) :void
		{
			l.y = s.value;
		}

	}
}

