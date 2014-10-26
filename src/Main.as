package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Main extends Sprite {
		
		private var _game : Game;
		private var _menu : Menu;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_menu = new Menu;
			addChild(_menu);
			_menu.addEventListener("startGame", startGame);
		}
		
		private function restartGame(e:Event):void {
			_game.removeEventListener("restartGame", restartGame);
			removeChild(_game);
			_game = null;
			
			_menu = new Menu;
			addChild(_menu);
			_menu.addEventListener("startGame", startGame);
		}
		
		private function startGame(e:Event):void {
			_menu.removeEventListener("startGame", startGame);
			removeChild(_menu);
			_menu = null;
			
			_game = new Game;
			addChild(_game);
			_game.addEventListener("restartGame", restartGame);
		}
		
	}
	
}