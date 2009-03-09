package org.openscales.ogc {
	
	/**
	 * A static class containing constants with the common namespaces used by OGC XMLs
	 */
	public class XmlNamespace{
		
		public static const WFS:Namespace=new Namespace('wfs','http://www.opengis.net/wfs');
		public static const OGC:Namespace=new Namespace('ogc','http://www.opengis.net/ogc');
		public static const GML:Namespace=new Namespace('gml','http://www.opengis.net/gml');
		public static const OWS:Namespace=new Namespace('ows','http://www.opengis.net/ows');
	}
}