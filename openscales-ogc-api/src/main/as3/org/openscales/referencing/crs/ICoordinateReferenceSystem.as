package org.openscales.referencing.crs
{
	import org.openscales.referencing.IReferenceSystem;
	import org.openscales.referencing.cs.ICoordinateSystem;
	
	public interface ICoordinateReferenceSystem extends IReferenceSystem
	{
		function get coordinateSystem():ICoordinateSystem;
	}
}