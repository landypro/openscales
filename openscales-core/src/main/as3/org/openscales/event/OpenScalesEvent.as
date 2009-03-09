package org.openscales.event
{
	import flash.events.Event;

	/**
	 * OpenScales base event. Every events of OpenScales event hierarchy will inherit of this class.
	 * 
	 * @author bouiaw
	 */
	public class OpenScalesEvent extends Event
	{
		
		/**
		 * OpenScale base for event hierarchy
		 */
		public function OpenScalesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Function to override in each revertable event
		 */
		public function getUndoEvent():OpenScalesEvent {
			return new OpenScalesEvent("NullUndoEvent");
		}
		
	}
}