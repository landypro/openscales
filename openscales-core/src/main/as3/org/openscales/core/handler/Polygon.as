package org.openscales.core.handler
{
	import flash.events.MouseEvent;
	
	import org.openscales.core.control.Control;
	import org.openscales.core.feature.Vector;
	import org.openscales.core.geometry.LineString;
	import org.openscales.core.geometry.LinearRing;
	
	public class Polygon extends Path
	{
		
		public var polygon:Vector = null;
		
		public function Polygon(control:Control, callbacks:Object, options:Object, attributes:Object = null):void {
			super(control, callbacks, options);
		}
		
		override public function createFeature():void {
	        this.polygon = new Vector(new org.openscales.core.geometry.Polygon());
	        this.line = new Vector(new LinearRing());
	        var p:org.openscales.core.geometry.Polygon = this.polygon.geometry as org.openscales.core.geometry.Polygon;
	        p.addComponent(this.line.geometry);
	        this.point = new Vector(new org.openscales.core.geometry.Point());
		}
		
		override public function destoryFeature():void {
			this.polygon.destroy();
	        this.point.destroy();
		}
		
		override public function modifyFeature():void {
			var line:LineString = this.line.geometry as LineString;
			var p:org.openscales.core.geometry.Point = this.point.geometry as org.openscales.core.geometry.Point;
			var index:int = line.components.length - 2;
			
	        line.components[index].x = p.x;
	        line.components[index].y = p.y;
		}
		
		override public function drawFeature():void {
			this.layer.drawFeature(this.polygon, this.style);
	        this.layer.drawFeature(this.point, this.style);
		}
		
		override public function geometryClone():Object {
			return this.polygon.geometry.clone();
		}
		
		override public function doubleClick(evt:MouseEvent):Boolean {
			if(!this.freehandMode(evt)) {
				var line:LineString = this.line.geometry as LineString;
	            var index:int = line.components.length - 2;
	            line.removeComponent(line.components[index]);
	            this.finalize();
	        }
	        return false;
		}
		
	}
}