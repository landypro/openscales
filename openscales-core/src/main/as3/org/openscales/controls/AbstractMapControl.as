package org.openscales.controls{
	
	import flash.events.IEventDispatcher;
	
	import org.openscales.IMap;

	public class AbstractMapControl implements IMapControl{
		
		protected var _target:IMap;
		
		protected var _active:Boolean;
		
		protected var _eventDispatcher:IEventDispatcher;
		
		public function AbstractMapControl(eventDispatcher:IEventDispatcher){
			this._active=false;
			this._target=null;
			
			this._eventDispatcher= eventDispatcher;
		}

		public function get target():IMap{
			
			return this._target;
		}
		
		public function set target(value:IMap):void{
			
			if(this._active){
				this._unregisterListeners();
			}
			
			this._target=value;
			
			if(this._active){
				
				this._registerListeners();
			}
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
		
		protected function _registerListeners():void{

		}
		
		protected function _unregisterListeners():void{
			
		}
		
	}
}