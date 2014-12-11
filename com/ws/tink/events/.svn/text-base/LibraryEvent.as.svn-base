package ws.tink.events {
    import flash.events.*;

    public class LibraryEvent extends Event {

        public static var LOAD_COMPLETE:String = "loadComplete";
        public static var EMBED_COMPLETE:String = "embedComplete";

        public function LibraryEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false){
            super(_arg1, _arg2, _arg3);
        }
        override public function clone():Event{
            return (new LibraryEvent(type, bubbles, cancelable));
        }

    }
}//package ws.tink.events 