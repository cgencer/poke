package com.obsesif.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;

	import com.bit101.components.Slider;
	import com.bit101.components.RadioButton;
	import com.bit101.components.CheckBox;
	import com.obsesif.ui.UIFactory;
	import com.obsesif.ui.UIDropdown;
	import com.obsesif.ui.UIInputText;
	import com.obsesif.events.impEvent;

	public class LobbyPanel extends UIFactory
	{
      [Embed(source="/assets/UIElements.swf", symbol="button")]
      private var rawButton:Class;
      [Embed(source="/assets/UIElements.swf", symbol="panel")]
      private var rawPanel:Class;
      [Embed(source="/assets/UIElements.swf", symbol="winB")]
      private var rawWin:Class;
      [Embed(source="/assets/UIElements.swf", symbol="xon")]
      private var rawXOn:Class;
      [Embed(source="/assets/UIElements.swf", symbol="xoff")]
      private var rawXOff:Class;

		private var panelTypes:Array = ['game', 'vip', 'private', 'tournament'];

		private var _rooms:Object;
		private var _panel:Sprite;
		private var _slider:Slider;
		private var _items:Array;
		private var _handler:Function;
		private var _paneset:Array = [];
		private var _dropdowns:Array = [];
		private var _selectedPane:Number;
		private var _selectedGame:String;
		private var _selectedGameObj:Object;

		private var _x:Number;
		private var _y:Number;
		private var lh:Number;
		private var _newRoom:Sprite;
		private var _newRoomB:Sprite;

		private var maxLines:Number		= 3;
		private var maxWidth:Number		= 666;
		private var marginTop:Number		= 55;
		private var marginLeft:Number		= 6;
		private var borderWidth:Number	= 8;
		private var maxHeight:Number		= 175;

		private var _set:Sprite;
		private var _lr:Number;
		private var _ps:Sprite;
		private var _labelset:Sprite;
		private var _dd1:UIDropdown;
		private var _dd2:UIDropdown;
		private var _dd3:UIDropdown;
		private var _dd4:UIDropdown;
		private var _b1:UIButton;
		private var _b2:UIButton;
		private var _b3:UIButton;
		private var _cb:UIChatBox;
		private var _cFilter1:CheckBox;
		private var _cFilter2:CheckBox;
		private var _cFilter3:CheckBox;
		private var _nrName:UIInputText;
		private var _nrLimit1:RadioButton;
		private var _nrLimit2:RadioButton;
		private var _nrLimit3:RadioButton;
		private var _nrPass:UIInputText;
		private var _nrMin:UIInputText;
		private var _nrMax:UIInputText;
		private var _nrBIMin:UIInputText;
		private var _nrBIMax:UIInputText;
		private var _nrPlayers:UIInputText;
		private var _nrViewers:UIInputText;
		private var _nrTimelimit:UIInputText;
		private var _nrProp:Object;

		private var _nrFlag:Boolean = false;
		private var _ulvl:Number = 0;

		public function LobbyPanel(rooms:Object, parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, ulevel:Number=0) :void
		{
			this._ulvl = ulevel;
			this._x = xpos;
			this._y = ypos;
			this._rooms = rooms;
			super(parent, xpos, ypos);
		}

		override protected function init() :void
		{
			super.init();
		}

		public function refreshPanes() :void
		{
			for (var p:String in _paneset){
				_panel.removeChild( _paneset[p] );
			}

			var _pane:Sprite;
			var j:Number = 1;
			for (var r:Number=0; r<this.panelTypes.length; r++)
			{
				_paneset[ r ] = createPane( this.panelTypes[r] );
				_paneset[ r ].x = 10000;
				_panel.addChild( _paneset[ r ] );
			}

			_pane = _paneset[0];
			_selectedPane = 0;
			_pane.x = 0;

			_slider.minimum = -(_pane.height-maxHeight+2);
			_slider.maximum = 0;
			_slider.value = _slider.maximum;
		}

		override protected function addChildren() :void
		{
			var _panel:Sprite = new Sprite();
			addChild(_panel);

			var _tab1:UIButton = new UIButton(_panel,  20, 0, "Odalar",			'games',			selectTab, 1.1, 1.4);
			var _tab3:UIButton = new UIButton(_panel, 165, 0, "VIP Odalar",	'vip',			selectTab, 1.3, 1.4);
			var _tab4:UIButton = new UIButton(_panel, 335, 0, "Özel Odalar",	'private',		selectTab, 1.3, 1.4);
//			var _tab2:UIButton = new UIButton(_panel, 500, 0, "Turnuvalar",	'tournaments',	selectTab, 1.3, 1.4);

			var _back:Sprite = new rawPanel();
			_back.y = 25;
			_panel.addChild(_back);

			_slider = new Slider(Slider.VERTICAL, this);
			_slider.setSize(20, 145);
			_slider.x = 647;
			_slider.y = 85;
			_slider.alpha = 1;

			writeLine(_panel, {
					lineNo:		0,
					columns:		[marginLeft+10, marginLeft+175, marginLeft+340, marginLeft+505],
					labels:		["Masa", "Kullanıcı", "Giriş (min-max)", "Oyun, blind bedeli"],
					ypos:			62,
					lineWidth:	maxWidth-_slider.width-4,
					marginLeft:	6,
					marginTop:	55,
					maxLines:	1
				}, {color: 0xffffff, size: 14}
			);

			_cFilter1 = new CheckBox(_panel, 540, 40, "Dolu", checkboxClicked, 1.3);
			_cFilter2 = new CheckBox(_panel, 600, 40, "Boş", checkboxClicked, 1.3);
			_cFilter1.selected = false;
			_cFilter2.selected = false;

			if(this._ulvl>4){
				_b1 = new UIButton(_panel,  50, 250, "Oda Kur",	'button', buildRoom);
			}
			_b2 = new UIButton(_panel, 270, 242, "Masaya Git",	'button', joinGame, 1.35, 1.5, 5);
			_b3 = new UIButton(_panel, 510, 250, "Yenile", 'button', lobbyRefresh);

			var _pane:Sprite;
			for each (var r:String in this.panelTypes)
			{
				_pane = createPane(r);
				_pane.x = 10000;
				_panel.addChild(_pane);
				_paneset.push(_pane);
			}

			_pane = _paneset[0];
			_selectedPane = 0;
			_pane.x = 0;

			_slider.minimum = _pane.height-(8*17);		// 8 lines * lineheight+spacer
			_slider.maximum = 0;
			_slider.value = 0;
			_slider.addEventListener(Event.CHANGE, function(e:Event):void{sliderScroll(_slider, _pane);});

			_newRoom = new Sprite();
			addChild(_newRoom);
			_newRoom.visible = false;
			_newRoom.x = 130;
			_newRoom.y = this.y;

			_newRoomB = new rawWin();
			_newRoom.addChild(_newRoomB);
			_newRoomB.scaleY = 1.12;

			var _nrBuild:UIButton = new UIButton(_newRoom, 120, 260, "oda oluştur", 'newroom', _nrCreate);

			var _nrCloseOn:Sprite = new rawXOn();
			_newRoom.addChild(_nrCloseOn);
			_nrCloseOn.x = 300;
			_nrCloseOn.y = 10;
			var _nrCloseOff:Sprite = new rawXOff();
			_newRoom.addChild(_nrCloseOff);
			_nrCloseOff.x = 300;
			_nrCloseOff.y = 10;
			_nrCloseOff.visible = false;

			var _nrCloseButton:Sprite = new Sprite();
			_newRoom.addChild(_nrCloseButton);
			_nrCloseButton.alpha = 0;
			_nrCloseButton.x = 300;
			_nrCloseButton.y = 10;
			_nrCloseButton.graphics.beginFill(0xff0000);
			_nrCloseButton.graphics.drawRect(-1, -1, 30, 30);
			_nrCloseButton.graphics.endFill();
			_nrCloseButton.addEventListener(MouseEvent.MOUSE_OVER, function(e:Event):void{_nrCloseOff.visible = true;});
			_nrCloseButton.addEventListener(MouseEvent.MOUSE_OUT, function(e:Event):void{_nrCloseOff.visible = false;});
			_nrCloseButton.addEventListener(MouseEvent.CLICK, function(e:Event):void{_nrCloseOff.visible = false; closeNewRoomWindow();});

			writeLine(_newRoom, {labels: "Oda İsmi:", xpos: 20, ypos: 15}, {color: 0xffffff, size: 14});
			_nrName = new UIInputText(_newRoom, 130, 15, "", null, new TextFormat("AirSans", 14, 0x000000), 150, 24, 0xffffff);

			writeLine(_newRoom, {labels: "Oyun Tipi:", xpos: 20, ypos: 45}, {color: 0xffffff, size: 14});
			_nrLimit1 = new RadioButton(_newRoom, 130, 55, "No Limit");
			_nrLimit2 = new RadioButton(_newRoom, 200, 55, "Limit");
			_nrLimit3 = new RadioButton(_newRoom, 270, 55, "Pot Limit");

			writeLine(_newRoom, {labels: "Oda Şifresi:", xpos: 20, ypos: 75}, {color: 0xffffff, size: 14});
			_nrPass = new UIInputText(_newRoom, 130, 75, "", null, new TextFormat("AirSans", 14, 0x000000), 100, 24, 0xffffff);

			writeLine(_newRoom, {labels: "Blind'lar:", xpos: 20, ypos: 105}, {color: 0xffffff, size: 14});
			writeLine(_newRoom, {labels: "small", xpos: 130, ypos: 105}, {color: 0xffffff, size: 14});
			_nrMin = new UIInputText(_newRoom, 170, 105, "5", null, new TextFormat("AirSans", 11, 0x000000), 40, 24, 0xffffff);
			//writeLine(_newRoom, {labels: "big", xpos: 220, ypos: 105}, {color: 0xffffff, size: 14});
			//_nrMax = new UIInputText(_newRoom, 250, 105, "10", null, new TextFormat("AirSans", 11, 0x000000), 40, 24, 0xffffff);

/*
			writeLine(_newRoom, {labels: "Para ekleme:", xpos: 20, ypos: 135}, {color: 0xffffff, size: 14});
			writeLine(_newRoom, {labels: "en az", xpos: 130, ypos: 135}, {color: 0xffffff, size: 14});
			_nrBIMin = new UIInputText(_newRoom, 170, 135, "100", null, new TextFormat("AirSans", 11, 0x000000), 55, 24, 0xffffff);
			writeLine(_newRoom, {labels: "en çok", xpos: 227, ypos: 135}, {color: 0xffffff, size: 14});
			_nrBIMax = new UIInputText(_newRoom, 275, 135, "1000", null, new TextFormat("AirSans", 11, 0x000000), 55, 24, 0xffffff);
*/
			writeLine(_newRoom, {labels: "El süresi:", xpos: 20, ypos: 165}, {color: 0xffffff, size: 14});
			_nrTimelimit = new UIInputText(_newRoom, 130, 165, "15", null, new TextFormat("AirSans", 11, 0x000000), 40, 24, 0xffffff);
			writeLine(_newRoom, {labels: "saniye", xpos: 180, ypos: 165}, {color: 0xffffff, size: 14});

/*
			writeLine(_newRoom, {labels: "Oyuncu adedi:", xpos: 20, ypos: 195}, {color: 0xffffff, size: 14});
			_nrPlayers = new UIInputText(_newRoom, 130, 195, "9", null, new TextFormat("AirSans", 11, 0x000000), 40, 24, 0xffffff);
			writeLine(_newRoom, {labels: "izleyici:", xpos: 180, ypos: 195}, {color: 0xffffff, size: 14});
			_nrViewers = new UIInputText(_newRoom, 240, 195, "9", null, new TextFormat("AirSans", 11, 0x000000), 40, 24, 0xffffff);
*/
			_dd1 = new UIDropdown(_panel,  30, 35, 95, ["(oyun)", "tümü", "No Limit", "Limit", "Pot Limit"], 0, null);
			_dd1.addEventListener('FILTER_SET', filterSet);
			_dropdowns.push(_dd1);
			_dd2 = new UIDropdown(_panel, 140, 35, 60, ["(giriş)", "düşük", "yüksek"], 1, null);
			_dd2.addEventListener('FILTER_SET', filterSet);
			_dropdowns.push(_dd2);
			_dd3 = new UIDropdown(_panel, 250, 35, 60, ["(blind)", "düşük", "yüksek"], 2, null);
			_dd3.addEventListener('FILTER_SET', filterSet);
			_dropdowns.push(_dd3);
			_dd4 = new UIDropdown(_panel, 360, 35, 60, ["(oyuncu)", "az", "çok"], 3, null);
			_dd4.addEventListener('FILTER_SET', filterSet);
			_dropdowns.push(_dd4);
/*
			_dd3 = new UIDropdown(_panel, 270, 35, ["Boş Masa", "Dolu Masa"], 2, pulldownClicked);
			_dropdowns.push(_dd3);
*/
			addEventListener('CLOSE_PULLDOWNS', closePulldowns);
		}

		private function filterSet(e:impEvent) :void
		{
			e.target.parent.parent.parent.dispatchEvent(new impEvent('FILTER_SET', {menu: e.params.menu, item: e.params.item}));
		}

		private function checkboxClicked(e:Event) :void
		{
			main.log.info('===--- checkbox ---===');
//burada lobbyrefresh pulldown ve checkbox parametrelerini yeniden build edip ona gore request gondermeli.
//yenile butonu, pulldown'dan item secilmesi ve cb degisimi hepsi ayni aksiyonu almali -k
			lobbyRefresh(e);
		}

		private function closePulldowns(e:Event) :void
		{
		}

		private function _nrCreate(e:Event) :void
		{
			var t:String = _nrLimit1.selected ? 'No' : _nrLimit2.selected ? 'Limit' : _nrLimit3.selected ? 'Pot' : '';

// force all created games to NoLimit...
t='No';

			var pb:String = _nrPass.text == "" ? "0" : "1";
			var gt:String = pb == "1" ? "4" : "1";
/*
gametype (limit no limit)     rt
biggest  bg
totalpeanuts tp
users us
roomType  gt
*/
			_nrProp = {	rn:			String(_nrName.text),		// roomname
							uid:			0,
							param11:		pb,								// if passworded
							ps:			String(_nrPass.text),		// pass
							minl:			1,									// minlevel
							maxl:			5,									// maxlevel
							mid:			0,									// matchid
							gt:			1,									// gametype 1-2-3-4 game,tourn,vip,private
							st:			1,
							bs:			Number(_nrMin.text),			// smallblind
							bb:			(Number(_nrMin.text) * 2),			// bigblind
							bi:			10,								// blindinc
							tl:			Number(_nrTimelimit.text),	// timelimit
							minb:			(Number(_nrMin.text) * 10),		// BuyInto Min
							maxb:			(Number(_nrMin.text) * 100),		// BuyInto Max
							mu:			/*Number(_nrPlayers.text)*/9,	// players
							vw:			/*Number(_nrViewers.text)*/9		// viewers
			};
			if(_nrName.text!=""){
				dispatchEvent(new impEvent('CREATE_ROOM', {roomAttr: _nrProp}));
			}
		}

		private function createPane(typ:String) :Sprite
		{
			var lineHeight:Number = 15;
			var maxLines:Number = 3;
			var maxWidth:Number = 666;
			var marginTop:Number = 88;
			var marginLeft:Number = 6;
			var borderWidth:Number = 8;

			var cx:Number=0;
			var _s:Sprite = new Sprite();

			for(var index:Number=0; index<this._rooms[typ].length; index++)
			{
				_labelset = new Sprite();
				_s.addChild(_labelset);

				var pset:Object = this._rooms[typ][index];
				var lx:Number = borderWidth+marginLeft;

				writeLine(_labelset, {
						lineNo:		index,
						columns:		[lx+5, lx+170, lx+330, lx+490],
						labels:		[pset.title, pset.stat, pset.roomType(true), pset.roomType()],
						ypos:			marginTop + index * (lineHeight + 2) - 2,
						lineWidth:	maxWidth - _slider.width - borderWidth,
						roomObj:		pset,
						marginLeft:	6,
						maxLines:	8,
						back:			true,
						handler:		andler
					},
					{color: 0xffffff, size: 12}, true);
			}

			var _mask:Sprite = new Sprite();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(borderWidth, marginTop+2, _s.width-10, 140);
			addChild(_mask);
			_s.mask = _mask;

			return(_s);
		}

		private function buildRoom(e:Event) :void
		{
			_newRoom.visible = true;
		}

		public function closeNewRoomWindow() :void
		{
			_newRoom.visible = false;
		}

		public function cleanRooms() :void
		{
		try{
main.log.info('cleanup '+_paneset.length);
			for(var i:String in _paneset){
				_paneset[i].x = 1000;
			}
			_paneset = [];
		}catch(e:Error){main.log.info("cleanRooms exception: "+e);}
		}

		private function sliderScroll(s:Slider, l:Sprite) :void
		{
			l.y = -s.value;
		}

		public function selectTab(e:Event) :void
		{
			var set:Array = ['games', 'tournaments', 'vip', 'private'];

			var no:Number = set.indexOf(e.target.parent.desc);
			_paneset[_selectedPane].x = 10000;
			_paneset[no].x = 0;
			_selectedPane = no;
		}



		public function andler(e:Event) :void
		{
			var filter:BitmapFilter = new GlowFilter(0xffffff, 0.6, 50, 50, 2, BitmapFilterQuality.HIGH, false, false);
			var xfilters:Array = [];
			xfilters.push(filter);
			_b2.filters = xfilters;
			_selectedGame = e.target.parent.id;
			_selectedGameObj = e.target.parent.roomObj;
			dispatchEvent(new Event('GAME_SELECTED'));
		}

		public function get selectedGame():String		{ return _selectedGame; }
		public function get selectedGameObj():Object	{ return _selectedGameObj; }
		public function get nrProp():Object	{ return _nrProp; }

		// e.target.parent.parent.parent is gLobby
		// e.target.parent.parent.parent.parent is main

		public function lobbyRefresh(e:Event) :void
		{
			e.target.parent.parent.parent.parent.dispatchEvent(new Event('LOBBY_REFRESH'));
		}
		public function joinGame(e:Event) :void {
			e.target.parent.parent.parent.dispatchEvent(new Event('JOIN_BUTTON'));}

	}
}