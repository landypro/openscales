package org.openscales.controls.keyboard
{
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	
	import org.openscales.IMap;
	import org.openscales.controls.IMapControl;
	
	/**
	 * Abstract class to be extended by keyboard controls
	 */
	public class KeyboardControl implements IMapControl{
		
		protected var _target:IMap;
		
		protected var _active:Boolean;
		
		private var _keyboardEventDispatcher:IEventDispatcher;
		
		public function KeyboardControl(keyboardEventDispatcher:IEventDispatcher){
			
			this._active=false;
			this._target=null;
			
			this._keyboardEventDispatcher=keyboardEventDispatcher;
		}

		public function get target():IMap{
			
			return this._target;
		}
		
		public function set target(value:IMap):void{
			
			this._target=value;	
		}
		
		public function get active():Boolean{
			
			return this._active;
		}
		
		public function set active(value:Boolean):void{
			
			this._active=value;
			if(this._active){
				
				this._registerListeners();
			}
			else{
			
				this._unregisterListeners();
			}
		}
		
		private function _registerListeners():void{
			
			this._keyboardEventDispatcher.addEventListener(KeyboardEvent.KEY_DOWN,this._keyDownHandler);
			this._keyboardEventDispatcher.addEventListener(KeyboardEvent.KEY_UP,this._keyUpHandler);
		}
		
		private function _unregisterListeners():void{
			
			this._keyboardEventDispatcher.removeEventListener(KeyboardEvent.KEY_DOWN,this._keyDownHandler);
			this._keyboardEventDispatcher.removeEventListener(KeyboardEvent.KEY_UP,this._keyUpHandler);
		}
		
		protected function _keyDownHandler(keyboardEvent:KeyboardEvent):void{
			
		}
		
		protected function _keyUpHandler(keyboardEvent:KeyboardEvent):void{
			
		}
	}
}