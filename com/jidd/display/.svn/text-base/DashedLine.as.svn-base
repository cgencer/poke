/*
name: DashedLine
type: class extends Shape
package: com.jidd.display

description: This is a bitmap shape.
It is a way to draw a true pixel for pixel dashed line.
It uses a repeating bitmap tile to achieve the effect.
The greatest of the width and height properties is used as the length of the line.
The least of these properties is used as the thickness.
Also, the color property is a 6 digit string to not have to worry about the hexidecimal alpha value.

author:			jimisaacs
author uri:		http://ji.dd.jimisaacs.com
*/

// START PACKAGE
package com.jidd.display {
	
	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	// START CLASS
	public class DashedLine extends Shape {

		/*
		 * VARIABLES
		 */
		
		private var _dash:Number;
		private var _space:Number;
		private var _width:Number;
		private var _height:Number;
		private var _color:String;
				
		/*
		 * CONSTRUCTOR
		 */
		
		public function DashedLine(dash:Number = 1, space:Number = 1, w:Number = 100, h:Number = 1, color:String = "000000") {
			_dash = dash;
			_space = space;
			_width = w;
			_height = h;
			this.color = color;
		}

		public function draw():void {
			 // get the line weight
			var weight:Number = (_width < _height) ? _width : _height;
			//
			// there are errors in some browsers if a bitmap data is drawn less than one pixel!!! Nameley IE!
			if (_dash+_space > 1 && weight > 0) {
				// clear the line
				graphics.clear();
				// draw the tile
				var tile:BitmapData = new BitmapData(_dash+_space, weight + 1, true);
				var r1:Rectangle = new Rectangle(0, 0, _dash, weight);
				tile.fillRect(r1, Number("0xFF"+_color));
				var r2:Rectangle = new Rectangle(_dash, 0, _dash+_space, weight);
				tile.fillRect(r2, 0x00000000);
				// draw the line and fill it with the repeating tile
				graphics.beginBitmapFill(tile, null, true);
				graphics.drawRect(0, 0, _width, _height);
				graphics.endFill();
			}
		}

		/*
		 * PROPERTIES
		 */
		
		// dash
		public function get dash():Number {
			return _dash;
		}
		public function set dash(v:Number):void {
			_dash = v;
			draw();
		}
		
		// space
		public function get space():Number {
			return _space;
		}
		public function set space(v:Number):void {
			_space = v;
			draw();
		}
		
		// width
		override public function get width():Number {
			return _width;
		}
		override public function set width(v:Number):void {
			_width = v;
			draw();
		}
		
		// height
		override public function get height():Number {
			return _height;
		}
		override public function set height(v:Number):void {
			_height = v;
			draw();
		}
		
		// color
		public function get color():String {
			return _color;
		}
		public function set color(v:String):void {
			if(v.indexOf("#") >= 0) {
				_color = v.split("#").pop();
			} else {
				_color = v;
			}
			draw();
		}
	}
	// END CLASS
}
// END PACKAGE