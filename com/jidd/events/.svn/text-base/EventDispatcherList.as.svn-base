/**
name: EventDispatcherList
type: class 
package: com.jidd.events

description: EventDispatcherList is simply a list of EventDispatchers
Any listener added to the list is added to each item.
Anything listener removed is removed from each item.
Individual items can still have unique listeners of the same event type.
The listener callBacks are saved in a dictionary for later use.
For example, the property 'listeners' returns an array of the listeners' Dicionary.

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
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	// START CLASS
	public class EventDispatcherList {
		
		/*
		 * VARIABLES
		 */
		
		private var _dispatchers:Dictionary;
		private var _listeners:Dictionary;
		
		/*
		 * CONSTRUCTOR
		 */
		
		/* param rest: any list of arguments that are event dispatchers */
		public function EventDispatcherList(... rest) {
			_dispatchers = new Dictionary(true);
			_listeners = new Dictionary(true);
			for(var i:uint=0 ; i<rest.length ; i++) {
				this.add(rest[i]);
			}
		}
		
		/* clear the listeners from the dictionary */
		private function removeDictListeners():void {
			for(var obj:* in _dispatchers) {
				for (var callBack:* in _listeners) {
					EventDispatcher(obj).removeEventListener(_listeners[callBack], callBack);
				}
			}
		}
		
		/*
		 * METHODS
		 */
		
		/* this method allows adding static listeners */
		public function addEventListener(type:String, callBack:Function, useCapture:Boolean=false, priority:int=0, useWeekreference:Boolean=true):void {
			for(var obj:* in _dispatchers) {
				EventDispatcher(obj).addEventListener(type, callBack, useCapture, priority, useWeekreference);
			}
			_listeners[callBack] = {type:type, useCapture:useCapture, priority:priority, useWeekreference:useWeekreference};
		}
		
		/* this method allows removing static listeners */
		public function removeEventListener(type:String, callBack:Function):void {
			for(var obj:* in _dispatchers) {
				EventDispatcher(obj).removeEventListener(type, callBack);
			}
			_listeners[callBack] = null;
			delete _listeners[callBack];
		}
		
		/* this method allows dispatching static listeners
		(this is usually not used specifically with this class but for more of extending purposes)
		It forces all items in the list to dispatch a specified event at the same time */
		public function dispatchEvent(event:Event):Boolean {
			for(var obj:* in _dispatchers) {
				var AllDispatched:Boolean = EventDispatcher(obj).dispatchEvent(event);
			}
			return AllDispatched;
		}
		
		/* add object to the dictionary */
		public function add(obj:EventDispatcher):EventDispatcher {
			_dispatchers[obj] = true;
			for (var callBack:* in _listeners) {				
				obj.addEventListener(_listeners[callBack].type, callBack, _listeners[callBack].useCapture, _listeners[callBack].priority, _listeners[callBack].useWeekreference);
			}
			return obj;
		}
				
		/* remove object from the dictionary */
		public function remove(obj:EventDispatcher):EventDispatcher {
			for (var callBack:* in _listeners) {
				obj.removeEventListener(_listeners[callBack], callBack);
			}
			_dispatchers[obj] = null;
			delete _dispatchers[obj];
			return obj;
		}
		
		/* clear all the dictionaries */
		public function clear():void {
			removeDictListeners();
			_dispatchers = new Dictionary();
			_listeners = new Dictionary();
		}
		
		/* clone this instance */
		public function clone():EventDispatcherList {
			var clone:EventDispatcherList = new EventDispatcherList();
			for(var obj:* in _dispatchers) {
				clone.add(obj);
			}
			for(var callBack:* in _listeners) {
				clone.addEventListener(_listeners[callBack].type, callBack, _listeners[callBack].useCapture, _listeners[callBack].priority, _listeners[callBack].useWeekreference);
			}
			return clone;
		}
		
		/*
		 * PROPERTIES
		 */
		
		// dispatchers
		public function get items():Array {
			var arr:Array = [];
			for(var obj:* in _dispatchers) {
				arr.push(obj);
			}
			return arr;
		}
		public function set items(arr:Array):void {
			removeDictListeners();
			_dispatchers = new Dictionary();
			for each(var i:EventDispatcher in arr) {
				this.add(arr[i]);
			}
		}
		
		// listeners
		public function get listeners():Array {
			var arr:Array = [];
			for(var callBack:* in _listeners) {
				var obj:Object = _listeners[callBack];
				obj['callBack'] = callBack;
				arr.push(obj);
			}
			return arr;
		}
	}
	// END CLASS
}
// END PACKAGE