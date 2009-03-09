package org.openscales.tiling {
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	
	import org.openscales.geometry.Envelope2D;
	
	public class Tile extends Sprite {
		
		/**
		 * The position of the top-left corner in the map's coordinate system
		 */
		private var _enveloppe:Envelope2D;
		
		/**
		 * We use resolution as proposed on http://wiki.osgeo.org/wiki/WMS_Tiling_Client_Recommendation
		 */
		private var _resolution:Number;
		
		public function Tile(enveloppe:Envelope2D, resolution:Number) {
			
			this._enveloppe = enveloppe;
			this._resolution = resolution;
			
			// Taken from ModestMaps, but don't really know the effect
			this.cacheAsBitmap = false;
			
		}
		
		public function get enveloppe():Envelope2D {
			return this._enveloppe;
		}
		
		public function set enveloppe(value:Envelope2D):void {
			this._enveloppe = value;
		}
		
		public function get resolution():Number {
			return this._resolution;
		}
		
		public function set resolution(value:Number):void {
			this._resolution = value;
		}
		
		/** override this in a subclass and call grid.setTileClass if you want to draw on your tiles */
	    public function init(enveloppe:Envelope2D, resolution:Number):void
	    {
			this._enveloppe = enveloppe;
			this._resolution = resolution;	
			hide();
	    } 
	    
	    public function show():void 
		{
			this.alpha = 1.0;
		}
		
		public function hide():void
		{
			this.alpha = 0.0;
		}
		
		/** once TileGrid is done with a tile, it will call destroy and possibly reuse it later */
	    public function destroy():void
	    {
	    	while (numChildren > 0) {
	    		var child:DisplayObject = removeChildAt(0);
	    		if (child is Loader) {
	    			try {
	    				Loader(child).unload();
	    			}
	    			catch (error:Error) {
	    				trace(error.message);
	    			}
	    		}
	    	}
	    	graphics.clear();
	    }       
		
		
	}
}