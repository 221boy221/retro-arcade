package  {
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Game extends Sprite {
		
		private var _tilegrid : Tilegrid;
		private var _player : Player;
		private var _bg : Background;
			
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			_bg = new Background;
			addChild(_bg);
			
			_tilegrid = new Tilegrid;
			addChild(_tilegrid);
			
			_player = new Player;
			addChild(_player);
			_player.x = 1 * Tilegrid.TILE_SIZE;
			_player.y = 4 * Tilegrid.TILE_SIZE;
			
		}
		
	}

}