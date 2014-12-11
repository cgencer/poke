package com.obsesif.ui
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.Event;

	import com.obsesif.ui.UIFactory;

	import com.bit101.components.Panel;
	import com.bit101.components.Label;
	import com.bit101.components.Text;
	import com.bit101.components.InputText;
	import com.bit101.components.Slider;
	import com.bit101.components.PushButton;
	import com.jidd.display.DashedLine;

	public class ContentBox extends UIFactory
	{
		private var maxLines:Number		= 3;
		private var maxWidth:Number		= 150;
		private var maxHeight:Number		= 95;
		private var posX:Number				= 50;
		private var posY:Number				= 140;
		private var header:String			= "";
		private var title:String			= "";
		private var sliderWidth:Number	= 10;
		private var input:Boolean			= false;
		private var headerHeight:Number	= 20;
		private var lastY:Number			= 0;

		private var _panel:Panel;
		private var _content:Sprite;
		private var _slider:Slider;
		private var _mc:Sprite;
		private var _text:String = "";
		private var _entry:InputText;
		private var _send:PushButton;
		private var _smiley:PushButton;
		private var _smilewin:Panel;

		public function ContentBox(param:Object) :void
		{
			if(param.width)		this.maxWidth	= param.width;
			if(param.height)		this.maxHeight	= param.height;
			if(param.posX)			this.posX		= param.posX;
			if(param.posY)			this.posY		= param.posY;
			if(param.header)		this.header		= param.header;
			if(param.title)		this.title		= param.title;
			if(param.input)		this.input		= param.input;
			init();
		}

		public function smileOver() :void
		{
		}

		override protected function addChildren():void
		{
			_panel = new Panel(this, posX, posY);
			_panel.setSize(maxWidth, maxHeight);
			_panel.alpha = 0.8;

			_slider = new Slider(Slider.VERTICAL, _panel, maxWidth-sliderWidth, 20);
			_slider.setSize(10, maxHeight-20);

			new Label(_panel, 4, 2, header);

			var d:DashedLine = new DashedLine(4, 4, maxWidth-10, 1, "000000");
			d.y = 19;
			d.alpha = 0.3;
			_panel.addChild(d);

			var m:Shape = new Shape();
			m.graphics.beginFill(0xaaaaff);
			m.graphics.drawRect(0,0, maxWidth, 19);
			m.alpha = 0.15;
			_panel.addChild(m);

			_content = new Sprite();
			addChild(_content);

			var _mask:Sprite = new Sprite();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(0, this.headerHeight, this.maxWidth-10, this.maxHeight-20);
			addChild(_mask);
			_content.mask = _mask;

			if(this.input){
				_smiley = new PushButton(_panel, 0, _panel.height, ":)", smileOver);
				_smiley.setSize(20, 16);

				_entry = new InputText(_panel, 20, _panel.height);
				_entry.setSize(_panel.width-30, 16);

				_send = new PushButton(_panel, _panel.width-10, _panel.height, ">");
				_send.setSize(10, 16);
			}
		}

		private function sliderScroll(s:Slider, l:Sprite) :void
		{
			l.y = s.value;
		}

		public function drawText(line:String) :void
		{
			var tf:TextField = new TextField();
			tf.width = _panel.width - sliderWidth - 4;
			tf.x = 2;
			tf.y = 2;
			tf.embedFonts = true;
			tf.multiline = true;
			tf.wordWrap = true;
			tf.selectable = true;
			tf.text = line;
			tf.defaultTextFormat = new TextFormat("PF Ronda Seven", 8, 0x000000);
			_content.addChild(tf);
			lastY += tf.height;
		}

		public function get text() :String
		{
			return(_text);
		}
	}
}