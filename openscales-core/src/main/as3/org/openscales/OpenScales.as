package org.openscales {
	
	import flash.events.Event;
	
	import org.openscales.event.GlobalDispatcher;
	
	public class OpenScales
	{
		/** OpenScales singleton instance */
       private static var _applicationFactory : OpenScales;
		
		/** Lock to enforce singleton */
        private static var lock : Boolean = false;
		
		/** Dispatcher used to broadcast events */
		private var _globalDispatcher:GlobalDispatcher;

		public function OpenScales() {
			if (! lock)
				throw new Error( "OpenScales can only be defined once.");
		}
		
		/** Static getInstance method */
        public static function getInstance() : OpenScales {
                if ( _applicationFactory == null) {
                        lock = true;
                        _applicationFactory = new OpenScales();
                        lock = false;
                }
                return _applicationFactory;
        }
		
		public function get globalDispatcher():GlobalDispatcher {
			return _globalDispatcher;
		}
		
		/** Static addEventListener method delegates to ApplicationController. This is for convenience */
        public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
                getInstance().globalDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }
        
        /** Static addEventListener method delegates to ApplicationController. This is for convenience */
        public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
                getInstance().globalDispatcher.removeEventListener(type, listener, useCapture);
        }
        
        /** Static method to dispatch events by name. Delegates to ApplicationController */
        public static function dispatch( type : String ) : Boolean {
                return getInstance().globalDispatcher.dispatch( type );
        }
        
        /** Static method to dispatch events by name. Delegates to ApplicationController */
        public static function dispatchEvent( event : Event ) : Boolean {
                return getInstance().globalDispatcher.dispatchEvent( event );
        }

	}
}