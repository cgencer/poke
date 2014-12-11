package com.neriksworkshop.lib.ASaudio.core 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author www.neriksworkshop.com
	*/
	public class InfoEvent extends Event 
	{
		
		public var info:*;
		
		public function InfoEvent(type:String, info:*, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.info = info;
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new InfoEvent(type, info, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("InfoEvent", "type", "info", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}