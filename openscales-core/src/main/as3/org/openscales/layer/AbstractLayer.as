package org.openscales.layer {
	
	import flash.utils.ByteArray;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.openscales.IMap;
	import org.openscales.event.PanEvent;
	import org.openscales.event.ZoomEvent;
	import org.openscales.geometry.Envelope2D;
	import org.openscales.provider.IDataProvider;
	import org.openscales.renderer.IDataRenderer;
	
	public class AbstractLayer extends Sprite implements ILayer {
		
		/**
		 * The map which this layer is attached to
		 */
		protected var _map:IMap;			
		
		/**
		 * The renderer of the data displayed in this layer
		 */
		protected var _renderer:IDataRenderer;		
		
		/**
		 * Minimum and maximum resolutions allowed for the display of the data
		 * of this layer (_maxResolution < _minResolution)
		 */
		protected var _minResolution:Number = 1000000.0, _maxResolution:Number = 0.01;
		
		public function AbstractLayer(renderer:IDataRenderer) {
			super();
			this._renderer = renderer;
		}
		
		public function get map():IMap {
			return this._map;
		}
		
		public function set map(value:IMap):void {
			this._map = value;
			this._map.addEventListener(ZoomEvent.ZOOM,this._map_zoomHandler);
			this._map.addEventListener(PanEvent.PAN,this._map_panHandler);
			this._map.addEventListener(Event.RESIZE,this._map_resizeHandler);
			this._refresh();
		}
		
		/**
		 * Refreshes the layer display.
		 * Function to override in each specific layer
		 */
		protected function _refresh():void {
			var extent:Envelope2D = this.map.getVisibleExtent();
			_renderer.render(extent, this, this.resolution);
		}
		
		public function get minResolution():Number {
			return _minResolution;
		}
		
		public function set minResolution(value:Number):void {
			_minResolution = (value>0) ? value : 0.01;
			//this._refresh();
		}
		
		public function get maxResolution():Number {
			return _maxResolution;
		}
		
		public function set maxResolution(value:Number):void {
			_maxResolution = (value>0) ? value : 0.01;
			//this._refresh();
		}
		
		public function get resolution():Number {
			if (_map.resolution <= _maxResolution) {
				return _maxResolution;
			}
			if (_map.resolution >= _minResolution) {
				return _minResolution;
			}
			return _map.resolution;
		}
		
		private function _map_zoomHandler(event:ZoomEvent):void {
			this._refresh();
		}
		
		private function _map_panHandler(event:PanEvent):void {
			this._refresh();
		}
		
		private function _map_resizeHandler(event:Event):void {
			this._refresh();
		}
		
		private function _addedToStageHandler(event:Event):void {
		}
		
		private function _removedFromStageHandler(event:Event):void {
		}
		
	}
}