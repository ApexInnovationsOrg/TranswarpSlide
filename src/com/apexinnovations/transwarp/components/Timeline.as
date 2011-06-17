package com.apexinnovations.transwarp.components {
	import com.apexinnovations.transwarp.TranswarpMovieClip;
	import com.apexinnovations.transwarp.TranswarpSlide;
	import com.apexinnovations.transwarp.config.ConfigData;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;

	public class Timeline extends ProgressBar {
		
		protected var progress:Number =  0;
		protected var bar:Sprite;
		protected var trackingMouse:Boolean = false;
		protected var draggedToEndForcedStop:Boolean = false;
		
		public static const HEIGHT:Number = 20;
		
		public function Timeline() {
			super();
			filters = [new DropShadowFilter(2.3, 235,0, 0.5, 2.3, 2.3,1,1,true), new GlowFilter(0, 0.2, 15, 15, 2, 1, true)];
			mode = MODE_TIMELINE;
			
			bar = new Sprite();
			addChild(bar);
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(Event.ENTER_FRAME, dragTime);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);  
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			invalidate();
		}
		
		override public function set width(value:Number):void {
			super.height = value;
			invalidate();
		}
		
		override public function validate():void {
			super.validate();
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRoundRect(0, 0, width, height, 3, 3);
			graphics.endFill();
		}
		
		
		protected function addedToStage(event:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
				
		protected function mouseDown(event:MouseEvent):void {
			trackingMouse = true;
		}
		
		protected function mouseUp(event:MouseEvent):void {
			trackingMouse = false;
			if(draggedToEndForcedStop) {
				draggedToEndForcedStop = false;
				var src:MovieClip = getSource() as MovieClip;
				
				if(!src || src.currentFrame == src.totalFrames)
					return;
				
				src.play();
			}
		}
		
		override public function setProgress(current:Number, total:Number):void {
			super.setProgress(current, total);
			
			var oldProgress:Number = progress;
			progress = current / total;
			
			if(progress == oldProgress)
				return;
			
			//var color:uint = 0xed1c24;
			var color:uint = ConfigData.color;
			var gfx:Graphics = bar.graphics;
			
			gfx.clear();
			gfx.beginFill(color);
			gfx.drawRoundRect(0, 0, width*progress, height, 3, 3);
			gfx.endFill();
		}
		
		protected function dragTime(event:Event):void {
			if(!trackingMouse)
				return;
			
			var src:MovieClip = getSource() as MovieClip;
			
			if(!src)
				return;
			
			var newFrame:int = Math.max(0,Math.min((mouseX / width) * src.totalFrames, src.totalFrames));
					
			// We attempt to maintain the 'playing state' of the clip while the user drags the timeline.
			// To prevent the clip from looping when the user drags the timeline all the way to the end, gotoAndStop is always used to stop it
			//		if the timeline is dragged to the last frame.
			// To prevent this workaround from causing the clip to remain paused if the timeline is dragged away from the final frame
			// 		before releasing the mouse, we keep track of when the clip was stopped in this way.
			
			var playing:Boolean = !(src is TranswarpMovieClip && !TranswarpMovieClip(src).isPlaying) || draggedToEndForcedStop;
			
			if(playing && newFrame == src.totalFrames) {
				draggedToEndForcedStop = true;
				src.gotoAndStop(newFrame);
			} else if(playing)
				src.gotoAndPlay(newFrame);
			else
				src.gotoAndStop(newFrame);
		}
		
	}
}