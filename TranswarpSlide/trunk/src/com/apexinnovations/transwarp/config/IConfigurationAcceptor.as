package com.apexinnovations.transwarp.config {
	
	
	public interface IConfigurationAcceptor {
		function get config():XML;
		function set config(value:XML):void;
	}
}