package com.obsesif.game
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	import flash.net.LocalConnection;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.obsesif.ui.UIButton;
	import com.obsesif.ui.UIChatBox;
	import com.obsesif.ui.UILogBox;
	import com.obsesif.ui.UIBuddiesBox;
	import com.obsesif.ui.UIModeratorBox;
	import com.obsesif.events.impEvent;

	public class gBase extends Sprite
	{
		[Embed(source="/assets/nback.jpg")]
		private var lobbyBack:Class;
		
		[Embed(source="/assets/UIElements.swf", symbol="memberships")]
		private var memberships:Class;

		private var _bb:UIBuddiesBox;
		private var _mb:UIModeratorBox;
		private var _lb:UILogBox;
		private var _lb2:UILogBox;
		public var _cb:UIChatBox;
		private var _msg:String;
		private var _section:String;
		private var _br:UIButton;
		private var _muted:Boolean;
		private var _ms:Sprite;
		private var _kickuButton:Sprite;
		private var _msButton:Sprite;
		private var _kickWindow:Sprite;
		private var _kickButton:UIButton;
		private var _kickClose:UIButton;
		private var _kUser:TextField;
		private var _storekUserID:Number;
		private var _storekUserTitle:String;
		private var _storekUserLevel:Number;

		public function gBase(s:String) :void
		{
			this._section = s;
			var pic:Bitmap = new lobbyBack();
			addChild(pic);

// http://www.zukaa.com/gwJson.aspx?cmd=getBack
/*
			for (var y:Number=0; y<5; y++){
				for (var x:Number=0; x<7; x++){
					var pic:Bitmap = new lobbyBack();
					addChild(pic);
					pic.x = pic.width*x;
					pic.y = pic.height*y;
					pic.alpha = 0.7;
				}
			}

			var up:Shape = new Shape();
			up.graphics.beginFill(0xddddff);
			up.graphics.drawRect(0, 0, 960, 75);
			up.alpha = 0.3;
			addChild(up);

			var line:Shape = new Shape();
			line.graphics.lineStyle(1, 0xffffff, 0.5);
			line.graphics.moveTo(0, 75);
			line.graphics.lineTo(960, 75);
			addChild(line);

			var lg:Sprite = new rawLogo();
			addChild(lg);
			lg.scaleX *= 2;
			lg.scaleY *= 2;
			lg.x = 45;
			lg.y = 10;
*/

			if(this._section == 'TABLE'){
				_cb = new UIChatBox(this, /*675*/700, 410, 'TABLE', this._muted);
				_cb.addEventListener('MESSAGE', textEntered);
				_lb = new UILogBox(this, 10, 420);
				_lb2 = new UILogBox(this, 150, 420, 'TABLE', 'u');
				
				
				// Membership Image
				_ms = new memberships();
				_ms.x = 160;
				_ms.y = 446;
				this.addChild(_ms);
				_msButton = new Sprite();
				_msButton.x = 160;
				_msButton.y = 446;
				_msButton.buttonMode = true;
				_msButton.useHandCursor = true;
				_msButton.graphics.beginFill(0xff0000);
				_msButton.graphics.drawRect(0, 0, 100, 137);
				_msButton.graphics.endFill();
				_msButton.alpha = 0;
				_msButton.addEventListener(MouseEvent.CLICK, memberLink);
				this.addChild(_msButton);
				
				//Moderator kickbox
				_kickWindow = new Sprite();
				_kickWindow.x = 660; //75
				_kickWindow.y = 80;
				_kickWindow.graphics.beginFill(0x44687D);
				_kickWindow.graphics.drawRoundRect(0, 0, 150, 75, 10);
				_kickWindow.graphics.endFill();
				_kickWindow.alpha = .85;
				_kickWindow.visible = false;
				this.addChild(_kickWindow);
				
				var frm:TextFormat = new TextFormat();
				frm.font = "AirSansBold";
				frm.color = 0xffffff;
				frm.size = 14;
				frm.align = TextFormatAlign.CENTER;

				_kUser = new TextField();
				_kUser.width = 150;
				_kUser.embedFonts = true;
				//_kUser.autoSize = 'left';
				_kUser.selectable = false;
				_kUser.antiAliasType = AntiAliasType.ADVANCED;
				_kUser.defaultTextFormat = frm;
				_kUser.x = 0;
				_kUser.y = 10;
				_kUser.text = 'User';
				_kickWindow.addChild(_kUser);
				
				_kickuButton = new Sprite();
				_kickuButton.x = 10;
				_kickuButton.y = 10;
				_kickuButton.graphics.beginFill(0xff0000);
				_kickuButton.graphics.drawRoundRect(0, 0, 130, 20, 10);
				_kickuButton.graphics.endFill();
				_kickuButton.alpha = 0;
				_kickuButton.buttonMode = true;
				_kickuButton.useHandCursor = true;
				_kickuButton.addEventListener(MouseEvent.CLICK, modProfileView);
				_kickWindow.addChild(_kickuButton);
				
				_kickButton = new UIButton(_kickWindow,  20, 50, "At", 'button', actualKick, .4, .6, 1, new TextFormat('AirSans', 14, 0xffffff));
				_kickClose = new UIButton(_kickWindow,  80, 50, "Kapat", 'button', closeKickWindow, .4, .6, 1, new TextFormat('AirSans', 14, 0xffffff));

				
				main.log.info('####AM I FIRST?');
				if(Number(main._me['mod']) >0 || main._me['membershipType'] > 1 || main._me['amiowner'] == true){	
					_br = new UIButton(this,  820, 50, "odadakiler", 'button', roomers, 1, .8, 3, new TextFormat('AirSans', 14, 0xffffff));
				}

			}else{
				_cb = new UIChatBox(this, 20, 420, 'LOBBY', this._muted);
				_cb.addEventListener('MESSAGE', textEntered);

				_bb = new UIBuddiesBox(this, 445, 420);
				_bb.addEventListener('BUDDY_CLICKED', buddyClicked);
			}
		}

		public function buildModListonTop() :void
		{
			_mb = new UIModeratorBox(this, 815, 80);
			_mb.addEventListener('MODLIST_CLICKED', modListClicked);
			_mb.visible = false;
		}

		private function roomers(e:MouseEvent) :void
		{
			_mb.visible = !_mb.visible;
		}

		private function modListClicked(e:impEvent) :void
		{
			if(Number(main._me['mod']) > 0 || main._me['amiowner'] == true) {
				this._kickWindow.visible = true;
				this._kUser.text = e.params.title;
				this._storekUserID = e.params.sfid;
				this._storekUserLevel = e.params.level;
				this._storekUserTitle = e.params.title;
			}
			/*
			if(Number(main._me['mod']) > 0) {
				e.target.parent.dispatchEvent(new impEvent('MOD_KICK', {sfid: e.params.sfid, level: e.params.level}));
			}
			*/
		}
		
		private function closeKickWindow(e:MouseEvent):void {
			this._kickWindow.visible = false;
		}
		
		private function actualKick(e:MouseEvent) :void
		{
			if(Number(main._me['mod']) > 0 || main._me['amiowner'] == true) {
				this.dispatchEvent(new impEvent('MOD_KICK', {sfid: this._storekUserID, level: this._storekUserLevel}));
				this._kickWindow.visible = false;
			}
		}
		
		private function modProfileView(e:MouseEvent):void {
			var targetURL:String = "http://www.zukaa.com/" + this._storekUserTitle;
			var req:URLRequest = new URLRequest(targetURL);
			navigateToURL(req, "_blank");
		}

		private function buddyClicked(e:impEvent) :void
		{
			e.target.parent.dispatchEvent(new impEvent('BUDDY_CLICKED', {id: e.params.id, pass: e.params.pass}));
		}

		public function buildBuddyList(im:Array) :void
		{
			im.sortOn(['isOnline', 'name'], [Array.DESCENDING, Array.CASEINSENSITIVE]);
			_bb.cleanContent();
			for(var s:String in im){
				_bb.addContent(im[s].urim, Number(im[s].inRoom), im[s].password);
			}
		}

		public function buildModList(im:Array) :void
		{
			im.sortOn(['name'], [Array.DESCENDING, Array.CASEINSENSITIVE]);
			_mb.cleanContent();
			for(var s:String in im){
				_mb.addContent(im[s].name, im[s].sfid, im[s].level, im[s].userId);
			}
		}

		public function addChatContent(c:String, t:String='public', s:Number = -1) :void
		{
//			main.log.info('addChatContent with name' + main._me.uri);
			_cb.addContent(c, t, s);
//			main.log.info('Message received!')
			//clearInput();
		}

		public function clearInput() :void
		{
			_cb.clearInput();
		}

		public function addLogContent(c:String) :void
		{
			_lb.addContent(c);
		}

		public function textEntered(e:impEvent) :void
		{
			main.log.info('textEntered');
			_cb.addContent((main._me.uri + ':!#' + e.params.message), 'public', 0);
			_cb.clearInput();
			e.target.parent.dispatchEvent(new impEvent('MESSAGE_UP', {screen: e.params.screen, target: e.params.target, message: e.params.message}));
		}

		public function gcHack():void
		{
			try {
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			} catch (e:Error) {}
		}

		public function writeLine(p:Sprite, t:String, w:Number, f:String="AirSans", c:uint=0xffffff, s:Number=24, xpos:Number=10, ypos:Number=10) :void
		{
			var _format:TextFormat = new TextFormat();
			_format.font = f;
			_format.color = c;
			_format.size = s;
			_format.align = TextFormatAlign.LEFT;

			var _header:TextField = new TextField();
			_header.width = w;
			_header.embedFonts = true;
			_header.wordWrap = true;
			_header.selectable = false;
			_header.antiAliasType = AntiAliasType.ADVANCED;
			_header.defaultTextFormat = _format;
			_header.text = t;
			_header.x = xpos;
			_header.y = ypos;
			p.addChild(_header);
		}
		
		private function memberLink(e:Event):void {
			var targetURL:String = "http://www.zukaa.com/packages.aspx";
			var req:URLRequest = new URLRequest(targetURL);
			navigateToURL(req, "_blank");
		}
		
		public function ownerHere():void {
			if(main._me['amiowner'] == true){	
				_br = new UIButton(this,  820, 50, "odadakiler", 'button', roomers, 1, .8, 3, new TextFormat('AirSans', 14, 0xffffff));
			}
		}

	}
}
