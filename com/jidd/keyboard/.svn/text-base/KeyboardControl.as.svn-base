/*
name: KeyboardControl
type: class extends EventDispatcher
package: com.jidd.keyboard

description: KeyboardControl is an alternative to regular key listeners.
This class treats keyboard events differently than the regular builtin KeyboardEvent events.
It treats them more appropraitly for game design and alike.
The differences are in how the events are dispatched.
For instance they are not dispatched on the increment normally dispatched by your keyboard itself to flash.
They are instead dispatched at either your framerate, or a specified time increment in milliseconds.
The dispatching starts as soon as a key is pressed, with no usual keyboard first key hit delay.
The KEY_UP and KEY_DOWN events do not dispatch except when these events actually happen.
Meaning the KEY_DOWN is dispatched once when any key is pressed
The KEY_UP is dispatched once when the last of all of the keys are released.

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
package com.jidd.keyboard {
	
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.display.Stage;
	import flash.display.InteractiveObject;
	
	import com.jidd.events.KeyboardControlEvent;
	
	// START CLASS
	public class KeyboardControl extends EventDispatcher {
		
		/*
		 * VARIABLES
		 */
		
		private static var _stage:Stage;
		
		private static var _keysDown:Dictionary = new Dictionary(true);
		private static var _numKeysDown:int = 0;
		
		// numKeysDown (read-only)
		public static function get numKeysDown():int {
			return _numKeysDown;
		}
		
		// keysDown (read-only)
		public static function get keysDown():Dictionary {
			return _keysDown;
		}
		
		private var _obj:InteractiveObject;
		private var _useFrames:Boolean;
		private var _timer:Timer;
		
		/*
		 * CONSTRUCTOR
		 */
		
		public function KeyboardControl(obj:InteractiveObject, initUseFrames:Boolean=true, increment:int=0) {
			_obj = obj; 
			if(!_stage) {
				try {
					_stage = Stage(_obj);
				} catch (error:TypeError) {
					_stage = _obj.stage;
				} catch (error:ReferenceError) {
					throw(new ReferenceError("To use KeyboardControl with Object, "+obj+" must be added to stage!"));
					return void;
				}
			}
			_useFrames = initUseFrames;
			if(!_useFrames) {
				if(increment <= 0) increment = 1000 / _stage.frameRate;
				_timer = new Timer(increment);
				_timer.addEventListener(TimerEvent.TIMER, tick, false, 0, true);
			}
			_obj.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);
			_obj.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp, false, 0, true);
		}
		
		/*
		 * LISTENERS
		 */
		
		/* Event.ENTER_FRAME - TimerEvent.TIMER */
		private function tick(e:Event):void {
			if(_numKeysDown>0) {
				for(var code in _keysDown) {
					dispatchEvent(new KeyboardControlEvent(KeyboardControlEvent.key(code), code));
				}
				dispatchEvent(new KeyboardControlEvent(KeyboardControlEvent.ANY, code));
			}
		}
		
		/* KeyboardEvent.KEY_UP */
		private function handleKeyUp(e:KeyboardEvent):void {
			if(!_keysDown[e.keyCode])  return;
			_keysDown[e.keyCode] = null;
			delete _keysDown[e.keyCode];
			_numKeysDown--;
			if(_numKeysDown<=0) {
				if(_useFrames) {
					_stage.removeEventListener(Event.ENTER_FRAME, tick);
				} else {
					_timer.stop();
					_timer.reset();
				}
				dispatchEvent(new KeyboardControlEvent(KeyboardControlEvent.KEY_UP, e.keyCode));
			}
		}
		
		/* KeyboardEvent.KEY_DOWN */
		private function handleKeyDown(e:KeyboardEvent):void {
			if(_keysDown[e.keyCode])  return;
			if(_numKeysDown<=0) {
				dispatchEvent(new KeyboardControlEvent(KeyboardControlEvent.KEY_DOWN, e.keyCode));
				if(_useFrames) {
					_stage.addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
				} else {
					_timer.start();
				}
			}
			_keysDown[e.keyCode] = true;
			_numKeysDown++;
			tick(null);
		}
		
		/*
		 * PROPERTIES
		 */
		
		// obj (read-only)
		public function get obj():InteractiveObject {
			return _obj;
		}
		public function set obj(v:InteractiveObject):void {
			_obj.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			_obj.removeEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			_obj = v;
			_obj.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);
			_obj.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp, false, 0, true);
		}
		
		// useFrames (read-only)
		public function get useFrames():Boolean {
			return _useFrames;
		}
		
		// increment
		public function get increment():uint {
			if(!_useFrames) {
				return null;
			}
			return _timer.delay;
		}
		public function set increment(val:uint):void {
			if(!_useFrames) {
				_timer.delay = val;
			}
		}
	}
	// END CLASS
}
// END PACKAGE