package org.openscales.flex.controls{
	
	import flash.events.IEventDispatcher;
	
	import mx.core.Application;
	
	import org.openscales.IMap;
	import org.openscales.controls.keyboard.KeyboardPanControl;

	public class KeyboardPanControl extends org.openscales.controls.keyboard.KeyboardPanControl{
		
		public function KeyboardPanControl(){
			
			super(Application.application as IEventDispatcher);
		}
		
		[Bindable]
		override public function set active(value:Boolean):void{
			
			super.active=value;
		}
		
		override public function get active():Boolean{
			
			return super.active;
		}
		
		[Bindable]
		override public function set target(value:IMap):void{
			
			super.target=value;
		}
		
		override public function get target():IMap{
			
			return super.target;
		}
	}
}