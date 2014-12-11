package com.obsesif.ui
{
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.DataEvent;
	import flash.events.MouseEvent;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	import com.obsesif.utils.LoggingFactory;

	import com.bit101.components.Panel;
	import com.bit101.components.Label;
	import com.bit101.components.Text;
	import com.bit101.components.Slider;
	import com.jidd.display.DashedLine;

	import com.obsesif.ui.LineMarker;

	public class ListBox extends Sprite
	{
		public static const log :Logger = LogContext.getLogger(ListBox);
		private var dispatcher:EventDispatcher;

		private var maxLines:Number		= 3;
		private var maxWidth:Number		= 150;
		private var defHeight:Number		= 100;
		private var posX:Number				= 50;
		private var posY:Number				= 50;
		private var header:String			= "";
		private var title:String			= "";
		private var headerHeight:Number	= 20;
		private var lineHeight:Number		= 15;

		private var _overflow:Boolean		= false;
		private var _items:Array;
		private var _panel:Panel;
		private var _set:Sprite;
		private var _lr:Number;
		private var _slider:Slider;
		private var _ps:Sprite;
		private var _handler:Function;
		private var _labelset:Sprite;

		public function ListBox(entries:Array, param:Object, handler:Function = null) :void
		{
			if(param.maxWidth)	this.maxWidth	= param.maxWidth;
			if(param.defHeight)	this.defHeight	= param.defHeight;
			if(param.maxLines)	this.maxLines	= param.maxLines;
			if(param.header)		this.header		= param.header;
			if(param.posX)			this.posX		= param.posX;
			if(param.posY)			this.posY		= param.posY;
			if(param.title)		this.title		= param.title;
			if(handler != null)	this._handler	= handler;
			this._items = entries;

			if(this._items.length > maxLines)_overflow = true;

			this._set = new Sprite();
			this._set.x = this.posX;
			this._set.y = this.posY;

			_panel = new Panel(this._set, 0, 0);
			_lr = (maxLines <= this._items.length) ? maxLines : this._items.length;
			var dh:Number = this.defHeight;
			_panel.setSize(this.maxWidth, this.headerHeight+(this.lineHeight+2)*this._lr);
			_panel.alpha = 0.8;

			addChild(this._set);

			if(this._overflow){
				_slider = new Slider(Slider.VERTICAL, this._set);
				_slider.setSliderParams(0, 100, 100);
				_slider.x = this.maxWidth-_slider.width;
				_slider.y = this.headerHeight;
				_slider.setSize(10, (this.lineHeight+2)*this._lr);
				_slider.addEventListener(Event.CHANGE, function(e:Event):void{sliderScroll(_slider, _labelset);});
			}

			new Label(this._set, 4, 2, this.header);

			var ot:Number = (this._overflow) ? 10 : 0;
			var d:DashedLine = new DashedLine(4, 4, this.maxWidth-ot, 1, "000000");
			d.y = this.headerHeight-1;
			d.alpha = 0.3;
			this._set.addChild(d);

			var m:Shape = new Shape();
			m.graphics.beginFill(0xaaaaff);
			m.graphics.drawRect(0,0, this.maxWidth, this.headerHeight-1);
			m.alpha = 0.15;
			this._set.addChild(m);

			build();
		}

		private function sliderScroll(s:Slider, l:Sprite) :void
		{
			l.y = s.value;
		}

		private function andler(e:MouseEvent) :void
		{
			main.log.info('XXXX room '+e.target.num);
//			dispatchEvent(new Event('LISTITEM_CLICKED'));
		}

		private function build() :void
		{
			if(this._items.length>0){
				var t:Label;
				var cx:Number = 0;
				_labelset = new Sprite();

				this._set.addChild(_labelset);
				var ot:Number = (this._overflow) ? 10 : 0;
				for (var i:String in this._items){
					var _backlite:LineMarker = new LineMarker(this._items[i], this.title, andler);
					_backlite.addEventListener('ITEM_CLICKED', andler);
					_backlite.setSize(this.maxWidth-ot, this.lineHeight);
					_backlite.x = 0;
					_backlite.y = this.headerHeight+(this.lineHeight+2)*cx;
					_backlite.num = cx;
					_labelset.addChild(_backlite);
					cx++;
				}
				cx = 0;
				for (i in this._items){
					new Label(_labelset, 4, this.headerHeight+(this.lineHeight+2)*cx-2, this._items[i].title);
					cx++;
				}
				var _mask:Sprite = new Sprite();
				_mask.graphics.beginFill(0xff0000);
				_mask.graphics.drawRect(0, 1, this.maxWidth-ot, _panel.height-this.headerHeight);
				_panel.addChild(_mask);
				_mask.y = this.headerHeight;
				_labelset.mask = _mask;
				_panel.addChild(_labelset);

				if(this._overflow){
					_slider.minimum = 0-(_labelset.height-_panel.height+2);
					_slider.maximum = 0;
					_slider.value = _slider.maximum;
				}
			}
		}
	}
}
