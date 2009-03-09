package org.openscales.event{
	
	public class PanEvent extends OpenScalesEvent{
		
		public static const PAN:String='pan';
		
		private var _x:Number;
		
		private var _y:Number;
		
		public function PanEvent(x:Number,y:Number, bubbles:Boolean=false, cancelable:Boolean=false){
			
			super(PanEvent.PAN, bubbles, cancelable);
			
			this._x=x;
			this._y=y;
		}
		
		public function get x():Number{
			
			return this._x;
		}
		
		public function get y():Number{
			
			return this._y;
		}
		
	}
}