package com.obsesif.models
{
/*
1. cmd=rooms  : tüm odaları çeker
2. cmd=rooms&param=1 parametresi gönderilen odanın bilgileri gelir.
3. cmd=rooms&param=top5 en yüksek çimdik bulunan ilk 5 odayı getirir.
4. cmd=users profiller listesi
5. cmd=users&param=5  parametrede idsi gönderilen kullanıcının bilgileri
gelir.
6. cmd=rooms2 oda listesini ikinci yoldan getirir çıktı aynı yol farklı
7. cmd=buddyList&param=3  parametrede idsi gönderilen profilin arkadaş
listesini gönderir.
8. cmd=decUserCash&param=3&param1=4&param2=true
burası kullanıcnın toplam parasına ekleme çıkartma yeri param userIdy denk
geliyor , param1 para miktarı param2 true ise ekler false ise çıkartır.
Dönen değer ise {"total": 5412} gibi  kullanıcının işlemden sonra toplam
parasını çeker.
9. cmd=sessionId olursa o anki kullanıcının sessionIdsi döner. Dönen değer
{"sessionId":"wkxwio55hp12gm45f3jpts45"} gibidir.

11. cmd=deleteroom&param=3 odayı siler param olarak Oda Id gönderilir.Oda Id
smartfoxun verdiği oda ID dir. dönen değer deleted:1 ise silindi, 0 ise
silinmemiştir.
12. cmd=newroom aşağıdaki parametreleri alır

                Dim profileId As Integer = Request.QueryString("param1")
                Dim name As String = Request.QueryString("param2")
                Dim minbet As Integer = Request.QueryString("param3")
                Dim minlevel As Integer = Request.QueryString("param4")
                Dim maxlevel As Integer = Request.QueryString("param5")
                Dim biggest As Integer = Request.QueryString("param6")
                Dim totalpeanuts As Integer = Request.QueryString("param7")
                Dim users As Integer = Request.QueryString("param8")
                Dim matchId As Integer = Request.QueryString("param9")
                Dim roomType As Integer = Request.QueryString("param10")
                Dim status As Integer = Request.QueryString("param11")
                Dim password As Integer = Request.QueryString("param12")

dönen değer ise :1 ise açıldı 0 ise açılmadı demektir.
*/
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import com.adobe.serialization.json.*;
	import flash.events.*;

	public class mRemote extends EventDispatcher
	{
		private var gateway:String = "http://www.zukaa.com/gwJson.aspx?";
		private var _rs:Array;
		private var _ldr:URLLoader;
		private var _uObj:Object;
		private var url:String = "";
		public var data:Object;

		public function mRemote(cmd:String, par:Object, data:Object = null)
		{
			this.data = data || {}; //data saklayip sonra event handler'da erismek icin
			this.url = this.gateway + 'cmd=' + cmd;
			for (var p:String in par){
				this.url += '&' + p + '=' + par[p];
			}
			
		}
		
		public function run():void
		{
		this._ldr = new URLLoader();
		var request:URLRequest = new URLRequest();
		request.url = this.url;
		main.log.info("URL: "+this.url);
		this._ldr.load(request);
		this._ldr.addEventListener(Event.COMPLETE, saveData);
		}

		private function saveData(e:Event) :void
		{
			var loader:URLLoader = URLLoader(e.target);
			var rs:String;
			rs = loader.data as String;

			var t:* = JSON.decode(rs);
			if(t is Array) this._rs = t;
			if(t is Object) this._rs = new Array(t);

			_ldr.removeEventListener(Event.COMPLETE, saveData);
			dispatchEvent(new Event('RC_DATA_SAVED'));
		}
//==============================================================================
		public function get recordSet() :Array { var t:Array = this._rs.slice(); return (t as Array); }
		public function get valueNum() :Number { return Number(this._rs[0][0].value); }
		public function get valueStr() :String { return String(this._rs[0][0].value); }
		public function get valueObj() :Object { var t:Array = this._rs.slice(); return Object(t[0][0]); }
		public function get singleObj() :Object { var t:Array = this._rs.slice(); return Object(t[0]); }
		public function get singleArr() :Array { var t:Array = this._rs.slice(); return (t[0] as Array); }
	}
}
