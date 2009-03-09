package org.openscales.controls.keyboard
{
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyboardZoomControl extends KeyboardControl
	{
		public function KeyboardZoomControl(keyboardEventDispatcher:IEventDispatcher)
		{
			super(keyboardEventDispatcher);
		}
		
		override protected function _keyDownHandler(event:KeyboardEvent):void{
			
			trace('Key down : '+event.charCode);
			switch(event.charCode){
				
				case 122:{
					
					this._target.resolution/=2;
					break;
				}
				case 115:{
					
					this._target.resolution*=2;
					break;
				}
			};
		}
	}
}