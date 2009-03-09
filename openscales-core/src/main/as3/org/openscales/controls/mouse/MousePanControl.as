package org.openscales.controls.mouse
{
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import org.openscales.controls.AbstractMapControl;
	
	/**
	 * Abstract class to be extended by keyboardKeyboardControl */
	public class MousePanControl extends AbstractMapControl {
				
		private var _dragX0:int;
		private var _dragY0:int;
		
		public function MousePanControl(mouseEventDispatcher:IEventDispatcher){
			super(mouseEventDispatcher);
		}
		
		protected override function _registerListeners():void{
			this._eventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN,this._mouseDownHandler);
		}
		
		protected override function _unregisterListeners():void{
			this._eventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN,this._mouseDownHandler);
		}
		
		protected function _mouseDownHandler(mouseEvent:MouseEvent):void{
			_dragX0 = mouseEvent.stageX;
			_dragY0 = mouseEvent.stageY;
			this._eventDispatcher.addEventListener(MouseEvent.MOUSE_MOVE,this._mouseMoveHandler);
			this._eventDispatcher.addEventListener(MouseEvent.MOUSE_UP,this._mouseUpHandler);
		}
		
		protected function _mouseUpHandler(mouseEvent:MouseEvent):void{
			this._eventDispatcher.removeEventListener(MouseEvent.MOUSE_MOVE,this._mouseMoveHandler);
			this._eventDispatcher.removeEventListener(MouseEvent.MOUSE_UP,this._mouseUpHandler);
		}
		
		protected function _mouseMoveHandler(mouseEvent:MouseEvent):void{
			this._target.pan(_dragX0-mouseEvent.stageX, mouseEvent.stageY-_dragY0);
			_dragX0 = mouseEvent.stageX;
			_dragY0 = mouseEvent.stageY;
		}
		
		
	}
}