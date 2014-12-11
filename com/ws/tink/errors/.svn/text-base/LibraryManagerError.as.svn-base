package ws.tink.errors {

    public class LibraryManagerError extends Error {

        private const ERROR_MSG:Array;
        private const BASE_ERROR_CODE:uint = 3000;

        public static const LIBRARY_NOT_FOUND:uint = 1000;
        public static const DUPLICATE_LIBRARY_NAME:uint = 3002;
        public static const FORCE_SINGLETON:uint = 3001;

        public function LibraryManagerError(_arg1:uint){
            this.ERROR_MSG = new Array("LibraryManager is to be used as a Singleton and should only be accessed through LibraryManager.libraryManager.", "There is already a library with this name. Libraries stored in the LibraryManager must be unique names.", "The supplied library name could not be found in the LibraryManager.");
            super(((("Error #" + _arg1) + ": ") + this.ERROR_MSG[(_arg1 - this.BASE_ERROR_CODE)]), _arg1);
            name = "LibraryManagerError";
        }
    }
}//package ws.tink.errors 