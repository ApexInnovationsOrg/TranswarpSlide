package com.apexinnovations.transwarp {

	import com.apexinnovations.transwarp.components.Timeline;
	import com.apexinnovations.transwarp.config.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.*;

	public dynamic class TranswarpSlide extends TranswarpMovieClip implements IConfigurationAcceptor {
		private const TESTOUT_URL:String = '//www.apexinnovations.com/doLaunchTest.php?ID=';

		private var _config:XML;
		protected var _timeline:Timeline;

		public function TranswarpSlide() {
			super();
			stop();

			addEventListener(Event.ADDED_TO_STAGE, _$ts_onAdded);
			if(this.setupSlide is Function) {
				this.setupSlide();
			}
		}

		protected function _$ts_onAdded(event:Event):void {
			gotoAndPlay(1);
			if(this.activate is Function)
				this.activate();
		}

		public function get config():XML {
			return _config;
		}

		public function set config(value:XML):void {
			_config = value;
			dispatchEvent(new ConfigLoadedEvent(_config));
		}

		public function enableTimeline(verticalOffset:Number = 15):void {
			if(_timeline)
				return;
			_timeline = new Timeline();
			_timeline.height = 20;
			_timeline.width = width * .8;
			_timeline.x = width * .1;
			_timeline.y = height - verticalOffset;
			addChild(_timeline);
		}

		public function TestOut(courseID:uint):void {
			var s:String = 's'; //(Courseware.instance.website.indexOf('https') == -1 ? '' : 's'); 
			navigateToURL(new URLRequest('http' + s + TESTOUT_URL + courseID), '_self');
		}

	}
}

