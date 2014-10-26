package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Game extends Sprite {
		
		//CORE
		private var _tilegrid : Tilegrid;
		private var _bg : Background;
		//PLAYER
		private var _player : Player;
		public static var hp : int = 3;
		public static var powerUp : Boolean = false;
		//AI
		private var _blinky : Blinky;
		private var _pinky : Pinky;
		private var _inky : Inky;
		private var _clyde : Clyde;
		private var _ai : Array = [];
		//UI
		private var _ui : UI;
			
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			
			
			// Core
			_bg = new Background;
			addChildAt(_bg, 0);
			
			_tilegrid = new Tilegrid;
			addChild(_tilegrid);
			
			// Player
			_player = new Player;
			addChild(_player);
			_player.x = 14 * Tilegrid.TILE_SIZE;
			_player.y = 26 * Tilegrid.TILE_SIZE;
			
			// AI
			_blinky = new Blinky;
			addChild(_blinky);
			_blinky.x = 13 * Tilegrid.TILE_SIZE;
			_blinky.y = 16 * Tilegrid.TILE_SIZE;
			_ai.push(_blinky);
			
			_pinky = new Pinky;
			addChild(_pinky);
			_pinky.x = 14 * Tilegrid.TILE_SIZE;
			_pinky.y = 16 * Tilegrid.TILE_SIZE;
			_ai.push(_pinky);
			
			_inky = new Inky;
			addChild(_inky);
			_inky.x = 15 * Tilegrid.TILE_SIZE;
			_inky.y = 17 * Tilegrid.TILE_SIZE;
			_ai.push(_inky);
			
			_clyde = new Clyde;
			addChild(_clyde);
			_clyde.x = 16 * Tilegrid.TILE_SIZE;
			_clyde.y = 17 * Tilegrid.TILE_SIZE;
			_ai.push(_clyde);
			
			// UI
			_ui = new UI;
			addChildAt(_ui, 1);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			
			// Collision check between player and ai
			for (var i:int = _ai.length - 1; i >= 0; i--) {
				if (_ai[i] != null) {
					_ai[i].update();
					
					if (_ai[i].hitTestObject(_player) && powerUp) {
						// Eat ai
						//removeChild(_ai[i]);
						//_ai.splice(_ai[i]);
						
						_ai[i].x = 16 * Tilegrid.TILE_SIZE;
						_ai[i].y = 17 * Tilegrid.TILE_SIZE;
						
						UI.SCORE += 200;
						trace("Eat");
					} else if (_player.hitTestObject(_ai[i]) && !powerUp) {
						// Lose life & respawn
						trace(hp);
						respawn();
					}
					
				}
				
			}
		}
		private var timer:Timer = new Timer(3000);
		
		private function respawn():void {
			removeEventListener(Event.ENTER_FRAME, update);
			timer.start();
			
			hp--;
			_player.dead();
			
			if (hp <= 0) {
				_ui.gameOver();
				timer.addEventListener(TimerEvent.TIMER, gameOver);
			} else {
				timer.addEventListener(TimerEvent.TIMER, resume);
			}
			
			
			
		}
		
		private function resume(e:TimerEvent):void {
			addEventListener(Event.ENTER_FRAME, update);
			timer.reset();
		}
		
		private function gameOver(e:TimerEvent):void {
			_player.destroy();
			removeAI();
			removeEventListener(Event.ENTER_FRAME, update);
			dispatchEvent(new Event("restartGame"));
			
		}
		
		private function removeAI():void {
			for (var i:int = _ai.length - 1; i >= 0; i--) {
				if (_ai[i] != null) {
					removeChild(_ai[i]);
					_ai.splice(_ai[i]);
				}
			}
		}
	}

}