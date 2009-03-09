package org.openscales.provider {
	
	import flash.utils.ByteArray;
	
	import org.openscales.geometry.Envelope2D;
	import org.openscales.layer.ILayer;
	
	/**
	 * Provide a random color data used to test and debug OpenScales
	 */
	public class RandomColorProvider implements IDataProvider {
		
		/**
		 * Constructor of a DataProvider only useful for debugging the rendering
		 */
		public function RandomColorProvider() {
			super();
		}
		
		public function getData(extent:Envelope2D, resolution:Number):ByteArray {
			var red:int = 255 * Math.random();
			var green:int = 255 * Math.random();
			var blue:int = 255 * Math.random();
			var color:uint = red << 16 | green << 8 | blue;
			var data:ByteArray = new ByteArray();
			data.writeUnsignedInt(color);
			
			data.position = 0;
			return data;
		}

	}
}