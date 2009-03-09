package org.openscales.controls{
	import org.openscales.IMap;
	
	
	public interface IMapControl{
		
		function get target():IMap;
		
		function set target(value:IMap):void;
		
		function get active():Boolean;
		
		function set active(value:Boolean):void;
	}
}