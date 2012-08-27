package    {
		
	import org.flixel.*;
	
	public class Evolution_LevelMain extends Level{
		
		[Embed(source = '../data/Audio/evolution.mp3')] private var SndEvolutionSong:Class;
		
		[Embed(source = '../data/sky.png')] private var ImgSky:Class;
		[Embed(source = '../data/clouds1.png')] private var ImgClouds1:Class;
		[Embed(source = '../data/clouds2.png')] private var ImgClouds2:Class;
		[Embed(source = '../data/clouds3.png')] private var ImgClouds3:Class;
		[Embed(source = '../data/stage.png')] private var ImgBackground:Class;
		[Embed(source = '../data/grass.png')] private var ImgForeground:Class;
		[Embed(source='../data/inventory.png')] private var ImgInventory:Class;
		[Embed(source='../data/roundend.png')] private var ImgRoundEnd:Class;
		
		[Embed(source='../data/Tilemaps/map-tiles.png')] private var ImgTiles:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_Boundary.txt',mimeType="application/octet-stream")] private var TxtMap:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_Platforms.txt',mimeType="application/octet-stream")] private var TxtMapPlatforms:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_HUD.txt',mimeType="application/octet-stream")] private var TxtHudMap:Class;
		
		private var pointsText:FlxText;
		public var startTime:Number;
		public var endTime:Number;
		
		private var tilemap:FlxTilemap;
		private var platformsTilemap:FlxTilemap;
		private var hudTilemap:FlxTilemap;
		
		private var timer:Number;
		private var timerText:FlxText;

		private var roundEnd:Boolean;
		private var roundEndForeground:FlxSprite;
		private var roundEndContinueText:FlxText;
		private var roundEndPointsText:FlxText;
		
		private var inventory:Inventory;
		
		public const MAX_TIME:uint = 120;
		public const TEXT_COLOR:uint = 0xFFF8CA00;
		
		public var sound:FlxSound;
		
		public function Evolution_LevelMain( group:FlxGroup ) {
			
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
			player = new Player(300,FlxG.height - 40);
			PlayState.groupPlayer.add(player);

			// Create player
			enemy = new Enemy(150,FlxG.height - 40);
			PlayState.groupPlayer.add(enemy);

			// Inventory
			inventory = new Inventory(FlxG.width - 76,FlxG.height - 81, hudTilemap);
			inventory.scrollFactor.x = inventory.scrollFactor.y = 0;
			PlayState.groupForeground.add(inventory);
			
			// Create skull spawner
			var skullSpawner:SkullSpawner = new SkullSpawner( player, tilemap, inventory);
			PlayState.groupCollects.add(skullSpawner);
			
			createForegroundAndBackground();
			
			// Timer
			startTime = 1.0;
			timer = MAX_TIME;
			timerText = new FlxText(0, 0, FlxG.width, "0:00");
			timerText.setFormat(null,16,TEXT_COLOR,"left");
			timerText.scrollFactor.x = timerText.scrollFactor.y = 0;
			PlayState.groupBackground.add(timerText);
			
			endTime = 3.0;
			
			points = 0;
			pointsText = new FlxText(0, 0, FlxG.width, "0");
			pointsText.setFormat(null,8,TEXT_COLOR,"center");
			pointsText.scrollFactor.x = pointsText.scrollFactor.y = 0;
			PlayState.groupBackground.add(pointsText);
			
			roundEnd = false;
			buildRoundEnd();

			// Music
			FlxG.playMusic(SndEvolutionSong,0.2);
			
			super();
		}
		
		public function buildRoundEnd():void {
			
			roundEndForeground = new FlxSprite(0,0);
			roundEndForeground.loadGraphic(ImgRoundEnd, true, true, 320, 128);
			roundEndForeground.scrollFactor.x = roundEndForeground.scrollFactor.y = 0;
			roundEndForeground.visible = false;
			PlayState.groupForegroundHighest.add(roundEndForeground);
			
			roundEndContinueText = new FlxText(0, 116, FlxG.width, "PRESS ANY KEY TO CONTINUE");
			roundEndContinueText.setFormat(null,8,TEXT_COLOR,"center");
			roundEndContinueText.scrollFactor.x = roundEndContinueText.scrollFactor.y = 0;	
			roundEndContinueText.visible = false;
			PlayState.groupForegroundHighest.add(roundEndContinueText);
			
			roundEndPointsText = new FlxText(FlxG.width/2, 85, FlxG.width, "0");
			roundEndPointsText.setFormat(null,16,TEXT_COLOR,"left");
			roundEndPointsText.scrollFactor.x = roundEndContinueText.scrollFactor.y = 0;	
			roundEndPointsText.visible = false;
			PlayState.groupForegroundHighest.add(roundEndPointsText);
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
			
			// Timer
			var minutes:uint = timer/60;
			var seconds:uint = timer - minutes*60;
			if( startTime <= 0 )
			{
				timer -= FlxG.elapsed;
			}
			else
			{
				startTime -= FlxG.elapsed;
			}
			
			// Check round end
			if( timer <= 0 )
			{
				showEndPrompt();
				if( endTime <= 0 )
				{
					checkAnyKey();					
				}
				else
				{
					endTime -= FlxG.elapsed;
				}
				return;
			}
			
			// Update timer text
			if( seconds < 10 )
				timerText.text = "" + minutes + ":0" + seconds;
			else
				timerText.text = "" + minutes + ":" + seconds;
			
			// Update points text
			pointsText.text = "" + points + " (" + PlayState._currLevel.multiplier + "x)";
			roundEndPointsText.text = "" + points;
			
			super.update();
		}
		
		private function showEndPrompt():void 
		{
			PlayState._currLevel.player.roundOver = true;
			roundEndForeground.visible = true;
			roundEndPointsText.visible = true;
		}
		
		private function checkAnyKey():void 
		{
			FlxG.music.stop();
			roundEndContinueText.visible = true;
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
