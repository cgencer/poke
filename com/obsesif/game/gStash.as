package com.obsesif.game
{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObjectContainer;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class gStash extends Sprite
	{
		private var ldr:Loader;
		private var stash:Sprite;
		//private var cn:Array = [5000, 2000, 1000, 500, 100, 50, 25, 10];
		private var cn:Array = [2000, 1000, 500, 100, 50, 25, 10, 5];
		private var chips:Array = [];
		public var value:Number;
		private var _split:Boolean;

		public function gStash(parent:DisplayObjectContainer, v:Number, posX:Number, posY:Number, split:Boolean = true) :void
		{
			parent.addChild(this);

			this.value = v;
			this._split = split;
			chips = buildStash(v);

			if(stash!=null) if(stash is Sprite) removeChild(stash);
			stash = new Sprite();
			stash.x = posX;
			stash.y = posY;
			addChild(stash);

			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, chipsLoaded);
			var request:URLRequest = new URLRequest('../assets/gChips.swf');
			ldr.load(request);
		}

		private function chipsLoaded(e:Event) :void
		{
			var rc:Class = ldr.contentLoaderInfo.applicationDomain.getDefinition('gChips') as Class;
			var bank:Object = new rc();

			var xp:Number;
			var yp:Number;
			try {
			var ch:Number = (this._split) ? 6 : 12;
			} catch(e:Error) {main.log.info('split: ' + e);}
			//main.log.info('Chips: ' + this.chips);
			for(var i:Number=0; i< this.chips.length; i++){
				//if(this.chips[i] !== 'chip05') {
				if(this.chips[i] == 'chip05') {this.chips[i] = 'chip05000';}
					//main.log.info('Chip: '+this.chips[i]);
					try {
						var sc:Class = bank[ this.chips[i] ] as Class; // Chip05
					} catch(e:Error) {main.log.info('stash fail boo ya ' + e);}
					var symbol:Sprite = new sc() as Sprite;
					stash.addChild(symbol);
	//				symbol.scaleX = 0.25;
	//				symbol.scaleY = 0.25;
					xp = Math.floor(i/ch);
					yp = Math.floor(i%ch);
					symbol.x = xp*(symbol.width+2);
					symbol.y = (ch-yp)*5;
				//}
			}
		}

		public function buildStash(v:Number) :Array
		{
			var cns:Array = [];
			//main.log.info('Build Started With Value: '+v);

			// cut-off above...
			if (v>10000) v=10000;

			for(var j:Number=0; j<this.cn.length; j++)
			{
				if( v >= cn[j] )
				{
					//main.log.info('v is '+v+' Chip' + cn[j] + 'selected value is: ' + Math.floor(v/this.cn[j]));
					var t:Number = Math.floor(v/this.cn[j]);
					for(var i:Number=1; i <= t; i++)
					{
						cns.push( 'chip0' + String(this.cn[j]) );
						v -= this.cn[j];
						//main.log.info('Loop initiated for ' + i + 'th time for '+ cn[j] + ' updated v is: ' + v);
					}
				}
			}
			cns.reverse();
			//main.log.info('Chip Stack: '+cns);
			return cns;
		}
	}
}
