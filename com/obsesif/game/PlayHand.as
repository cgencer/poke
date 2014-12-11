package com.obsesif.game
{

	import flash.events.Event;
	
	public class PlayHand extends Event {
	
		public static const COMPLETE:String = "complete";
		
		public var _params:Object = null
		
		public function get params():Object {
			return _params;
		}
		
		public function PlayHand(type:String, params:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, false, false);
			_params = params;
		}
		
		public override function clone():Event
        {
            return new PlayHand(type, _params, bubbles, cancelable);
        }
	
	}

}