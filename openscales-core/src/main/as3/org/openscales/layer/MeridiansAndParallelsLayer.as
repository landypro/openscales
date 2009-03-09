package org.openscales.layer {
	
	import org.openscales.renderer.MeridiansAndParallelsRenderer;
	
	public class MeridiansAndParallelsLayer extends AbstractLayer {

		public function MeridiansAndParallelsLayer(gap:Number=40)
		{
			super(new MeridiansAndParallelsRenderer(gap));
		}
		
	}
}