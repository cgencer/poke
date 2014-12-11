package com.obsesif.game
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.utils.Timer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import com.gskinner.motion.GTween;
	import com.obsesif.events.impEvent;

	public class gGlass extends Sprite
	{
		private var bar:Object;
		private var ldr:Loader;
		private var glass:Sprite;
		private var gTimer:Timer;
		private var _drink:Object; 
		public var sendTo:Number;

		public function gGlass(parent:DisplayObjectContainer, drink:Object):void
		{
			this._drink = drink;
			this.sendTo = drink.sendTo;

			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, drinksLoaded);
			var request:URLRequest = new URLRequest('../assets/gDrinks.swf');
			ldr.load(request);
			
			parent.addChild(this);
		}

		private function drinksLoaded(e:Event) :void
		{
			var rc:Class = ldr.contentLoaderInfo.applicationDomain.getDefinition('gDrinks') as Class;
			this.bar = new rc();
			
			var sc:Class = this.bar['rawDrink'+String(this._drink.no)] as Class;
			glass = new sc() as Sprite;
			addChild(glass);

			/*
			glass.x = this._drink['receiver'].posx + (170-glass.width)/2;
			glass.y = this._drink['receiver'].posy - glass.height;
			*/

			glass.x = this._drink.fromposx + (170-glass.width)/2;
			glass.y = this._drink.fromposy - glass.height;

			gTimer = new Timer(45000, 1);
			gTimer.addEventListener("timer", glassEmpty);
			gTimer.start();

			new GTween(glass, .5, {x: /*this._drink['sender'].posx*/this._drink.toposx, y: this._drink.toposy/*this._drink['sender'].posy*/});
			
		}

		public function glassEmpty(e:TimerEvent):void {
			removeChild(glass);
			dispatchEvent(new impEvent('GLASS_KILLED', {sendTo: this.sendTo}));
		}

	}
}