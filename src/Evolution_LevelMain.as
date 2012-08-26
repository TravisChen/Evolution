package    {
		
	import org.flixel.*;
	
	public class Evolution_LevelMain extends Level{
		
		[Embed(source = '../data/stage.png')] private var ImgBackground:Class;
		[Embed(source = '../data/grass.png')] private var ImgForeground:Class;
		[Embed(source='../data/inventory.png')] private var ImgInventory:Class;
		
		[Embed(source='../data/Tilemaps/map-tiles.png')] private var ImgTiles:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_Boundary.txt',mimeType="application/octet-stream")] private var TxtMap:Class;
		
		private var points:Number;
		private var pointsText:FlxText;
		
		private var tilemap:FlxTilemap;
		private var timer:Number;
		private var timerText:FlxText;

		private var roundEnd:Boolean;
		private var roundEndText:FlxText;
		private var roundEndContinueText:FlxText;
		
		private var inventory:Inventory;
		
		public const MAX_TIME:uint = 60;
		public const TEXT_COLOR:uint = 0xFFF8CA00;
		
		public function Evolution_LevelMain( group:FlxGroup ) {
			
			super();
			
			levelSizeX = 640;
			levelSizeY = 128;
			
			// Tilemap
			tilemap = new FlxTilemap();
			tilemap.loadMap(new TxtMap,ImgTiles,8);
			tilemap.visible = false;
			PlayState.groupTilemap.add(tilemap);
			tilemap.follow();
			
			// Create player
			player = new Player(100,72);
			PlayState.groupPlayer.add(player);

			// Create collect
			var skull:Skull = new Skull(200, FlxG.height - 40, player, PlayState.groupForeground, tilemap);
			var skull2:Skull = new Skull(80, FlxG.height - 40, player, PlayState.groupForeground, tilemap);
			PlayState.groupCollects.add(skull);
			PlayState.groupCollects.add(skull2);
			
			// Timer
			timer = MAX_TIME;
			timerText = new FlxText(0, 0, FlxG.width, "0:00");
			timerText.setFormat(null,16,TEXT_COLOR,"center");
			timerText.scrollFactor.x = timerText.scrollFactor.y = 0;
			PlayState.groupForeground.add(timerText);
			
			points = MAX_TIME;
			pointsText = new FlxText(0, 0, FlxG.width, "0");
			pointsText.setFormat(null,16,TEXT_COLOR,"right");
			pointsText.scrollFactor.x = pointsText.scrollFactor.y = 0;
			PlayState.groupForeground.add(pointsText);
			
			// Inventory
			inventory = new Inventory(FlxG.width - 76,FlxG.height - 76);
			inventory.scrollFactor.x = inventory.scrollFactor.y = 0;
			PlayState.groupForeground.add(inventory);
			
			roundEnd = false;
			buildRoundEnd();
			
			createForegroundAndBackground();
		}
		
		public function buildRoundEnd():void {
			roundEndText = new FlxText(0, 40, FlxG.width, "ROUND END");
			roundEndText.setFormat(null,16,TEXT_COLOR,"center");
			roundEndText.scrollFactor.x = roundEndText.scrollFactor.y = 0;	
			PlayState.groupForeground.add(roundEndText);
			roundEndText.alpha = 0;
			
			roundEndContinueText = new FlxText(0, 64, FlxG.width, "PRESS ANY KEY TO CONTINUE");
			roundEndContinueText.setFormat(null,8,TEXT_COLOR,"center");
			roundEndContinueText.scrollFactor.x = roundEndContinueText.scrollFactor.y = 0;	
			PlayState.groupForeground.add(roundEndContinueText);
			roundEndContinueText.alpha = 0;
		}
		
		public function createForegroundAndBackground():void {
			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(backgroundSprite);
			
			var foregroundSprite:FlxSprite;
			foregroundSprite = new FlxSprite(0,0);
			foregroundSprite.loadGraphic(ImgForeground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupLevelForeground.add(foregroundSprite);
		}
		
		override public function update():void
		{
			// Collide
			FlxG.collide(tilemap,player);
			
			// Timer
			var minutes:uint = timer/60;
			var seconds:uint = timer - minutes*60;
			timer -= FlxG.elapsed;

			// Check round end
			if( timer <= 0 )
			{
				showEndPrompt();
				return;
			}
			
			// Update timer text
			if( seconds < 10 )
				timerText.text = "" + minutes + ":0" + seconds;
			else
				timerText.text = "" + minutes + ":" + seconds;
			
			super.update();
		}
		
		private function showEndPrompt():void 
		{
			roundEndText.alpha = 1;
			roundEndContinueText.alpha = 1;
			if (FlxG.keys.any())
			{
				FlxG.flash(0xffffffff, 0.75);
				roundEnd = true;
			}		
		}
		
		override public function nextLevel():Boolean
		{
			if( roundEnd )
			{
				return true;
			}
			return false;
		}

		public function playHum():void
		{
		}
		
	}
}
