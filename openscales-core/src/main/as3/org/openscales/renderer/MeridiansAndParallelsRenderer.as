package org.openscales.renderer {
	
	import flash.display.Sprite;
	
	import org.openscales.geometry.Envelope2D;
	
	public class MeridiansAndParallelsRenderer extends AbstractDataRenderer {

		/**
		 * The gap between the drawn meridians and parallels in the map's
		 * coordinate system.
		 */		
		private var _gap:Number;		
		
		public function MeridiansAndParallelsRenderer(gap:Number=40){
			this._gap = gap;
		}
		
		/**
		 * Refreshes the layer display
		 */
		override public function render(extent:Envelope2D, display:Sprite, resolution:Number, bgColor:uint=0xFFFFFF):void {
			display.graphics.clear();
			display.alpha=0.5;
			display.graphics.beginFill(bgColor);
			display.graphics.drawRect(0, 0, extent.width, extent.height);
			display.graphics.endFill();
			display.graphics.lineStyle(1,0x333333);
			this._drawParallels(extent, display, resolution);
			this._drawMeridians(extent, display, resolution);
		}
		
		private function _drawMeridians(extent:Envelope2D, display:Sprite, resolution:Number):void {
		
			var leftBorderX:Number = extent.left * resolution;
			
			var abscissa:Number = ((Math.floor(leftBorderX/this._gap)+1)*this._gap-leftBorderX)/resolution;
			var offset:Number = this._gap/resolution;
			while (abscissa<extent.width) {
				display.graphics.moveTo(abscissa,0);
				display.graphics.lineTo(abscissa,extent.height);
				abscissa += offset;
			}
		}
		
		private function _drawParallels(extent:Envelope2D, display:Sprite, resolution:Number):void {

			var topBorderY:Number = extent.top * resolution;
			
			var ordinate:Number = (topBorderY-Math.floor(topBorderY/this._gap)*this._gap)/resolution;
			var offset:Number = this._gap/resolution;
			while (ordinate<extent.height) {
				display.graphics.moveTo(0,ordinate);
				display.graphics.lineTo(extent.width,ordinate);
				ordinate += offset;
			}
		}
		
	}
}