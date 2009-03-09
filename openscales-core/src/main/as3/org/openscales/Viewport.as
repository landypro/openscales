package org.openscales {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;	
	
	/**
	 * A viewport that clips itself according to its width and height.
	 */
	public class Viewport extends Sprite {
		
		/**
		 * The height of the viewport in pixels
		 */
		private var _height:Number;
		
		/**
		 * The width of the viewport in pixels
		 */
		private var _width:Number;
		
		/**
		 * Flag to indicate if the clipping mask has to be redrawn
		 */
		private var _redrawMask:Boolean;
		
		/**
		 * The mask used for clipping
		 */
		private var _maskShape:Shape;
			
		public function Viewport(width:Number=400, height:Number=300) {
			this.width = width;
			this.height = height;
			this._redrawMask = true;
			this._maskShape = new Shape();
			
			this.addEventListener(Event.ADDED_TO_STAGE,this._addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,this._removedFromStageHandler);
		}
		
		/**
		 * The height of the viewport in pixels
		 */
		override public function get height():Number {
			return this._height;
		}
		
		override public function set height(value:Number):void {
			this._height = value;
			this._requestRedraw();
		}
		
		/**
		 * The width of the viewport in pixels
		 */
		override public function get width():Number {
			return this._width;
		}
		
		override public function set width(value:Number):void {
			this._width = value;
			this._requestRedraw();
		}

		// TODO : Not sure that scaling should be hooked as mask may be scaled automaticaly
		override public function set scaleX(value:Number):void {
			super.scaleX = value;
			this._requestRedraw();
		}
		
		override public function set scaleY(value:Number):void {
			super.scaleY = value;
			this._requestRedraw();
		}
		
		private function _requestRedraw():void {
			this._redrawMask = true;
			if (this.stage != null){
				this.stage.invalidate();
			}
		}
		
		private function _addedToStageHandler(event:Event):void {
			this.stage.addEventListener(Event.RENDER,this._renderHandler);
			this._requestRedraw();
		}
		
		private function _removedFromStageHandler(event:Event):void {
			this.stage.removeEventListener(Event.RENDER,this._renderHandler);
		}
		
		private function _renderHandler(event:Event):void {
			if (this._redrawMask) {
				this._maskShape.graphics.clear();
				this._maskShape.graphics.beginFill(0x000000);
				this._maskShape.graphics.drawRect(0,0,this.width*this.scaleX,this.height*this.scaleY);
				this.mask = this._maskShape;
				
				// IMPROVE : Perhaps raise an OpenScalesEvent like ResizeEvent(width:Number,height:Number)
				this.dispatchEvent(new Event(Event.RESIZE));
				this._redrawMask = false;
			}  
		}
		
		public function dispose():void {
			this._maskShape = null;
			
			this.removeEventListener(Event.ADDED_TO_STAGE,this._addedToStageHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,this._removedFromStageHandler);
			if(this.stage != null) {	
				this.stage.removeEventListener(Event.RENDER,this._renderHandler);
			}			
		}

	}
}