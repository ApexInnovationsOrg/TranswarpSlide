package com.apexinnovations.transwarp {

	import com.apexinnovations.transwarp.components.Timeline;
	import com.apexinnovations.transwarp.config.*;
	
	import flash.events.Event;
	import flash.net.*;

	public dynamic class TranswarpSlide extends TranswarpMovieClip implements IConfigurationAcceptor {
		private const TESTOUT_URL:String = '//www.apexinnovations.com/doLaunchTest.php?ID=';

		private var _config:XML;
		protected var _timeline:Timeline;
		protected var timelineNeedsSetup:Boolean;
		protected var isLoaderInfoReady:Boolean = false;
		protected var timelineVerticalOffset:Number;
		
		public function TranswarpSlide() {
			super();
			
			stop();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			if(this.setupSlide is Function) {
				this.setupSlide();
			}
		}
		
		protected function onAdded(event:Event):void {
			gotoAndPlay(1);
			if(this.activate is Function)
				this.activate();	
		}

		protected function onRemoved(event:Event):void {
			stop();
			if(this.deactivate is Function)
				this.deactivate();			
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

