package org.openscales.referencing.cs
{
	public interface ICoordinateSystem
	{
		function getAxis(dimension:int):ICoordinateSystemAxis;
		function get dimension():int;
		
	}
}