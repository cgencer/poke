package com.obsesif.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class LineMarker extends Sprite
	{
		public var _toggle:Boolean = false;
		private var _s:Sprite;

		private var _roominfo:Object	= {};

		private static var _marked:Number = -1;

		public static var lastMarkedS:Sprite;
		public static var lastMarkedP:LineMarker;
		public static var selectedRoom:String;
		public static var selectedRoomObj:Object;

		public function LineMarker(roominfo:Object)
		{
			this._roominfo = roominfo;

			_s = new Sprite();
			addChild(_s);
			_s.graphics.beginFill(0x333399);
			_s.graphics.drawRect(0, 0, 10, 10);
			_s.alpha = 0;

			_s.addEventListener(MouseEvent.MOUSE_OVER, fadein, false, 0, true);
			_s.addEventListener(MouseEvent.MOUSE_OUT, fadeout, false, 0, true);
			_s.addEventListener(MouseEvent.CLICK, mclick, false, 0, true);
			if(roominfo.handler)
				addEventListener(MouseEvent.CLICK, roominfo.handler, false, 0, true);
		}

		private function fadein(e:MouseEvent) :void
		{
			e.target.alpha = !e.target.parent._toggle ? 0.3 : 0;
		}
		private function fadeout(e:MouseEvent) :void
		{
			e.target.alpha = !e.target.parent._toggle ? 0 : 0.3;
		}

		private function mclick(e:MouseEvent) :void
		{
			if(LineMarker.lastMarkedS){
				(LineMarker.lastMarkedS as Sprite).alpha = 0;
				(LineMarker.lastMarkedP as LineMarker)._toggle = false;
			}

			e.target.alpha = 0.3;
			e.target.parent._toggle = true;
			LineMarker.selectedRoom = (e.target.parent as LineMarker).id;
			LineMarker.selectedRoomObj = (e.target.parent as LineMarker).roomObj;

			LineMarker.lastMarkedS = Sprite(e.target);
			LineMarker.lastMarkedP = LineMarker(e.target.parent);
		}

		public function setSize(w:Number, h:Number):void
		{
			_s.width = w;
			_s.height = h;
		}

		public function get num() :Number			{	return(this._roominfo.no);					}
		public function get roomObj() :Object		{	return(this._roominfo.roomObj);			}
		public function get id() :String				{	return(this._roominfo.roomObj.id);		}
		public function get title() :String			{	return(this._roominfo.roomObj.title);	}
		public function get type() :String			{	return(this._roominfo.roomObj.type);	}
		public function get pass() :String			{	return(this._roominfo.roomObj.pass);	}
		public function get sfid() :String			{	return(this._roominfo.roomObj.sfid);	}
		public function get level() :Number			{	return(this._roominfo.roomObj.level);	}
	}
}