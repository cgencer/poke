package com.obsesif.ui
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import br.com.stimuli.loading.BulkLoader;

	import com.obsesif.ui.UIFactory;
	import com.bit101.components.Slider;

	public class UITopList extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="winE")]
      private var rawTopList:Class;
      [Embed(source="/assets/UIElements.swf", symbol="cimdik")]
      private var rawCimdik:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik0")]
		private var rawCimdik0:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik1")]
		private var rawCimdik1:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik2")]
		private var rawCimdik2:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik3")]
		private var rawCimdik3:Class;
		[Embed(source="/assets/UIElements.swf", symbol="cimdik4")]
		private var rawCimdik4:Class;

		private var _tl:Array;
		private var _cb:Sprite;
		private var _spr:Sprite;
		private var _msk:Shape;
		private var _slider:Slider;
		private var _p:String;
		private var _list:Array;
		private var _cimdik:Sprite;
		private var preUrl:String = 'http://www.zukaa.com/u/profilepictures/';
		private var loader:BulkLoader;

		public function UITopList(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0) :void
		{
			super(parent, xpos, ypos);
		}

		override protected function init():void { super.init(); }

		override protected function addChildren() :void
		{
			_cb = new rawTopList();
			addChild(_cb);

			_slider = new Slider(Slider.VERTICAL, this);
			_slider.setSize(10, 178);
			_slider.x = 213;
			_slider.y = 72;
			_slider.alpha = 1;

			_spr = new Sprite();
			_spr.x = 10;
			_spr.y = 80;
			_cb.addChild(_spr);

			_msk = new Shape();
			_msk.x = 10;
			_msk.y = 80;
			_msk.graphics.beginFill(0xff0000);
			_msk.graphics.drawRect(0, 0, 190, 170);
			_msk.graphics.endFill();
			addChild(_msk);

			_spr.mask = _msk;

			_slider.minimum = -(_spr.height-250);
			_slider.maximum = 80;
			_slider.value = _slider.maximum;
			_slider.addEventListener(Event.CHANGE, function(e:Event):void{sliderScroll(_slider, _spr);});
		}

		public function buildEntries(list:Array) :void
		{
			for (var ii:Number=0; ii<list.length; ii++)
			{
				list[ii].peanut = Number(list[ii].peanut);
			}
			list.sortOn('peanut', Array.DESCENDING | Array.NUMERIC);
			this._list = list;

			loader = new BulkLoader("main");

			for (var i:Number=0; i<list.length; i++)
			{
				var uo:Object = list[i];

				var xset:Sprite = new Sprite();
				_spr.addChild(xset);
				xset.y = i*70;

				loader.add(this.preUrl+uo.userId+'.jpg');

				var frm:Object = {color: 0xffffff, size: 12};
				writeLine(xset, {labels: uo.uri, xpos:70, ypos:0, lineWidth:75}, frm);
				writeLine(xset, {labels: String(uo.peanut), xpos:70, ypos:20, lineWidth:75}, frm);

				var cimdik:Sprite;
				if(Number(uo['membershipType']) >-1 && Number(uo['membershipType']<5)){
					if(Number(uo['membershipType']) == 0) _cimdik = new rawCimdik0();
					if(Number(uo['membershipType']) == 1) _cimdik = new rawCimdik1();
					if(Number(uo['membershipType']) == 2) _cimdik = new rawCimdik2();
					if(Number(uo['membershipType']) == 3) _cimdik = new rawCimdik3();
					if(Number(uo['membershipType']) == 4) _cimdik = new rawCimdik4();
				}else{
					_cimdik = new rawCimdik0();
				}
				xset.addChild(_cimdik);
				_cimdik.x = 145;
			}
			loader.addEventListener(BulkLoader.COMPLETE, onComplete);
			loader.start();

			_slider.minimum = -(_spr.height-240);
			_slider.maximum = 80;
			_slider.value = _slider.maximum;

		}

		private function onComplete(e:Event) : void
		{
			for (var i:Number=0; i<this._list.length; i++)
			{
				var uo:Object = this._list[i];
				var img:Bitmap = loader.getBitmap( this.preUrl + uo.userId + '.jpg' );
				img.scaleX = img.scaleY = .70;
				this._spr.addChild(img);
				img.y = i*70;
			}
		}

		private function sliderScroll(s:Slider, l:Sprite) :void { l.y = Math.floor(s.value); }
	}
}
