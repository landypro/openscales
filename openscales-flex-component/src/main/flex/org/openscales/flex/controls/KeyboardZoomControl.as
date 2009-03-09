package org.openscales.flex.controls{
	
	import flash.events.IEventDispatcher;
	
	import mx.core.Application;
	
	import org.openscales.IMap;
	import org.openscales.controls.keyboard.KeyboardZoomControl;

	public class KeyboardZoomControl extends org.openscales.controls.keyboard.KeyboardZoomControl{
		
		public function KeyboardZoomControl(){
			
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