package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	import com.obsesif.ui.UIFactory;

	public class UIInputText extends UIFactory
	{
		private var _back:Sprite;
		private var _password:Boolean = false;
		private var _text:String = "";
		private var _tf:TextField;
		private var _format:TextFormat;
		private var _sizeX:Number;
		private var _sizeY:Number;
		private var _borderC:uint;

		public function UIInputText(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, text:String = "", defaultHandler:Function = null, f:TextFormat=null, sizeX:Number=250, sizeY:Number=22, borderC:uint=0)
		{
			_text = text;
			_sizeX = sizeX;
			_sizeY = sizeY;
			_borderC = borderC;

			if(f==null){
				this._format = new TextFormat("PF Ronda Seven", 8, 0xaa0000);
			}else{
				this._format = f;
			}
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
		}

		override protected function init():void
		{
			super.init();
			setSize(_sizeX, _sizeY);
		}

		override protected function addChildren():void
		{
			_back = new Sprite();
			addChild(_back);

			_tf = new TextField();
			_tf.embedFonts = true;
			_tf.selectable = true;
			_tf.type = TextFieldType.INPUT;
			_tf.defaultTextFormat = this._format;
			addChild(_tf);
			_tf.addEventListener(Event.CHANGE, onChange);

		}

		override public function draw():void
		{
			super.draw();
			_back.graphics.clear();
			_back.graphics.lineStyle(1, _borderC, 0.5);
			_back.graphics.beginFill(0xffffff);
			_back.graphics.drawRoundRect(0, 0, _width, _height, 20);
			_back.graphics.endFill();

			_tf.displayAsPassword = _password;

			_tf.text = _text;
			_tf.width = _width - 4;
			if(_tf.text == "")
			{
				_tf.text = "X";
				_tf.height = Math.min(_tf.textHeight + 4, _height);
				_tf.text = "";
			}
			else
			{
				_tf.height = Math.min(_tf.textHeight + 4, _height);
			}
			_tf.x = 2;
			_tf.y = Math.round(_height / 2 - _tf.height / 2);
		}

		private function onChange(event:Event):void
		{
			_text = _tf.text;
		}

		public function set text(t:String):void
		{
			_text = t;
			invalidate();
		}
		public function get text():String
		{
			return _text;
		}

		public function set restrict(str:String):void
		{
			_tf.restrict = str;
		}
		public function get restrict():String
		{
			return _tf.restrict;
		}

		public function set maxChars(max:int):void
		{
			_tf.maxChars = max;
		}
		public function get maxChars():int
		{
			return _tf.maxChars;
		}

		public function set password(b:Boolean):void
		{
			_password = b;
			invalidate();
		}
		public function get password():Boolean
		{
			return _password;
		}
	}
}