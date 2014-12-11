package ws.tink.core {
    import flash.events.*;
    import ws.tink.events.*;
    import flash.display.*;
    import flash.net.*;
    import flash.utils.*;

    public class Library extends EventDispatcher {

        private var _runtimeCompletes:Array;
        private var _embeddedComplete:Boolean;
        private var _bytesLoaded:Number;// = 0
        private var _embeddedLoaders:Array;
        private var _enterFrameDispatcher:Sprite;
        private var _runtimeLoaders:Array;
        private var _name:String;
        private var _runtimeComplete:Boolean;
        private var _bytesTotal:Number;// = 0

        public function Library(_arg1:String){
            this._name = _arg1;
            this.initialize();
        }
        public function embedSWFS(... _args):void{
            var _local2:Loader;
            var _local3:Class;
            if (this._enterFrameDispatcher.hasEventListener(Event.ENTER_FRAME)){
                this._enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            };
            this._embeddedComplete = false;
            var _local4:Number = _args.length;
            var _local5:int;
            while (_local5 < _local4) {
                _local3 = Class(_args[_local5]);
                _local2 = new Loader();
                _local2.loadBytes((new (_local3) as ByteArray));
                this._embeddedLoaders.push(_local2);
                _local5++;
            };
            this._enterFrameDispatcher.addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
        }
        public function get name():String{
            return (this._name);
        }
        public function reset():void{
            this.destroy();
            this.initialize();
        }
        public function get bytesLoaded():Number{
            return (this._bytesLoaded);
        }
        public function getDefinition(_arg1:String):Class{
            var _local2:Loader;
            var _local3:int;
            var _local4:int;
            _local3 = this._embeddedLoaders.length;
            _local4 = 0;
            while (_local4 < _local3) {
                _local2 = Loader(this._embeddedLoaders[_local4]);
                if (_local2.contentLoaderInfo.applicationDomain.hasDefinition(_arg1)){
                    return ((_local2.contentLoaderInfo.applicationDomain.getDefinition(_arg1) as Class));
                };
                _local4++;
            };
            _local3 = this._runtimeLoaders.length;
            _local4 = 0;
            while (_local4 < _local3) {
                _local2 = Loader(this._runtimeLoaders[_local4]);
                if (_local2.contentLoaderInfo.applicationDomain.hasDefinition(_arg1)){
                    return ((_local2.contentLoaderInfo.applicationDomain.getDefinition(_arg1) as Class));
                };
                _local4++;
            };
            throw (new ReferenceError((("ReferenceError: Error #1065: Variable " + _arg1) + " is not defined.")));
        }
        public function get bytesTotal():Number{
            return (this._bytesTotal);
        }
        public function loadSWFS(... _args):void{
            this._runtimeComplete = false;
            var _local2:int = _args.length;
            var _local3:int;
            while (_local3 < _local2) {
                this.loadSWF((_args[_local3] as String));
                _local3++;
            };
        }
        public function contains(_arg1:String):Boolean{
            var _local2:Loader;
            var _local3:Number = this._embeddedLoaders.length;
            var _local4:int;
            while (_local4 < _local3) {
                _local2 = Loader(this._embeddedLoaders[_local4]);
                if (_local2.contentLoaderInfo.applicationDomain.hasDefinition(_arg1)){
                    return (true);
                };
                _local4++;
            };
            return (false);
        }
        public function get embeddedComplete():Boolean{
            return (this._embeddedComplete);
        }
        private function checkLoadersProgress(_arg1:Boolean=false):void{
            var _local4:Loader;
            var _local2:Number = 0;
            var _local3:Number = 0;
            _arg1 = true;
            var _local5:int = this._runtimeLoaders.length;
            var _local6:int;
            while (_local6 < _local5) {
                _local4 = Loader(this._runtimeLoaders[_local6]);
                _local2 = (_local2 + _local4.contentLoaderInfo.bytesTotal);
                _local3 = (_local3 + _local4.contentLoaderInfo.bytesLoaded);
                if (!this._runtimeCompletes[_local6]){
                    _arg1 = false;
                };
                _local6++;
            };
            this._bytesLoaded = _local3;
            this._bytesTotal = _local2;
            if (_arg1){
                this._runtimeComplete = true;
                dispatchEvent(new LibraryEvent(LibraryEvent.LOAD_COMPLETE, false, false));
            } else {
                dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _local3, _local2));
            };
        }
        private function onLoaderProgress(_arg1:ProgressEvent):void{
            this.checkLoadersProgress();
        }
        private function initialize():void{
            this._embeddedLoaders = new Array();
            this._runtimeLoaders = new Array();
            this._runtimeCompletes = new Array();
            this._enterFrameDispatcher = new Sprite();
            this._bytesLoaded = 0;
            this._bytesTotal = 0;
        }
        public function embedSWF(_arg1:Class):void{
            var _local2:Loader = new Loader();
            _local2.loadBytes((new (_arg1) as ByteArray));
            this._embeddedLoaders.push(_local2);
        }
        private function onLoaderComplete(_arg1:Event):void{
            var _local2:Loader = Loader(_arg1.target.loader);
            _local2.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onLoaderProgress);
            _local2.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoaderComplete);
            var _local3:int = this._runtimeLoaders.length;
            var _local4:int;
            while (_local4 < _local3) {
                if (_local2 == Loader(this._runtimeLoaders[_local4])){
                    this._runtimeCompletes[_local4] = true;
                    break;
                };
                _local4++;
            };
            this.checkLoadersProgress(true);
        }
        public function get runtimeComplete():Boolean{
            return (this._runtimeComplete);
        }
        private function onEnterFrame(_arg1:Event):void{
            this._enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this._embeddedComplete = true;
            dispatchEvent(new LibraryEvent(LibraryEvent.EMBED_COMPLETE, false, false));
        }
        public function get complete():Boolean{
            return (((this._embeddedComplete) && (this._runtimeComplete)));
        }
        public function destroy():void{
            var _local1:Loader;
            var _local2:int;
            var _local3:int;
            if (this._enterFrameDispatcher.hasEventListener(Event.ENTER_FRAME)){
                this._enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            };
            _local2 = this._runtimeLoaders.length;
            _local3 = 0;
            while (_local3 < _local2) {
                _local1 = Loader(this._runtimeLoaders[_local3]);
                if (!this._runtimeCompletes[_local3]){
                    _local1.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.onLoaderProgress);
                    _local1.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoaderComplete);
                    _local1.close();
                } else {
                    _local1.unload();
                };
                _local3++;
            };
            _local2 = this._embeddedLoaders.length;
            _local3 = 0;
            while (_local3 < _local2) {
                _local1 = Loader(this._embeddedLoaders[_local3]);
                _local1.unload();
                _local3++;
            };
            this._embeddedLoaders = null;
            this._runtimeLoaders = null;
            this._runtimeCompletes = null;
            this._enterFrameDispatcher = null;
            this._name = null;
            this._bytesLoaded = undefined;
            this._bytesTotal = undefined;
        }
        public function loadSWF(_arg1:String):void{
            var _local2:Loader = new Loader();
            _local2.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onLoaderProgress, false, 0, true);
            _local2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaderComplete, false, 0, true);
            _local2.load(new URLRequest(_arg1));
            this._runtimeLoaders.push(_local2);
            this._runtimeCompletes.push(false);
        }

    }
}//package ws.tink.core 