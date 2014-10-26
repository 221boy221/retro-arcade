package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ...
	 */
	public class Menu extends Sprite {
		
		private var _startText : TextField = new TextField();
		
		private var _bg : MenuBackground = new MenuBackground;
		
		public function Menu() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			addChildAt(_bg, 0);
			addChildAt(_startText, 1);
			_startText.text = "Press a key to start!";
			_startText.x = stage.stageWidth / 2 - 100;
			_startText.y = stage.stageHeight - 120;
			_startText.scaleX = 2;
			_startText.scaleY = 2;
			_startText.textColor = 0xffffff;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, startTheGame);
		}
		
		private function startTheGame(e:KeyboardEvent):void {
			dispatchEvent(new Event("startGame"));
		}
		
	}

}