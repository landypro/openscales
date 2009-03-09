package org.openscales.tiling {
	
	import org.openscales.layer.AbstractLayer;
	import org.openscales.provider.IDataProvider;
	
	public class TiledLayer extends AbstractLayer {
		
		public function TiledLayer(provider:IDataProvider) {
			super(new TileRenderer(provider));
		}
	}
}