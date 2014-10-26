package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;

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
		
		public function Player() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_playerArt = new PlayerArt;
			addChild(_playerArt);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function keyDown(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37:	// LEFT
					_directionX = -1;
					_directionY = 0;
					break;
				case 38:	// UP
					_directionX = 0;
					_directionY = -1;
					break;
				case 39:	// RIGHT
					_directionX = 1;
					_directionY = 0;
					break;
				case 40:	// DOWN
					_directionX = 0;
					_directionY = 1;
					break;
			}
		}
		
		private function update(e:Event):void {
			tileMovement();
			pickups();
		}
		
		private function tileMovement():void {
			if (this.x / Tilegrid.TILE_SIZE % 1 == 0 && this.y / Tilegrid.TILE_SIZE % 1 == 0) {
				
				_currentTileX = this.x / Tilegrid.TILE_SIZE;
				_currentTileY = this.y / Tilegrid.TILE_SIZE;
			}
			
			if (Tilegrid.grid[_currentTileY + _directionY][_currentTileX + _directionX] <= 2 && this.x / Tilegrid.TILE_SIZE % 1 == 0 && this.y / Tilegrid.TILE_SIZE % 1 == 0) {
				
				this.x += _speed * _directionX;
				this.y += _speed * _directionY;
				_previousDirX = _directionX;
				_previousDirY = _directionY;
				
			} else if (Tilegrid.grid[_currentTileY + _previousDirY][_currentTileX + _previousDirX] <= 2) {
				
				this.x += _speed * _previousDirX;
				this.y += _speed * _previousDirY;
			}
		}
		
		private function pickups():void {
			var currentTile : Number = Tilegrid.grid[_currentTileY][_currentTileX];
			if (currentTile == 2) {
				trace(currentTile);
				Tilegrid.grid[_currentTileY][_currentTileX] = 1;
				Tilegrid.tiles[_currentTileX + _currentTileY * Tilegrid.grid[0].length].gotoAndStop(Tilegrid.grid[_currentTileY][_currentTileX]);
				
				//_tilegrid.updateGrid();
			} else {
				trace(currentTile);
			}
		}
		
	}

}