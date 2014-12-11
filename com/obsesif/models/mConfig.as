package com.obsesif.models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.xml.*;
	import com.adobe.utils.StringUtil;
	import com.obsesif.interfaces.*;
	import com.obsesif.mechanics.*;

	dynamic public class mConfig extends Proxy implements IEventDispatcher
	{
		static private var _instance:mConfig;
		private var dispatcher:EventDispatcher;

		public var loader:URLLoader;
		public var configXML:XML;

		private var _url:String;
		private var _path:String;
		private var _seed:String;

		public function mConfig (enforcer:SingletonEnforcer) {}

		public function boot () :void
		{
			dispatcher = new EventDispatcher();
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, parse);
			loader.addEventListener(ProgressEvent.PROGRESS, progressor);
			try {
//				 loader.load( new URLRequest(this._url + 'c_config') );
				 loader.load( new URLRequest('http://www.zukaa.com/config.aspx') );

			} catch (e:Error) {
				 main.log.info("Unable to load requested document.");
			}
		}

		private function parse(e:Event) :void
		{
			XML.ignoreWhitespace = true;
			var configXML:XML = new XML(e.target.data);

			this._url = configXML.server.url.toString();
			this._path = configXML.server.filepath.toString();
			this._seed = configXML.security.siteseed.toString();

			dispatchEvent(new Event('CONFIG_READY'));
		}

		public function set siteurl(_domain:String) :void
		{
			this._url = _domain;
		}

		public function get siteurl() :String
		{
			return StringUtil.trim(String(this._url));
		}

		public function get path() :String
		{
			return StringUtil.trim(String(this._path));
		}

		public function get seed() :String
		{
			return StringUtil.trim(String(this._seed));
		}

		private function progressor(e:ProgressEvent) :void
		{
			var percent:Number = (e.bytesLoaded / e.bytesTotal ) * 100;
    	}

		public static function getInstance() :mConfig
		{
			if(mConfig._instance == null)
				mConfig._instance = new mConfig(new SingletonEnforcer());
			return mConfig._instance;
		}

		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, weakRef: Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, weakRef);
		}

		public function dispatchEvent(e:Event) :Boolean
		{
			return dispatcher.dispatchEvent(e);
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) :void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}

      public function hasEventListener(type:String) :Boolean
		{
         return dispatcher.hasEventListener(type);
      }

		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}

	}
}
class SingletonEnforcer {}