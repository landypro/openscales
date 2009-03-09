package org.openscales.geometry {
	
	import org.openscales.referencing.crs.ICoordinateReferenceSystem;
	
	public class DirectPosition implements IDirectPosition {
				
		/**
		 * The coordinate reference system for this position
		 */
		private var _crs:ICoordinateReferenceSystem;
		
		/**
		 * The dimension of the DirectPosition
		 */
		private var _dimension:uint;
		
		/**
		 * The coordinates of the DirectPosition 
		 */
		private var _coordinates:Array /* of Number */;
		
		public function DirectPosition(coordinates:Array /* of Number */, crs:ICoordinateReferenceSystem=null) {			
			this._dimension = coordinates.length;
			this._coordinates = coordinates;
			this._crs = crs;
		}

		public function get coordinate():Array /* of Number */ {
			return this._coordinates;
		}
		
		public function get dimension():uint {
			return this._dimension;
		}
		
		public function getOrdinate(dimension:uint):Number {
			return (dimension<this.dimension) ? this._coordinates[dimension] : 0.0;
		}
		
		public function setOrdinate(dimension:uint, value:Number):void {
			if (dimension<this.dimension) {			
				this._coordinates[dimension] = value;
			} else {
				throw new Error("DirectPosition - setOrdinate: invalid dimension");
			}
		}
		
		public function get coordinateReferenceSystem():ICoordinateReferenceSystem {
			return this._crs;
		}	

	}
}