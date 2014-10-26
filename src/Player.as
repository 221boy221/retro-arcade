package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Player extends Sprite {
		
		private var _playerArt : PlayerArt;
		private var _direction:int;
		private var _directionY:int;
		private var _directionX:int;
		private var _previousDirX:int;
		private var _previousDirY:int;
		private var _currentTileX:int;
		private var _currentTileY:int;
		private var _speed:Number = 4;
		private var _tilegrid : Tilegrid = new Tilegrid();
		
		private var faceTo : int;
		private const IDLE 	: int = 1;
		private const LEFT 	: int = 2;
		private const UP 	: int = 3;
		private const RIGHT : int = 4;
		private const DOWN 	: int = 5;
		private const DEAD 	: int = 6;
		
		public function Player() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_playerArt = new PlayerArt;
			addChild(_playerArt);
			
			_playerArt.gotoAndStop(IDLE);
			_playerArt.scaleX = 1.2;
			_playerArt.scaleY = 1.2;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function keyDown(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37:	// LEFT
					_directionX = -1;
					_directionY = 0;
					faceTo = LEFT;
					break;
				case 38:	// UP
					_directionX = 0;
					_directionY = -1;
					faceTo = UP;
					break;
				case 39:	// RIGHT
					_directionX = 1;
					_directionY = 0;
					faceTo = RIGHT;
					break;
				case 40:	// DOWN
					_directionX = 0;
					_directionY = 1;
					faceTo = DOWN;
					break;
			}
		}
		
		private function update(e:Event):void {
			tileMovement();
			collisions();
			
			if (this.x >= stage.stageWidth + Tilegrid.TILE_SIZE) {
				this.x = -10;
			}
		}
		
		private function tileMovement():void {
			// Get current tile
			if (this.x / Tilegrid.TILE_SIZE % 1 == 0 && this.y / Tilegrid.TILE_SIZE % 1 == 0) {
				
				_currentTileX = this.x / Tilegrid.TILE_SIZE;
				_currentTileY = this.y / Tilegrid.TILE_SIZE;
			}
			if (Tilegrid.grid[_currentTileY + _directionY][_currentTileX + _directionX] <= 3 && this.x / Tilegrid.TILE_SIZE % 1 == 0 && this.y / Tilegrid.TILE_SIZE % 1 == 0) {
				
				this.x += _speed * _directionX;
				this.y += _speed * _directionY;
				
				_playerArt.gotoAndStop(faceTo);
				
				_previousDirX = _directionX;
				_previousDirY = _directionY;
				
			} else if (Tilegrid.grid[_currentTileY + _previousDirY][_currentTileX + _previousDirX] <= 3) {
				
				this.x += _speed * _previousDirX;
				this.y += _speed * _previousDirY;
			}
		}
		private var timer_powerup:Timer = new Timer(10000);
		private function collisions():void {
			var currentTile : Number = Tilegrid.grid[_currentTileY][_currentTileX];
			
			// Pickups
			if (currentTile == 2) {
				// Small dot
				UI.SCORE += 10;
				Tilegrid.grid[_currentTileY][_currentTileX] = 1;
				Tilegrid.tiles[_currentTileX + _currentTileY * Tilegrid.grid[0].length].gotoAndStop(Tilegrid.grid[_currentTileY][_currentTileX]);
			} else if (currentTile == 3) {
				// Big dot
				UI.SCORE += 50;
				Tilegrid.grid[_currentTileY][_currentTileX] = 1;
				Tilegrid.tiles[_currentTileX + _currentTileY * Tilegrid.grid[0].length].gotoAndStop(Tilegrid.grid[_currentTileY][_currentTileX]);
				timer_powerup.start();
				timer_powerup.addEventListener(TimerEvent.TIMER, removePowerUp);
				Game.powerUp = true;
			}
			
			// The tubes
			if (currentTile == -1 && _directionX != 1) {
				this.x = stage.stageWidth;
			} else if (currentTile == -2 && _directionX != -1) {
				this.x = 0;
			}
			
		}
		
		private function removePowerUp(e:TimerEvent):void 
		{
			Game.powerUp = false;
			timer_powerup.reset();
		}
		
		private var timer:Timer = new Timer(500);
		private var timer2:Timer = new Timer(1330);
		
		public function dead():void {
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, respawn);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function respawn(e:TimerEvent):void {
			timer.stop();
			_playerArt.gotoAndStop(DEAD);
			timer2.start();
			timer2.addEventListener(TimerEvent.TIMER, resetPos);
		}
		
		private function resetPos(e:TimerEvent):void {
			timer2.reset();
			
			_directionX = 0;
			_directionY = 0;
			this.x = 14 * Tilegrid.TILE_SIZE;
			this.y = 26 * Tilegrid.TILE_SIZE;
			_playerArt.gotoAndStop(IDLE);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function destroy():void {
			removeEventListener(Event.ENTER_FRAME, update);
			//stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			//removeChild(_playerArt);
		}
		
	}

}