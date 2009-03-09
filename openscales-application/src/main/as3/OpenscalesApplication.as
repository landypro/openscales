package {
	import flash.display.Sprite;
	
	import org.openscales.Map;
	import org.openscales.controls.IMapControl;
	import org.openscales.controls.keyboard.KeyboardPanControl;
	import org.openscales.controls.keyboard.KeyboardZoomControl;
	import org.openscales.controls.mouse.DragNDropMousePanControl;
	import org.openscales.geometry.DirectPosition2D;
	import org.openscales.geometry.Envelope2D;
	import org.openscales.layer.DebugLayer;
	import org.openscales.layer.MeridiansAndParallelsLayer;

	[SWF(width='800', height='600')]
	public class OpenscalesApplication extends Sprite
	{
		protected var _map:Map;
		
		public function OpenscalesApplication()
		{
			this._map = new Map(new Envelope2D(new DirectPosition2D(-300,-300), new DirectPosition2D(1000,1000)),
								new DirectPosition2D(0,0), 1.0);
			this._map.width = 400;
			this._map.height = 300;
			
			this._map.addLayer(new DebugLayer());
			//this._map.addLayer(new MeridiansAndParallelsLayer());
			
			var zoomer:IMapControl = new KeyboardZoomControl(this.stage);
			zoomer.target = this._map;
			zoomer.active = true;
			
			var panner:IMapControl = new KeyboardPanControl(this.stage);
			panner.target = this._map;
			panner.active = true;
			
			var dragNDropControl:IMapControl = new DragNDropMousePanControl();
			dragNDropControl.target = this._map;
			dragNDropControl.active = true;
			
			this.addChild(_map);
			
			var crosshair:Sprite = new Sprite();
			crosshair.graphics.lineStyle(2,0xFF0000);
			crosshair.graphics.moveTo(this._map.width/2,this._map.height/2-5);
			crosshair.graphics.lineTo(this._map.width/2,this._map.height/2+5);
			crosshair.graphics.moveTo(this._map.width/2-5,this._map.height/2);
			crosshair.graphics.lineTo(this._map.width/2+5,this._map.height/2);
			this.addChild(crosshair);
		}
		
	}
}
