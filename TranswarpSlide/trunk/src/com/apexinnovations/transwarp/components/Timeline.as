package com.apexinnovations.transwarp.components {
	import com.apexinnovations.transwarp.TranswarpMovieClip;
	import com.apexinnovations.transwarp.TranswarpSlide;
	
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
		
		protected var pendingPlay:Boolean = false;
		protected var trackingMouse:Boolean = false;
		
		public function Timeline() {
			super();
			filters = [new DropShadowFilter(2.3, 235,0, 0.5, 2.3, 2.3,1,1,true), new GlowFilter(0, 0.2, 15, 15, 2, 1, true)];
			mode = MODE_TIMELINE;
			
			bar = new Sprite();
			addChild(bar);
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		protected function addedToStage(event:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
	
				
		protected function mouseDown(event:MouseEvent):void {
			trackingMouse = true;	
			mouseMove(event);
		}
		
		protected function mouseUp(event:MouseEvent):void {
			trackingMouse = false;
			if(pendingPlay){
				var s:MovieClip = getSource() as MovieClip;
				s.gotoAndPlay(s.currentFrame-1);
				pendingPlay = false;
			}
		}
		
		protected function mouseMove(event:MouseEvent):void {
			if(!trackingMouse)
				return;
			
			var src:MovieClip = getSource() as MovieClip;
			
			if(!src)
				return;
			
			var newFrame:int = Math.max(0,Math.min((mouseX / width) * src.totalFrames, src.totalFrames));
			
			var tws:TranswarpMovieClip = src as TranswarpMovieClip;
			
			if(tws && !tws.isPlaying && !pendingPlay)
				pendingPlay = false;
			else
				pendingPlay = true;
			
			src.gotoAndStop(newFrame);
		}
		
		override public function setProgress(current:Number, total:Number):void {
			super.setProgress(current, total);
			
			var oldProgress:Number = progress;
			progress = current / total;
			
			if(progress == oldProgress)
				return;
			
			var color:uint = 0xed1c24;
			var gfx:Graphics = bar.graphics;
			
			gfx.clear();
			gfx.beginFill(color);
			gfx.drawRoundRect(0, 0, width*progress, height, 3, 3);
			gfx.endFill();
		}
	}
}