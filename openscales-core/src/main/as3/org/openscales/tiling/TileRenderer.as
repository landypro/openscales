package org.openscales.tiling {
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import org.openscales.geometry.Envelope2D;
	import org.openscales.provider.IDataProvider;
	import org.openscales.renderer.AbstractDataRenderer;
		
	public class TileRenderer extends AbstractDataRenderer {
		
		protected static const DEFAULT_MAX_TILES_TO_KEEP:int = 256; // 256*256*4bytes = 0.25MB ... so 256 tiles is 64MB of memory, minimum!
		
		protected static const TILE_WIDTH:Number = 40;
		
		protected static const TILE_HEIGHT:Number = 40;  
		
		/** this is the maximum size of tileCache (visible tiles will also be kept in the cache) */		
		public var _maxTilesToKeep:int = DEFAULT_MAX_TILES_TO_KEEP;
		
		protected var _tileWidth:Number = TILE_WIDTH;
		
		protected var _tileHeight:Number = TILE_HEIGHT;
		
		protected var _tileCache:TileCache;

		protected var _tilePool:TilePool;
		
			
		public function TileRenderer(provider:IDataProvider) {
			super(provider);
			
			this._tilePool = new TilePool(Tile);
			this._tileCache = new TileCache(_tilePool);
		}
		
		public function get provider():IDataProvider {
			return this._provider;
		}
		
		public function set provider(value:IDataProvider):void {
			this._provider = value;
		}
		
		public override function render(extent:Envelope2D, display:Sprite, resolution:Number, bgColor:uint=0xFFFFFFFF):void {
			
			
			display.graphics.clear();
			
			var leftBorderX:Number = extent.left * resolution;
			var topBorderY:Number = extent.top * resolution;
			
			var abscissa:Number = ((Math.floor(leftBorderX/this._tileWidth)+1)*this._tileWidth-leftBorderX)/resolution;
			
			
			var offsetX:Number = this._tileWidth/resolution;
			var offsetY:Number = this._tileHeight/resolution;
			
						
			while (abscissa<extent.width) {
				
				var ordinate:Number = (topBorderY-Math.floor(topBorderY/this._tileHeight)*this._tileHeight)/resolution;
				
				while (ordinate<extent.height) {
					var data:ByteArray = _provider.getData(extent, resolution);
					
					// Select the right color
					if ((data != null) && (data.bytesAvailable >= 4)) {
						var color:uint = data.readUnsignedInt();
						display.graphics.beginFill(color);
					} else {
						display.graphics.beginFill(bgColor);
					}
					
					display.graphics.drawRect(abscissa, ordinate, abscissa + offsetX, ordinate + offsetY);
					display.graphics.endFill();
					ordinate += offsetY;
			
				}
				abscissa += offsetX;
			}
			
		}
		
	}
}