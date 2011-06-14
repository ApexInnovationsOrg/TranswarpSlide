package com.apexinnovations.transwarp {
	//import com.apexinnovations.transwarp.data.Courseware;
	import com.apexinnovations.transwarp.config.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.*;

	public dynamic class TranswarpSlide extends MovieClip implements IConfigurationAcceptor {
		private const TESTOUT_URL:String = '//www.apexinnovations.com/doLaunchTest.php?ID=';
		
		private var _config:XML;
		
		public function TranswarpSlide() {
			super();
			
			stop();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			if(this.setupSlide !== null) {
				this.setupSlide();
			}
		}
		
		protected function setupSlide():void {
			// TODO
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
		
		public function TestOut(courseID:uint):void {
			var s:String = 's'; //(Courseware.instance.website.indexOf('https') == -1 ? '' : 's'); 
			navigateToURL(new URLRequest('http' + s + TESTOUT_URL + courseID), '_self');
		}
		
	}
}