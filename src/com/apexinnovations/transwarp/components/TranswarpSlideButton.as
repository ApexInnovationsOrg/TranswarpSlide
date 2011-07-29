package com.apexinnovations.transwarp.components
{
	import com.apexinnovations.transwarp.config.ConfigData;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class TranswarpSlideButton extends MovieClip
	{
		public var foreground:MovieClip;
		public var background:MovieClip;

		public function TranswarpSlideButton()
		{
			super();
			
			//			trace("Getting the actual button color now:", ConfigData.buttonFGColor);
			var fgColor:Number = ConfigData.buttonFGColor || 0x00FF00;
			var bgColor:Number = ConfigData.buttonBGColor || 0x008800;
			
			// Grab the component colors, remember to subtract out generic grays from MovieClip components
			foreground.transform.colorTransform = new ColorTransform(1, 1, 1, 1, ((fgColor >> 16) & 0x0000FF) - 0xFF, ((fgColor >> 8) & 0x0000FF) - 0xFF, (fgColor & 0x0000FF) - 0xFF);
			background.transform.colorTransform = new ColorTransform(1, 1, 1, 1, ((bgColor >> 16) & 0x0000FF) - 0x33, ((bgColor >> 8) & 0x0000FF) - 0x33, (bgColor & 0x0000FF) - 0x33);
			
			buttonMode = true;
			addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent):void { gotoAndStop(3); });
			addEventListener(MouseEvent.MOUSE_OUT, function(event:MouseEvent):void { gotoAndStop(1); });
			addEventListener(MouseEvent.MOUSE_OVER, function(event:MouseEvent):void { gotoAndStop(2); });
			addEventListener(MouseEvent.MOUSE_UP, function(event:MouseEvent):void { gotoAndStop(2); });
			gotoAndStop(1);
		}
	}
}