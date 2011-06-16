package com.apexinnovations.transwarp.components {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TranswarpComponent extends Sprite {
		
		public function TranswarpComponent() {
			super();
		}
		
		public function invalidate():void {
			addEventListener(Event.ENTER_FRAME, validationHandler);
		}
		
		private function validationHandler(event:Event):void {
			validate();
			removeEventListener(Event.ENTER_FRAME, validationHandler);
		}
		
		public function validate():void {
			//override this function in sub classes 
		}	
		
	}
}