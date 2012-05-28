package com.apexinnovations.transwarp {
	import com.apexinnovations.transwarp.config.*;
	
	import flash.events.Event;
	import flash.net.*;

	public dynamic class TranswarpSlide extends TranswarpMovieClip implements IConfigurationAcceptor {
		private const TESTOUT_URL:String = 'http://www.apexinnovations.com/Classroom/launch-exam.php';

		private var _config:*;
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
		
		public function get config():* {
			return _config;
		}

		public function set config(value:*):void {
			_config = value;
			dispatchEvent(new ConfigLoadedEvent(_config));
		}

		public function TestOut(courseID:uint):void {
			var req:URLRequest = new URLRequest(TESTOUT_URL);
			var variables:URLVariables = new URLVariables();

			variables.ID = courseID;
//			variables.userID = ConfigData.userID;

			req.method = URLRequestMethod.POST;
			req.data = variables;
			navigateToURL(req, '_self');
		}		
		
	}
}

