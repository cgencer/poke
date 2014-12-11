/*
name: CountdownTimerEvent
type: class extends Event
package: com.jidd.events

description: CountdownTimerEvent
This event is meant to be dispatched by com.jidd.utils.CountdownTimer

author:			jimisaacs
author uri:		http://ji.dd.jimisaacs.com

	Copyright (c) 2008 Jim Isaacs
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to 
	deal in the Software without restriction, including without limitation the
	rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
	sell copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
	IN THE SOFTWARE.
*/

// START PACKAGE
package com.jidd.events {
	
	import flash.events.Event;
	
	// START CLASS
	public class CountdownTimerEvent extends Event {
		
		/*
		 * CONSTANTS
		 */
		
		public static const TIMER:String = "countdownTimer";
		public static const TIMER_COMPLETE:String = "countdownTimerComplete";
				
		/*
		 * VARIABLES
		 */
		
		private var _milliSeconds:Number;
		private var _seconds:Number;
		private var _minutes:Number;
		private var _hours:Number;
		private var _days:Number;
		
		/*
		 * CONSTRUCTOR
		 */
		
		public function CountdownTimerEvent(type:String, milliSeconds:Number=0, seconds:Number=0, minutes:Number=0, hours:Number=0, days:Number=0) {
			super(type);
			_milliSeconds = milliSeconds;
			_seconds = seconds;
			_minutes = minutes;
			_hours = hours;
			_days = days;
		}
		
		/*
		 * PROPERTIES
		 */
		
		// milliSeconds read-only
		public function get milliSeconds():Number {
			return _milliSeconds % 1000;
		}
		
		// seconds read-only
		public function get seconds():Number {
			return _seconds % 60;
		}
		
		// minutes read-only
		public function get minutes():Number {
			return _minutes % 60;
		}
		
		// hours read-only
		public function get hours():Number {
			return _hours % 24;
		}
		
		// days read-only
		public function get days():Number {
			return _days;
		}
	}
	// END CLASS
}
// END PACKAGE