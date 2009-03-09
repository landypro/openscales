package org.openscales.renderer {
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import org.openscales.geometry.Envelope2D;
	
	/**
	 * Interface for a data renderer.
	 * Each type of renderer is a singleton accessible by the getInstance function.
	 */	
	public interface IDataRenderer {
		
		/**
		 * Renders the data in a display object.
		 * 
		 * @param extent the bounding box of the data
		 * @param data the data to render
		 * @param display the object in which data have to be rendered 
		 * @param resolution the resolution to use for rendering 
		 * @param bgColor the background ARGB color between 0x00000000 and 0xFFFFFFFF
		 */
		function render(extent:Envelope2D, display:Sprite, resolution:Number, bgColor:uint=0xFFFFFFFF):void;

	}
}