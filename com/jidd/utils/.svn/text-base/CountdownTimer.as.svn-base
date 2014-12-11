/**
name: CountdownTimer
type: class  extends Timer
package: com.jidd.utils

description: CountdownTimer is a utility
It is a Timer at it's core, but only counts down to a specified date's milliseconds.
By default the timer delay is 1000 milliseconds.
You cannot change the Timer repeatCount since it is used specifically for the count down.

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
package com.jidd.utils {
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.jidd.events.CountdownTimerEvent;
	
	// START CLASS
	public class CountdownTimer extends Timer {
		
		/**
		 * VARIABLES
		 */
		
		private var _date:Date;
		private var _dateMillisecs:Number;
		
		/**
		 * CONSTRUCTOR
		 */
		
		public function CountdownTimer(date:Date) {			
			_date = date;
			_dateMillisecs = _date.getTime();
						
			/* designed to run in seconds */
			super(1000, this.seconds);
			
			addEventListener(TimerEvent.TIMER, handleTimer, false, 0, true);
			addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete, false, 0, true);
		}
		
		override public function start():void {
			if(!super.running) {
				super.repeatCount = this.seconds;
				super.start();
				dispatchEvent(new CountdownTimerEvent(CountdownTimerEvent.TIMER, this.milliSeconds, this.seconds, this.minutes, this.hours, this.days));
			}
		}
		
		/**
		 * LISTENERS
		 */
		
		private function handleTimer(e:TimerEvent):void {
			dispatchEvent(new CountdownTimerEvent(CountdownTimerEvent.TIMER, this.milliSeconds, this.seconds, this.minutes, this.hours, this.days));
		}
		
		private function handleTimerComplete(e:TimerEvent):void {
			dispatchEvent(new CountdownTimerEvent(CountdownTimerEvent.TIMER_COMPLETE));
		}
		
		/**
		 * PROPERTIES
		 */
		
		// repeatCount (do nothing to set back to read-only)
		override public function set repeatCount(v:int):void {
			throw(new ReferenceError('repeatCount value - '+v+', property cannot be modified in CountdownTimer'));
			return;
		}
		
		// date
		public function get date():Date {
			return _date;
		}
		public function set date(d:Date):void {
			_date = d;
			_dateMillisecs = _date.getTime();
			super.repeatCount = this.seconds;
		}
		
		// milliSeconds read-only
		public function get milliSeconds():Number {
			return (_dateMillisecs - new Date().getTime());
		}
		
		// seconds read-only
		public function get seconds():Number {
			return ( Math.floor(this.milliSeconds/1000));
		}
		
		// minutes read-only
		public function get minutes():Number {
			return (Math.floor(this.seconds/60));
		}
		
		// hours read-only
		public function get hours():Number {
			return (Math.floor(this.minutes/60));
		}
		
		// days read-only
		public function get days():Number {
			return (Math.floor(this.hours/24));
		}
	}
	// END CLASS
}
// END PACKAGE