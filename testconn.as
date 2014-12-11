package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.net.NetConnection;
	import flash.net.Responder;

	[SWF(width="500", height="400", backgroundColor="#495865")]

	public class main extends Sprite
	{
		[Embed(source="/assets/AIRSANS.TTF", fontName="AirSans", mimeType="application/x-font")]
		private var AirSans:Class;
		private var gateway:String = 'http://zukaa.com/weborb.aspx';
		private var nc:NetConnection;
		private var rp:Responder;

		public function main() :void
		{
			writeLine(this, 10, 10, "testing connection...");

			rp = new Responder(onResult, onFault);
			gonder('userList', rp, {value:'test'});
		}

		private function gonder(cmd:String, resp:Responder, par:Object) :void
		{
			nc = new NetConnection;
			nc.connect(gateway);
			nc.call('WebOrbZukaa.PokerService.'+cmd, resp, par);
		}

		public function onResult(res:Object):void{
			writeLine(this, 10, 30, "r: "+res[0]);
		}

		public function onFault(res:Object):void{
			var i:Number=50;
			for(var s:String in res){
				writeLine(this, 10, i, "f: "+s+"-"+String(res[s]));
				i+=75;
			}
		}

		public function getComputerInfo() :void
		{
//			var pendingCall = computerInfoService.getComputerInfo( reqID++ );
//			pendingCall.responder = new mx.rpc.RelayResponder( this, "computerInfoRetrieved", "callFailed" );
		}

		public function writeLine(p:Sprite, posx:Number, posy:Number, content:String, size:Number=10, color:uint=0xffffff) :void
		{
			var format:TextFormat = new TextFormat();
			format.font = "AirSans";
			format.color = color;
			format.size = size;

			var _linecol:TextField = new TextField();
			_linecol.embedFonts = true;
			_linecol.autoSize = 'left';
			_linecol.wordWrap = true;
			_linecol.width=450;
			_linecol.antiAliasType = AntiAliasType.ADVANCED;
			_linecol.defaultTextFormat = format;
			_linecol.text = content;
			_linecol.x = posx;
			_linecol.y = posy;
			p.addChild(_linecol);
		}
	}
}