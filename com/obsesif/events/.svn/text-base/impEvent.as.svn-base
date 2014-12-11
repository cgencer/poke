package com.obsesif.events
{

	import flash.events.Event;
	
	public class impEvent extends Event {
	
		public static const COMPLETE:String = "complete";
		
		private var _params:Object = null;
		
		public function get params():Object {
			return _params;
		}
		
		public function impEvent(type:String, params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, false, false);
			_params = params;
		}
		
		public override function clone():Event
        {
            return new impEvent(type, _params, bubbles, cancelable);
        }
		
		public override function toString():String
        {
            return formatToString("impEvent", "params", "type", "bubbles", "cancelable");
        }
	
	}

}