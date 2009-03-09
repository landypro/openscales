package org.openscales {
	
	import flash.display.DisplayObject;
	
	import org.openscales.event.PanEvent;
	import org.openscales.event.ZoomEvent;
	import org.openscales.geometry.DirectPosition2D;
	import org.openscales.geometry.IDirectPosition;
	import org.openscales.geometry.Envelope2D;
	import org.openscales.layer.ILayer;
	
	/**
	 * Base implementation of map. Every custom map should extends this one.
	 * 
	 * @see org.openscales.IMap;
	 */	
	public class Map extends Viewport implements IMap	
	{
		
		/**
		 * Position of the center of the map
		 */
		private var _center:IDirectPosition;
		
		/**
		 * Bounding box of the map in the map's coordinate system
		 */
		private var _extent:Envelope2D;
		
		/**
		 * The resolution at which the data are represented.
		 * A resolution of 2.0 means that 1 pixel on the map represents 2.0
		 * <units of measure>.
		 * The minimum and maximum resolutions are defined by the visible layers 
		 */
		private var _resolution:Number;
		
		/**
		 * The map is made of layers.
		 * The depth of each layer decreases with the value of its index in this
		 * array: 0 is the background, 1 is just in front of, ... 
		 */
		private var _layers:Array /* of ILayer */;
				
		/**
		 * Create a map
		 * 
		 * @param extent the bounding box of the map
		 * @param center the position of the center of the map (if null the center is used)
		 * @param resolution the resolution of the view
		 */
		public function Map(extent:Envelope2D, center:IDirectPosition=null, resolution:Number=1) {
			super();
			
			this._layers = new Array();
			this._extent = extent;
			this._center = center ? center : (extent ? extent.getCenter() : null);
			this._resolution = resolution;
		}

		public function get center():IDirectPosition {
			return this._center;
		}
		
		public function set center(value:IDirectPosition):void {
			this._center = value;
		}

		public function get extent():Envelope2D {
			return this._extent;
		}
		
		public function set extent(value:Envelope2D):void {
			this._extent = value;
		}
		
		public function get resolution():Number {
			return this._resolution;
		}
		
		public function set resolution(value:Number):void {
			this._resolution = value;
			this.dispatchEvent(new ZoomEvent(this._resolution));
		}
		
		public function getVisibleExtent():Envelope2D {
			var halfWidth:Number = this.width * this.resolution / 2;
			var halfHeight:Number = this.height * this.resolution / 2;
			return new Envelope2D(new DirectPosition2D(this.center.getOrdinate(0)-halfWidth, this.center.getOrdinate(1)-halfHeight, this.center.coordinateReferenceSystem),
								new DirectPosition2D(this.center.getOrdinate(0)+halfWidth, this.center.getOrdinate(1)+halfHeight, this.center.coordinateReferenceSystem));
		}
		
		public function get layers():Array /* of ILayer */ {
			return this._layers;
		}
		
		public function addLayer(layer:ILayer):void {
			if (layer is DisplayObject){
				this._layers.push(layer);
				this.addChild(layer as DisplayObject);
				layer.map = this;
			}
		}
		
		public function pan(px:int,py:int):void {
			/* 
			** New x position is obtained by substracting x pan because if you want to move the map display 3 pixels left, the center is 3 pixels to the right of current center
			** As for y position, as Earth and Screen axis are inverted, the pan ammount is added.
			*/
			this.center = new DirectPosition2D(this.center.getOrdinate(0)-px*resolution,this.center.getOrdinate(1)+py*resolution);
			this.dispatchEvent(new PanEvent(px,py));
		}
		
		public function panCS(x:Number,y:Number):void {
			/* 
			** New x position is obtained by substracting x pan because if you want to move the map display 3 units left, the center is 3 units to the right of current center
			** As for y position, as Earth and Screen axis are inverted, the pan ammount is added.
			*/
			this.center = new DirectPosition2D(this.center.getOrdinate(0)-x,this.center.getOrdinate(1)+y);
			this.dispatchEvent(new PanEvent(x/resolution,y/resolution));
			// En fait il faut inverser, un panEvent doit prendre des CS units pour ne pas avoir trop d'approximations !
		}
	}
}