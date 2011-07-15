package com.apexinnovations.transwarp.config {
	
	
	public interface IConfigurationAcceptor {
		function get config():*;
		function set config(value:*):void;
	}
}