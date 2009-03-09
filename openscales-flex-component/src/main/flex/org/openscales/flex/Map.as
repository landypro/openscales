package org.openscales.flex {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.openscales.IMap;
	import org.openscales.geometry.DirectPosition2D;
	import org.openscales.geometry.Envelope2D;
	import org.openscales.geometry.IDirectPosition;
	import org.openscales.layer.DebugLayer;
	import org.openscales.layer.ILayer;
	import org.openscales.layer.MeridiansAndParallelsLayer;

	public class Map extends UIComponent implements IMap {
		
		private var _delegate:IMap;
		
		public function Map() {
			super();

			this._delegate = new org.openscales.Map(null);
			
			// TODO: Remove this code when map configuration will be implemented
			this._delegate.extent = new Envelope2D(new DirectPosition2D(-1000,-1000), new DirectPosition2D(1000,1000));
			this._delegate.center = new DirectPosition2D(0,0);
			this._delegate.resolution = 1.0;
			this._delegate.width = 400;
			this._delegate.height = 300;
			this._delegate.addLayer(new DebugLayer());
			//this._delegate.addLayer(new MeridiansAndParallelsLayer());
			// end TODO

			this.addChild(this._delegate as DisplayObject);
			
			/*var crosshair:Sprite = new Sprite();
			crosshair.graphics.lineStyle(2,0xFF0000);
			crosshair.graphics.moveTo(this._delegate.width/2,this._delegate.height/2-5);
			crosshair.graphics.lineTo(this._delegate.width/2,this._delegate.height/2+5);
			crosshair.graphics.moveTo(this._delegate.width/2-5,this._delegate.height/2);
			crosshair.graphics.lineTo(this._delegate.width/2+5,this._delegate.height/2);
			this.addChild(crosshair);*/
		}
		
		public function get center():IDirectPosition {
			return this._delegate.center;
		}
		
		public function set center(value:IDirectPosition):void {
			this._delegate.center = value;
		}

		public function get extent():Envelope2D {
			return this._delegate.extent;
		}
		
		public function set extent(value:Envelope2D):void {
			this._delegate.extent = value;
		}

		public function getVisibleExtent():Envelope2D {
			return this._delegate.getVisibleExtent();
		}
		
		public function get resolution():Number {
			return this._delegate.resolution;
		}
		
		public function set resolution(value:Number):void {
			this._delegate.resolution = value;
		}
		
		public function pan(px:int, py:int):void {
			this._delegate.pan(px,py);
		}
		
		public function panCS(x:Number, y:Number):void {
			this._delegate.panCS(x,y);
		}
		
		public function addLayer(layer:ILayer):void {
			this._delegate.addLayer(layer);
		}
		
		/**
		 * Transmits events from the delegate IMap to exterior listeners
		 */
		private function _transmitEvent(event:Event):void {	
			this.dispatchEvent(event);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			this._delegate.width = unscaledWidth;
			this._delegate.height = unscaledHeight;
		}
		
	}
}