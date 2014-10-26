package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class AI extends Sprite {	
		
		protected var _aiArt : MovieClip;
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
		//private const IDLE 	: int = 1;
		private const LEFT 	: int = 2;
		private const UP 	: int = 3;
		private const RIGHT : int = 4;
		private const DOWN 	: int = 5;
		
		public function AI() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		// ABSTRACT function
		internal function drawAI():void {
			
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Entry
			drawAI();
			
			addChild(_aiArt);
			
			_aiArt.gotoAndStop(LEFT);
			_aiArt.scaleX = 1.2;
			_aiArt.scaleY = 1.3;
		}
		
		private function getMovement():void {
			switch(Math.floor(Math.random() * 4)) {
				case 0:	// LEFT
					_directionX = -1;
					_directionY = 0;
					faceTo = LEFT;
					break;
				case 1:	// UP
					_directionX = 0;
					_directionY = -1;
					faceTo = UP;
					break;
				case 2:	// RIGHT
					_directionX = 1;
					_directionY = 0;
					faceTo = RIGHT;
					break;
				case 3:	// DOWN
					_directionX = 0;
					_directionY = 1;
					faceTo = DOWN;
					break;
			}
		}
		
		public function update():void {
			getMovement();
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
				
				_aiArt.gotoAndStop(faceTo);
				
				_previousDirX = _directionX;
				_previousDirY = _directionY;
				
			} else if (Tilegrid.grid[_currentTileY + _previousDirY][_currentTileX + _previousDirX] <= 3) {
				
				this.x += _speed * _previousDirX;
				this.y += _speed * _previousDirY;
			}
		}
		
		private function collisions():void {
			var currentTile : Number = Tilegrid.grid[_currentTileY][_currentTileX];
			
			// The tubes
			if (currentTile == -1 && _directionX != 1) {
				this.x = stage.stageWidth;
			} else if (currentTile == -2 && _directionX != -1) {
				this.x = 0;
			}
		}
		
	}

}