package org.openscales.layer
{
	import org.openscales.provider.RandomColorProvider;
	import org.openscales.tiling.TileRenderer;

	public class DebugLayer extends AbstractLayer
	{
		public function DebugLayer()
		{
			super(new TileRenderer(new RandomColorProvider()));
		}
				
	}
}