package org.openscales.layer {
	
	import org.openscales.IMap;
	
	/**
	 * Interface for a layer
	 */
	public interface ILayer {
		
		/**
		 * The map which this layer is attached to
		 */
		function get map():IMap;		
		function set map(value:IMap):void;
		
		/**
		 * The visibility of the layer
		 */
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		/**
		 * The minimum resolution of the layer
		 */
		function get minResolution():Number;
		function set minResolution(value:Number):void;
		
		/**
		 * The maximum resolution of the layer
		 */
		function get maxResolution():Number;
		function set maxResolution(value:Number):void;
		
		/**
		 * The resolution to use for displaying the data depending on the map's
		 * resolution and the layer's minimum and maximum resolutions
		 */
		function get resolution():Number;
		
	}
}