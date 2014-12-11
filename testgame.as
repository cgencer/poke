package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import com.obsesif.models.mRoom;

	[SWF(width="250", height="600", backgroundColor="#495865")]

	public class main extends Sprite
	{
		public var mu:mRoom;

		[Embed(source="/assets/AIRSANS.TTF", fontName="AirSans", mimeType="application/x-font")]
		private var AirSans:Class;

		public function main() :void
		{
			writeLine(this, 10, 10, "testing suite...", 16);

			mu	= mRoom.getInstance();
			mu.boot('poker', '78.159.112.75');
			mu.addEventListener('ROOMS_LOADED',		multiuserBooted);
			mu.addEventListener('ROOMS_READY',		roomsBooted);
			mu.addEventListener('CARDS_ARRIVED',	gotCards);
			mu.addEventListener('CARDS_EVALUATED',	calculated);
			mu.addEventListener('CALC_ARRIVED',		gotCalc);
		}

		private function multiuserBooted(e:Event) :void
		{
			mu.removeEventListener('ROOMS_LOADED', multiuserBooted);
		}

		private function roomsBooted(e:Event) :void
		{
			mu.removeEventListener('ROOMS_READY', roomsBooted);
		}

		private function calculated(e:Event) :void
		{
			mu.addEventListener('CARDS_EVALUATED',calculated);
		}

		private function gotCalc(e:Event) :void
		{
			mu.removeEventListener('CALC_ARRIVED', gotCalc);

			writeLine(this, 10, 250, "player "+String(mu.whoWins())+" wins...");
		}

		private function gotCards(e:Event) :void
		{
			mu.removeEventListener('CARDS_ARRIVED', gotCards);
			var p:Array = mu.cards_player;
			writeLine(this, 10, 30, p[0][0] + ", " + p[0][1]);
			writeLine(this, 10, 45, 'other players:');
			for(var i:Number=1; i<p.length; i++){
				writeLine(this, 10, 45+(i*15), "player "+i+" has : "+p[i][0] + ", " + p[i][1]);
			}
			writeLine(this, 10, 210, "community cards are:");
			var t:Array = mu.cards_table;
			writeLine(this, 10, 230, t[0] + ", " + t[1] + ", " + t[2] + ", [" + t[3] + "], [" + t[4] + "]");

			mu.calculateHands();
		}

		public function writeLine(p:Sprite, posx:Number, posy:Number, content:String, size:Number=12, color:uint=0xffffff) :void
		{
			var format:TextFormat = new TextFormat();
			format.font = "AirSans";
			format.color = color;
			format.size = size;

			var _linecol:TextField = new TextField();
			_linecol.embedFonts = true;
			_linecol.autoSize = 'left';
			_linecol.antiAliasType = AntiAliasType.ADVANCED;
			_linecol.defaultTextFormat = format;
			_linecol.text = content;
			_linecol.x = posx;
			_linecol.y = posy;
			p.addChild(_linecol);
		}
	}
}