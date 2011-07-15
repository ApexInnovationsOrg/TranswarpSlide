package com.apexinnovations.transwarp {
	import flash.display.MovieClip;
	
	public dynamic class TranswarpMovieClip extends MovieClip {
		
		public function TranswarpMovieClip() {
			super();
		}
		
		protected var _isPlaying:Boolean = true;
		
		public function get isPlaying():Boolean { return _isPlaying; }
		
		override public function play():void {
			super.play();
			_isPlaying = true;
		}
		
		override public function stop():void {
			super.stop();
			_isPlaying = false;
		}
		
		override public function gotoAndPlay(frame:Object, scene:String=null):void {
			super.gotoAndPlay(frame, scene);
			_isPlaying = true;
		}
		
		override public function gotoAndStop(frame:Object, scene:String=null):void {
			super.gotoAndStop(frame, scene);
			_isPlaying = false;
		}
	}
}