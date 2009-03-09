package org.openscales.provider {
	
	import flash.utils.ByteArray;
	
	import org.openscales.geometry.Envelope2D;
	import org.openscales.layer.ILayer;
	
	/**
	 * Interface for a data provider
	 */	
	public interface IDataProvider {
		
		/**
		 * Loads data contained in a bounding box.
		 * 
		 * @param layer the layer that needs data
		 * @param extent the bounding box of the requested data
		 * @return a byte array describing the data (XML, raster image, ...)
		 */		
		function getData(extent:Envelope2D, resolution:Number):ByteArray;
		
	}
}