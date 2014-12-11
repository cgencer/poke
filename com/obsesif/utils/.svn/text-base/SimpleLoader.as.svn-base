package com.obsesif.utils
{
	import flash.display.Loader;
	import flash.events.Event;


	/**
	 * class SimpleLoader
	 *
	 * @author negush
	 */
	public class SimpleLoader extends Loader {

		/**
		 * The width and height setters have effect only after the content has been loaded.
		 */

		private var _scale:Boolean = false;
		private var _width:Number = 0;
		private var _height:Number = 0;

		private var scaleRatio:Number;


		/**
		 * Constructor.
		 */
		public function SimpleLoader() {
			super();
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
		}


		/**
		 * Handler function for the Event.COMPLETE event. Initializes the width and height of the
		 * content and calculates the scale ratio of the image, used when the loader is resized
		 * with the content being scaled. Catches the Loader's event and dispatches it as SimpleLoader.
		 */
		private function completeHandler(evt:Event):void {
			// The initial size of the content.
			this._width = this.contentLoaderInfo.width;
			this._height = this.contentLoaderInfo.height;
			// The scale ratio content_width / content_height.
			this.scaleRatio = this.contentLoaderInfo.width / this.contentLoaderInfo.height;
			if (this.scale) scaleToWidth();
			var newEvent:Event = new Event(Event.COMPLETE);
			dispatchEvent(evt);
		}


		/**
		 * Resizes the loader keeping the aspect ratio according to the new width. In this case the
		 * new height is calculated so that the content keeps its aspect ratio according to the
		 * loader's new width.
		 */
		private function scaleToWidth():void {
			this._height = Math.round(this.width / this.scaleRatio);
			super.width = this._width;
			super.height = this._height;
		}


		/**
		 * Resizes the loader keeping the aspect ratio according to the new height. In this case the
		 * new width is calculated so that the content keeps its aspect ratio according to the
		 * loader's new height.
		 */
		private function scaleToHeight():void {
			this._width = Math.round(this.height * this.scaleRatio);
			super.width = this._width;
			super.height = this._height;
		}


		//***********************************************************************
		//
		//	getters and setters
		//
		//***********************************************************************

		/**
		 * Setter/getter for the _scale property. Activates or deactivates the scaling for the
		 * current loader instance. If the scale is set to true, the content's height will be
		 * recalculated so that the content keeps the current width but will have the original
		 * aspect ratio.
		 *
		 * true = resize keeping content aspect ratio
		 * false = resize without keeping content aspect ratio
		 *
		 */
		public function set scale(value:Boolean):void {
			if (this._scale == value) return;
			this._scale = value;
			if (value) scaleToWidth();
		}

		public function get scale():Boolean {
			return this._scale;
		}


		/**
		 * Overrides the Loader's width setter and getter. The setter resizes the content
		 * according to the scale property's value.
		 */
		override public function set width(value:Number):void {
			if (this._width == value) return;
			this._width = value;
			if (this.scale) scaleToWidth();
			else super.width = value;
		}

		override public function get width():Number {
			return this._width;
		}


		/**
		 * Overrides the Loader's height setter and getter. The setter resizes the content
		 * according to the scale property's value.
		 */
		override public function set height(value:Number):void {
			if (this._height == value) return;
			this._height = value;
			if (this.scale) scaleToHeight();
			else super.height = value;
		}

		override public function get height():Number {
			return this._height;
		}

	}

}