/*
name: KeyboardControlEvent
type: class extends Event
package: com.jidd.events

description: KeyboardControlEvent
This event is meant to be dispatched by com.jidd.keyboard.KeyboardControl

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
	public class KeyboardControlEvent extends Event {
		
		/*
		 * CONSTANTS
		 */
		
		public static const ANY:String = "anyKey";
		// the special and once only dispatched 'keyUp' and 'keyDown' events
		public static const KEY_UP:String = "keyUp";
		public static const KEY_DOWN:String = "keyDown";
		
		/*
		 * keyCodes are also converted to Strings for Event types
		 * example: String(Keyboard.LEFT);
		 * Therefor you may do this: myControl.addEventListener(KeyboardControlEvent.key(Keyboard.LEFT), myHandleKeyLeft);
		 */
		 
		public static function key(keyCode:int):String {
			return 'keyboardKey'+String(keyCode);
		}
		
		/*
		 * VARIABlES
		 */
		
		private var _keyCode:int;
		
		/*
		 * CONSTRUCTOR
		 */
		 
		public function KeyboardControlEvent(type:String, keyCode:int=0) {
			super(type);
			_keyCode = keyCode;
		}
		
		/*
		 * PROPERTIES
		 */
		
		public function get keyCode():int {
			return _keyCode;
		}
	}
	// END CLASS
}
// END PACKAGE