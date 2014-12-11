/**
 * CheckBox.as
 * Keith Peters
 * version 0.93
 *
 * A basic CheckBox component.
 *
 * Copyright (c) 2008 Keith Peters
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.bit101.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class CheckBox extends Component
	{
      [Embed(source="/assets/UIElements.swf", symbol="checkmark")]
      private var rawCheckmark:Class;

		private var _back:Sprite;
		private var _button:Sprite;
		private var _label:Label;
		private var _labelText:String = "";
		private var _selected:Boolean = false;
		private var _cb:Sprite;
		private var _dh:Function;

		public static var _instances:Array = []

		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this CheckBox.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label String containing the label for this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function CheckBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, label:String = "", defaultHandler:Function = null, scale:Number = 1)
		{
			_labelText = label;
			super(parent, xpos, ypos);
			this._dh = defaultHandler;
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
			scaleX = scale;
			scaleY = scale;
			CheckBox._instances.push(this);
		}

		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			buttonMode = true;
			useHandCursor = true;
			setSize(10, 10);
		}

		/**
		 * Creates the children for this component
		 */
		override protected function addChildren():void
		{
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			addChild(_back);

			_button = new Sprite();
			_button.visible = false;
			addChild(_button);

			_label = new Label();
			addChild(_label);

			addEventListener(MouseEvent.CLICK, onClick);
		}




		///////////////////////////////////
		// public methods
		///////////////////////////////////
		public function fireMe():void
		{
			this._dh();
		}

		public function disToggle():void
		{
			for(var s:String in CheckBox._instances){
				if(CheckBox._instances[s] != this){
					(CheckBox._instances[s] as CheckBox).selected = false;
				}
			}
		}

		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_back.graphics.clear();
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();

//			_button.graphics.clear();
//			_button.graphics.beginFill(Style.BUTTON_FACE);
//			_button.graphics.drawRect(2, 2, _width - 4, _height - 4);
			_cb = new rawCheckmark();
			_button.addChild(_cb);
			_cb.y = -5;
			_cb.x = -2;

			_label.text = _labelText;
			_label.x = _width + 2;
			_label.y = _height / 2 - _label.height / 2;
		}




		///////////////////////////////////
		// event handler
		///////////////////////////////////

		/**
		 * Internal click handler.
		 * @param event The MouseEvent passed by the system.
		 */
		private function onClick(event:MouseEvent):void
		{
			disToggle();
			_selected = !_selected;
			_button.visible = _selected;
		}




		///////////////////////////////////
		// getter/setters
		///////////////////////////////////

		/**
		 * Sets / gets the label text shown on this CheckBox.
		 */
		public function set label(str:String):void
		{
			_labelText = str;
			invalidate();
		}
		public function get label():String
		{
			return _labelText;
		}

		/**
		 * Sets / gets the selected state of this CheckBox.
		 */
		public function set selected(s:Boolean):void
		{
			_selected = s;
			_button.visible = s;
			invalidate();
		}
		public function get selected():Boolean
		{
			return _selected;
		}
		public function get instances():Array
		{
			return CheckBox._instances;
		}

	}
}