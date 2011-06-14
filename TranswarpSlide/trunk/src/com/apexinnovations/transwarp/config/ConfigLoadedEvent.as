package com.apexinnovations.transwarp.config {
	import flash.events.Event;
	
	public class ConfigLoadedEvent extends Event {
		
		public static const CONFIG_LOADED:String = "configLoaded";
		public var config:XML;
		
		public function ConfigLoadedEvent(config:XML, bubbles:Boolean=false, cancelable:Boolean=false) {
			this.config = config;
			super(CONFIG_LOADED, bubbles, cancelable);
		}
	}
}