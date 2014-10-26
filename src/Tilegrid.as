package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TouchEvent;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Tilegrid extends Sprite {
		
		// tilesX 		28
		// tilesY 		36
		// tileRes		8x8			*2= 16x16
		// screenRes	224x288		*2= 448x576
		public static const TILE_SIZE	: uint = 16;
		public static const GRID_WIDTH	: uint = 28;
		public static const GRID_HEIGHT: uint = 36;
		//private var _block01	: Tile01;
		//private var _block02	: Tile01;
		//private var _testWall	: TestWall;
		private var smallPoints : Array = [];
		public static var tiles : Array = [];
		public static var grid : Array = [
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
		,	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
		,	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
			
		,	[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]
		,	[3,2,2,2,2,2,2,2,2,2,2,2,2,3,3,2,2,2,2,2,2,2,2,2,2,2,2,3]
		,	[3,2,3,3,3,3,2,3,3,3,3,3,2,3,3,2,3,3,3,3,3,2,3,3,3,3,2,3]
		,	[3,4,3,1,1,3,2,3,1,1,1,3,2,3,3,2,3,1,1,1,3,2,3,1,1,3,4,3]
		,	[3,2,3,3,3,3,2,3,3,3,3,3,2,3,3,2,3,3,3,3,3,2,3,3,3,3,2,3]
		,	[3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3]
		,	[3,2,3,3,3,3,2,3,3,2,3,3,3,3,3,3,3,3,2,3,3,2,3,3,3,3,2,3]
		,	[3,2,3,3,3,3,2,3,3,2,3,3,3,3,3,3,3,3,2,3,3,2,3,3,3,3,2,3]
		,	[3,2,2,2,2,2,2,3,3,2,2,2,2,3,3,2,2,2,2,3,3,2,2,2,2,2,2,3]
		,	[3,3,3,3,3,3,2,3,3,3,3,3,1,3,3,1,3,3,3,3,3,2,3,3,3,3,3,3]//10
		,	[1,1,1,1,1,3,2,3,3,3,3,3,1,3,3,1,3,3,3,3,3,2,3,1,1,1,1,1]
		,	[1,1,1,1,1,3,2,3,3,1,1,1,1,1,1,1,1,1,1,3,3,2,3,1,1,1,1,1]
		,	[1,1,1,1,1,3,2,3,3,1,3,3,3,1,1,3,3,3,1,3,3,2,3,1,1,1,1,1]
		,	[3,3,3,3,3,3,2,3,3,1,3,1,1,1,1,1,1,3,1,3,3,2,3,3,3,3,3,3]
		,	[1,1,1,1,1,1,2,1,1,1,3,1,1,1,1,1,1,3,1,1,1,2,1,1,1,1,1,1]
		,	[3,3,3,3,3,3,2,3,3,1,3,1,1,1,1,1,1,3,1,3,3,2,3,3,3,3,3,3]
		,	[1,1,1,1,1,3,2,3,3,1,3,3,3,3,3,3,3,3,1,3,3,2,3,1,1,1,1,1]
		,	[1,1,1,1,1,3,2,3,3,1,1,1,1,1,1,1,1,1,1,3,3,2,3,1,1,1,1,1]
		,	[1,1,1,1,1,3,2,3,3,1,3,3,3,3,3,3,3,3,1,3,3,2,3,1,1,1,1,1]
		,	[3,3,3,3,3,3,2,3,3,1,3,3,3,3,3,3,3,3,1,3,3,2,3,3,3,3,3,3]//20
		,	[3,2,2,2,2,2,2,2,2,2,2,2,2,3,3,2,2,2,2,2,2,2,2,2,2,2,2,3]
		,	[3,2,3,3,3,3,2,3,3,3,3,3,2,3,3,2,3,3,3,3,3,2,3,3,3,3,2,3]
		,	[3,2,3,3,3,3,2,3,3,3,3,3,2,3,3,2,3,3,3,3,3,2,3,3,3,3,2,3]
		,	[3,4,2,2,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,2,2,4,3]
		,	[3,3,3,2,3,3,2,3,3,2,3,3,3,3,3,3,3,3,2,3,3,2,3,3,2,3,3,3]
		,	[3,3,3,2,3,3,2,3,3,2,3,3,3,3,3,3,3,3,2,3,3,2,3,3,2,3,3,3]
		,	[3,2,2,2,2,2,2,3,3,2,2,2,2,3,3,2,2,2,2,3,3,2,2,2,2,2,2,3]
		,	[3,2,3,3,3,3,3,3,3,3,3,3,2,3,3,2,3,3,3,3,3,3,3,3,3,3,2,3]
		,	[3,2,3,3,3,3,3,3,3,3,3,3,2,3,3,2,3,3,3,3,3,3,3,3,3,3,2,3]
		,	[3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3]//30
		,	[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]
		
		,	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
		,	[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]//36
		];						//10				//20			//28
		
		public function Tilegrid() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//addEventListener(Event.ENTER_FRAME, update);
			
			updateGrid();
		}
		
		public function updateGrid():void {
			trace("Update Grid");
			// Loops rows
			var level01_l : uint = grid.length;
			for (var rows : uint = 0; rows < level01_l; rows++) {
				
				// Loops columns
				var level01_rows_l : uint = grid[rows].length;
				for (var cols : uint = 0; cols < level01_rows_l; cols++) {
					
					var newTile : TileArt = new TileArt;
					newTile.x = cols * TILE_SIZE;
					newTile.y = rows * TILE_SIZE;
					newTile.gotoAndStop(grid[rows][cols]);
					tiles.push(newTile);
					
					addChild(newTile);
					
					/*
					switch (grid[rows][cols]) {
						case 0:
							break;
						case 2:
							
							_block02 = new Tile01;
							addChild(_block02);
							_block02.x = _block02.width * cols;
							_block02.y = _block02.height * rows;
							_block02.alpha = 0.75;
							
							break;
						case 1:
							_dot = new Dot;
							addChild(_dot); 
							_dot.x = _dot.width * cols;
							_dot.y = _dot.height * rows;
							smallPoints.push(_dot);
							break;
					}
					*/
					
				}	
			}
		}
		
	}

}