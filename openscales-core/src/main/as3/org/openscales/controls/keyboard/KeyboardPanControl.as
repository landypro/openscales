package org.openscales.controls.keyboard
{
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyboardPanControl extends KeyboardControl{
		
		public function KeyboardPanControl(keyboardEventDispatcher:IEventDispatcher){
			
			super(keyboardEventDispatcher);
		}
				
		override protected function _keyDownHandler(event:KeyboardEvent):void{
			
			trace('Key down '+event.charCode);
			
			switch(event.keyCode){
				
				case Keyboard.UP:{
					
					this._target.pan(0,-5);
					break;
				}
				case Keyboard.LEFT:{
					
					this._target.pan(-5,0);
					break;
				}
				case Keyboard.DOWN:{
					
					this._target.pan(0,5);
					break;
				}
				case Keyboard.RIGHT:{
					
					this._target.pan(5,0);
					break;
				}
			}
		}		
	}
}