package org.openscales.renderer
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import org.openscales.geometry.Envelope2D;
	import org.openscales.provider.IDataProvider;

	public class AbstractDataRenderer implements IDataRenderer
	{
		/**
		 * The provider of the data displayed in this layer
		 */
		protected var _provider:IDataProvider;	
		
		public function AbstractDataRenderer(provider:IDataProvider=null)
		{
			this._provider = provider;
		}

		public function render(extent:Envelope2D, display:Sprite, resolution:Number, bgColor:uint=0xFFFFFFFF):void
		{
		}
		
	}
}