package org.openscales.controls.mouse{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.openscales.IMap;
	import org.openscales.controls.IMapControl;

	/**
	 * Mouse control used for panning the map with drag'n'drop
	 */
	public class DragNDropMousePanControl implements IMapControl{
		
		private var _target:IMap;
		
		private var _active:Boolean;
		
		private var _handlerRegistered:Boolean;
		
		private var _lastMouseX:Number;
		
		private var _lastMouseY:Number;
		
		public function DragNDropMousePanControl(){
			
			this._target=null;
			this._active=false;
			this._handlerRegistered=false;
		}

		public function get target():IMap{
						
			return this._target;
		}
		
		public function set target(value:IMap):void{
			
			this._unregisterHandlers();
			
			this._target=value;
			
			this._registerHandlers();
		}
		
		public function get active():Boolean{
			
			return this._active;
		}
		
		public function set active(value:Boolean):void{
			trace('Setting active');
			this._active=value;
			if(this._active){
				
				trace('Active set to :'+this.active);
			}
			else{
				
				trace('Active set to :'+this.active);
			}
			
			if(this._handlerRegistered){
				
				trace('Handlers are registered');
			}
			
			if(this._active && !this._handlerRegistered){
				
				trace('Handler registration requested');
				this._registerHandlers();
			}
			else if(!this._active && this._handlerRegistered){
				
				trace('Handler unregistration requested');
				this._unregisterHandlers();
			}
		}
		
		private function _registerHandlers():void{
			
			if(this._target){
				
				trace('Registering handlers');
				this._target.addEventListener(MouseEvent.MOUSE_DOWN,this._mouseDownHandler);
				(this._target as DisplayObject).addEventListener(MouseEvent.MOUSE_UP,this._mouseUpHandler);
				this._handlerRegistered=true;
			}
		}
		
		private function _unregisterHandlers():void{
			
			if(this._target){
				
				this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this._mouseDownHandler);
				(this._target as DisplayObject).removeEventListener(MouseEvent.MOUSE_UP,this._mouseUpHandler);
				this._handlerRegistered=false;
			}
		}
		
		private function _mouseDownHandler(event:MouseEvent):void{
			
			trace('Mouse down detected');
			this._storeEventPosition(event);
			(this._target as DisplayObject).addEventListener(MouseEvent.MOUSE_MOVE,this._mouseMoveHandler);
		}
		
		private function _mouseUpHandler(event:MouseEvent):void{
			
			trace('Mouse up detected');			
			(this._target as DisplayObject).removeEventListener(MouseEvent.MOUSE_MOVE,this._mouseMoveHandler);
		}
		
		private function _mouseMoveHandler(event:MouseEvent):void{
			
			trace('Mouse move detected');
			var xOffset:Number=event.stageX-this._lastMouseX;
			var yOffset:Number=event.stageY-this._lastMouseY;
			
			this._target.pan(xOffset,yOffset);
			
			this._storeEventPosition(event);
		}
		
		private function _storeEventPosition(event:MouseEvent):void{
			
			this._lastMouseX=event.stageX;
			this._lastMouseY=event.stageY;
		}	
	}
}