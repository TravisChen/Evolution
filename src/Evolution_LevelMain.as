package    {
		
	import org.flixel.*;
	
	public class Evolution_LevelMain extends Level{
		
		[Embed(source = '../data/sky.png')] private var ImgSky:Class;
		[Embed(source = '../data/clouds1.png')] private var ImgClouds1:Class;
		[Embed(source = '../data/clouds2.png')] private var ImgClouds2:Class;
		[Embed(source = '../data/clouds3.png')] private var ImgClouds3:Class;
		[Embed(source = '../data/stage.png')] private var ImgBackground:Class;
		[Embed(source = '../data/grass.png')] private var ImgForeground:Class;
		[Embed(source='../data/inventory.png')] private var ImgInventory:Class;
		
		[Embed(source='../data/Tilemaps/map-tiles.png')] private var ImgTiles:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_Boundary.txt',mimeType="application/octet-stream")] private var TxtMap:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_Platforms.txt',mimeType="application/octet-stream")] private var TxtMapPlatforms:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_HUD.txt',mimeType="application/octet-stream")] private var TxtHudMap:Class;
		
		private var pointsText:FlxText;
		
		private var tilemap:FlxTilemap;
		private var platformsTilemap:FlxTilemap;
		private var hudTilemap:FlxTilemap;
		
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
			
			levelSizeX = 714;
			levelSizeY = 128;
			
			// Tilemap
			tilemap = new FlxTilemap();
			tilemap.loadMap(new TxtMap,ImgTiles,8);
			tilemap.visible = false;
			PlayState.groupTilemap.add(tilemap);
			tilemap.follow();
			
			platformsTilemap = new FlxTilemap();
			platformsTilemap.loadMap(new TxtMapPlatforms,ImgTiles,8);
			platformsTilemap.visible = false;
			PlayState.groupTilemap.add(platformsTilemap);
			platformsTilemap.follow();
			
			hudTilemap = new FlxTilemap();
			hudTilemap.loadMap(new TxtHudMap,ImgTiles,8);
			hudTilemap.visible = false;
			PlayState.groupTilemap.add(hudTilemap);

			// Create player
			player = new Player(FlxG.width/2,FlxG.height - 40);
			PlayState.groupPlayer.add(player);

			// Create player
			enemy = new Enemy(FlxG.width/4,FlxG.height - 40);
			PlayState.groupPlayer.add(enemy);

			// Inventory
			inventory = new Inventory(FlxG.width - 76,FlxG.height - 76, hudTilemap);
			inventory.scrollFactor.x = inventory.scrollFactor.y = 0;
			PlayState.groupForeground.add(inventory);
			
			// Create skull spawner
			var skullSpawner:SkullSpawner = new SkullSpawner( player, tilemap, inventory);
			PlayState.groupCollects.add(skullSpawner);
			
			// Timer
			timer = MAX_TIME;
			timerText = new FlxText(0, 0, FlxG.width, "0:00");
			timerText.setFormat(null,16,TEXT_COLOR,"center");
			timerText.scrollFactor.x = timerText.scrollFactor.y = 0;
			PlayState.groupForeground.add(timerText);
			
			points = 0;
			pointsText = new FlxText(0, 0, FlxG.width, "0");
			pointsText.setFormat(null,16,TEXT_COLOR,"right");
			pointsText.scrollFactor.x = pointsText.scrollFactor.y = 0;
			PlayState.groupForeground.add(pointsText);
			
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
			var skySprite:FlxSprite;
			skySprite = new FlxSprite(0,0);
			skySprite.loadGraphic(ImgSky, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(skySprite);

			var clouds1:FlxSprite;
			clouds1 = new FlxSprite(0,0);
			clouds1.scrollFactor.x = clouds1.scrollFactor.y = 0.3;
			clouds1.loadGraphic(ImgClouds1, true, true, levelSizeX, levelSizeY);	
			PlayState.groupClouds.add(clouds1);
			
			var clouds2:FlxSprite;
			clouds2 = new FlxSprite(0,0);
			clouds2.scrollFactor.x = clouds2.scrollFactor.y = 0.2;
			clouds2.loadGraphic(ImgClouds2, true, true, levelSizeX, levelSizeY);	
			PlayState.groupClouds.add(clouds2);
			
			var clouds3:FlxSprite;
			clouds3 = new FlxSprite(0,0);
			clouds3.scrollFactor.x = clouds3.scrollFactor.y = 0.1;
			clouds3.loadGraphic(ImgClouds3, true, true, levelSizeX, levelSizeY);	
			PlayState.groupClouds.add(clouds3);
			
			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupTilemap.add(backgroundSprite);
			
			var foregroundSprite:FlxSprite;
			foregroundSprite = new FlxSprite(0,0);
			foregroundSprite.loadGraphic(ImgForeground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupLevelForeground.add(foregroundSprite);
		}
		
		override public function update():void
		{
			// Collide
			if( player.velocity.y >= 0 )
			{
				FlxG.collide(platformsTilemap,player);
			}
			hudTilemap.x = FlxG.camera.scroll.x;
			FlxG.collide(tilemap,player);
			FlxG.collide(tilemap,enemy);
			FlxG.collide(player,enemy);
			
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
			
			// Update points text
			pointsText.text = "" + points;
			
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
