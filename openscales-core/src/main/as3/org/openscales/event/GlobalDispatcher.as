package org.openscales.event
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * Global event dispatcher, we will inject it as a singleton thanks to Spring ActonScript
	 * 
	 * @author bouiaw
	 */
	public class GlobalDispatcher extends EventDispatcher {
		
		public function GlobalDispatcher()
		{
		}
		
		/**
         * Basic dispatch function, dispatches simple named events
         */
        public function dispatch( type : String ) : Boolean {
                return dispatchEvent( new Event( type ) );
        }

	}
}