package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class UI extends Sprite {
		
		private var playerText : TextField = new TextField();
		private var scoreCounter : TextField = new TextField();
		private var highscoreText : TextField = new TextField();
		private var highscoreCounter : TextField = new TextField();
		private var gameoverText : TextField = new TextField();
		private var lifesText : TextField = new TextField();
		
		public static var SCORE : int = 0;
		public static const RESTART_GAME:String = "restartGame";
		private var highscore : int;
		private var textFormat : TextFormat = new TextFormat();
		
		public function UI() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, updateUI);
			// Entry
			
			// MakeUp
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0xffffff;
			
			playerText.defaultTextFormat = textFormat;
			scoreCounter.defaultTextFormat = textFormat;
			highscoreText.defaultTextFormat = textFormat;
			highscoreCounter.defaultTextFormat = textFormat;
			gameoverText.defaultTextFormat = textFormat;
			lifesText.defaultTextFormat = textFormat;
			
			playerText.text = "1UP"; // make it flicker
			scoreCounter.text = SCORE.toString();
			highscoreText.text = "HIGH SCORE";
			highscoreCounter.text = highscore.toString();
			gameoverText.text = "GAME OVER";
			lifesText.text = "Lifes: " + Game.hp.toString();
			
			
			// Positions
			playerText.x 	= 5 	* Tilegrid.TILE_SIZE;
			playerText.y 	= 0 	* Tilegrid.TILE_SIZE;
			
			scoreCounter.x 	= 5 	* Tilegrid.TILE_SIZE;
			scoreCounter.y 	= 1 	* Tilegrid.TILE_SIZE;
			
			highscoreText.x = 14 	* Tilegrid.TILE_SIZE;
			highscoreText.y = 0 	* Tilegrid.TILE_SIZE;
			
			highscoreCounter.x = 14 * Tilegrid.TILE_SIZE;
			highscoreCounter.y = 1 	* Tilegrid.TILE_SIZE;
			
			gameoverText.x = 11 	* Tilegrid.TILE_SIZE;
			gameoverText.y = 20 	* Tilegrid.TILE_SIZE;
			
			lifesText.x = 5			* Tilegrid.TILE_SIZE;
			lifesText.y = 34		* Tilegrid.TILE_SIZE;
			
			// Adding
			addChild(playerText);
			addChild(scoreCounter);
			addChild(highscoreText);
			addChild(highscoreCounter);
			addChild(gameoverText);
			addChild(lifesText);
			
			gameoverText.visible = false;
			gameoverText.textColor = 0xff0000;
		}
		
		public function updateUI(e:Event):void {
			scoreCounter.text = SCORE.toString();
			lifesText.text = "Lifes: " + Game.hp.toString();
			if (SCORE > highscore) {
				highscore = SCORE;
				highscoreCounter.text = highscore.toString();
			}
		}
		
		public function gameOver():void {
			gameoverText.visible = true;
		}
		
	}

}