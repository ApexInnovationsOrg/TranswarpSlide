package com.apexinnovations.transwarp {
	import com.apexinnovations.transwarp.config.ConfigLoadedEvent;
	import com.apexinnovations.transwarp.config.IConfigurationAcceptor;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public dynamic class TranswarpSlide extends MovieClip implements IConfigurationAcceptor {
		
		private var _config:XML;
		
		public function TranswarpSlide() {
			super();
			
			stop();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			if(this.setupSlide !== null) {
				this.setupSlide();
			}
		}
		
		protected function onAdded(event:Event):void {
			gotoAndPlay(1);
		}
		
		public function get config():XML {
			return _config;
		}

		public function set config(value:XML):void {
			_config = value;
			dispatchEvent(new ConfigLoadedEvent(_config));
		}

	}
}