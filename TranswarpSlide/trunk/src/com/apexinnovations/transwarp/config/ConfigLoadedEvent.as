package com.apexinnovations.transwarp.config {
	import flash.events.Event;
	
	public class ConfigLoadedEvent extends Event {
		
		public static const CONFIG_LOADED:String = "configLoaded";
		public var config:*;
		
		public function ConfigLoadedEvent(config:*, bubbles:Boolean=false, cancelable:Boolean=false) {
			this.config = config;
			super(CONFIG_LOADED, bubbles, cancelable);
		}
	}
}