package ws.tink.managers {
    import ws.tink.core.*;
    import ws.tink.errors.*;

    public class LibraryManager {

        private var _libraries:Array;

        private static var _instance:LibraryManager;
        private static var _allowConstructor:Boolean;

        public function LibraryManager(){
            if (!_allowConstructor){
                throw (new LibraryManagerError(LibraryManagerError.FORCE_SINGLETON));
            };
            this.initialize();
        }
        private function initialize():void{
            this._libraries = new Array();
        }
        public function addLibrary(_arg1:Library, _arg2:String):void{
            if (this.getLibraryIndex(_arg2) == -1){
                this._libraries.push(_arg1);
            };
            throw (new LibraryManagerError(LibraryManagerError.DUPLICATE_LIBRARY_NAME));
        }
        public function getLibrary(_arg1:String):Library{
            var _local2:int = this.getLibraryIndex(_arg1);
            return (((_local2)==-1) ? null : Library(this._libraries[_local2]));
        }
        public function contains(_arg1:String):Boolean{
            return (!((this.getLibraryIndex(_arg1) == -1)));
        }
        public function removeLibrary(_arg1:String, _arg2:Boolean=false):void{
            var _local4:Library;
            var _local3:int = this.getLibraryIndex(_arg1);
            if (_local3 != -1){
                _local4 = Library(this._libraries.splice(_local3, 1)[0]);
                if (_arg2){
                    _local4.destroy();
                };
            };
            throw (new LibraryManagerError(LibraryManagerError.LIBRARY_NOT_FOUND));
        }
        private function getLibraryIndex(_arg1:String):int{
            var _local2:int = this._libraries.length;
            var _local3:int;
            while (_local3 < _local2) {
                if (_arg1 == Library(this._libraries[_local3]).name){
                    return (_local3);
                };
                _local3++;
            };
            return (-1);
        }
        public function createLibrary(_arg1:String):Library{
            var _local2:Library;
            if (this.getLibraryIndex(_arg1) == -1){
                _local2 = new Library(_arg1);
                this._libraries.push(_local2);
                return (_local2);
            };
            throw (new LibraryManagerError(LibraryManagerError.DUPLICATE_LIBRARY_NAME));
        }

        public static function get libraryManager():LibraryManager{
            if (!_instance){
                _allowConstructor = true;
                _instance = new (LibraryManager);
                _allowConstructor = false;
            };
            return (_instance);
        }

    }
}//package ws.tink.managers 