package org.openscales {
	
	import flash.events.IEventDispatcher;
	
	import org.openscales.geometry.IDirectPosition;
	import org.openscales.geometry.Envelope2D;
	import org.openscales.layer.ILayer;	
	
	/**
	 * Interface for a map
	 */
	public interface IMap extends IEventDispatcher{
		
		/**
		 * Height of the map in pixels
		 */
		function get height():Number;
		
		function set height(value:Number):void;
		
		/**
		 * Width of the map in pixels
		 */
		function get width():Number;
		
		function set width(value:Number):void;
		
		/**
		 * Position of the center of map in the map's coordinate system
		 */
		function get center():IDirectPosition;
		
		function set center(value:IDirectPosition):void;
		
		/**
		 * Bounding box of the map in the map's coordinate system
		 */
		function get extent():Envelope2D;
		
		function set extent(value:Envelope2D):void;
		
		/**
		 * Resolution of the map in map's coordinate system unit per pixel
		 */
		function get resolution():Number;
		
		function set resolution(value:Number):void;
		
		/**
		 * Bounding box of the currently visible part of the map in the map's
		 * coordinate system
		 */
		function getVisibleExtent():Envelope2D;
		
		/**
		 * Pans the map of the given px and py amounts in pixels
		 * @param px deplacement along the X-axis
		 * @param py deplacement along the Y-axis
		 */
		function pan(px:int,py:int):void;
		
		/**
		 * Pans the map of the given x and y amounts in map's coordinate system
		 * @param x deplacement along the X-axis
		 * @param y deplacement along the Y-axis
		 */
		function panCS(x:Number,y:Number):void;
		
		/**
		 * Adds the given layer to the map 
		 */
		function addLayer(layer:ILayer):void;

	}
}