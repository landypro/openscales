package org.openscales.event{
	
	public class ZoomEvent extends OpenScalesEvent{
		
		public static const ZOOM:String='zoom';
		
		private var _resolution:Number;
		
		public function ZoomEvent(resolution:Number, bubbles:Boolean=false, cancelable:Boolean=false){
	
			super(ZoomEvent.ZOOM, bubbles, cancelable);
			
			this._resolution=resolution;
		}
		
		public function get resolution():Number{
			
			return this._resolution;
		}
		
	}
}