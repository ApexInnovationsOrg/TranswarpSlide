package com.apexinnovations.transwarp.components {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	
	public class ProgressBar extends TranswarpComponent {
		
		public static const MODE_MANUAL:String = "manual";
		public static const MODE_PROGRESS_POLLED:String = "polled";
		public static const MODE_PROGRESS_EVENT:String = "event";
		public static const MODE_TIMELINE:String = "timeline";
		
		protected var _source:Object;
		protected var oldSource:Object;
		
		protected var _mode:String = MODE_TIMELINE;
		protected var oldMode:String;
		
		public function ProgressBar() {
			super();
			invalidate();
		}
		
		public function get source():Object { return _source; }
		public function set source(value:Object):void {
			if(value == source)
				return;
			
			oldSource = _source;
			_source = value;
			
			invalidate();			
		}

		public function get mode():String { return _mode; }
		public function set mode(value:String):void {
			if(value == _mode)
				return;
			
			oldMode = _mode;
			_mode = value;
			
			if(value == MODE_PROGRESS_POLLED || value == MODE_PROGRESS_EVENT)
				throw new Error("Progress Bar Mode ("+value+") is not implemented");
			else if(value != MODE_TIMELINE && value != MODE_MANUAL) {
				
			} else
				throw new Error("Progress Bar Mode ("+value+") is not a valid mode");

			invalidate();
		}
		
		
		protected function getSource():Object {
			var source:EventDispatcher = _source as EventDispatcher;
			if(!source)
				source = this.parent;
			
			return source;
		} 
		
		override public function validate():void {
			if(oldSource) {
				removeListeners(oldSource as EventDispatcher);
				oldSource = null;
			}
			
			var source:EventDispatcher = getSource() as EventDispatcher;
			
			if(oldMode) {
				removeListeners(source);
				oldMode = null;
			}
			
			applyListeners(source);
		}
		
		protected function applyListeners(src:EventDispatcher):void {
			if(!src)
				return;
			
			switch(_mode) {
				case MODE_MANUAL:
					break; //No listeners for this mode
				
				case MODE_TIMELINE:
					src.addEventListener(Event.ENTER_FRAME, enterFrame);
					break;
				
				// NYI modes
				case MODE_PROGRESS_POLLED:
					break;
				case MODE_PROGRESS_EVENT:
					break;
			}

		}
		
		protected function removeListeners(src:EventDispatcher):void {
			if(!src)
				return;
			
			src.removeEventListener(Event.ENTER_FRAME, enterFrame);
			//TODO: remove other listeners as other modes are implemented;
		}
		
		protected function enterFrame(event:Event):void {
			var movie:MovieClip = event.target as MovieClip;
			if(_mode == MODE_TIMELINE && movie) {
				setProgress(movie.currentFrame, movie.totalFrames);
			}
		}

		public function setProgress(current:Number, total:Number):void {	
		}
		
		
	}
}