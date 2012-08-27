package    {
	
	import org.flixel.*;
	
	public class Evolution_LevelMenu extends Level{
		
		[Embed(source = '../data/intro.png')] private var ImgBackground:Class;
		[Embed(source = '../data/wasd.png')] private var ImgWasd:Class;
		[Embed(source='../data/Tilemaps/map-tiles.png')] private var ImgTiles:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_Intro.txt',mimeType="application/octet-stream")] private var TxtMap:Class;
		
		private var _particle:FlxEmitter;
		
		private var tilemap:FlxTilemap;
		public const TEXT_COLOR:uint = 0xFF33d72ae;
		public const TEXT_COLOR_LIGHT:uint = 0xFFbeec5b;
		
		public var wasd:FlxSprite;
		public var wasdFadeInTime:Number;
		public var wasdBounceTime:Number;
		public var wasdBounceToggle:Boolean;
		
		public var playerIntro:PlayerIntro;
		public var startTime:Number;

		public function Evolution_LevelMenu( group:FlxGroup ) {
			
			super();
			
			levelSizeX = 320;
			levelSizeY = 128;
			
			// Tilemap
			tilemap = new FlxTilemap();
			tilemap.loadMap(new TxtMap,ImgTiles,8);
			tilemap.visible = false;
			PlayState.groupTilemap.add(tilemap);

			wasdFadeInTime = 0.5;
			wasdBounceToggle = true;
			wasdBounceTime = 0;
			
			startTime = 1.0;
			
			// Create player
			playerIntro = new PlayerIntro(FlxG.width/2 - 16,FlxG.height - 50,tilemap);
			PlayState.groupPlayer.add(playerIntro);
			
			createForegroundAndBackground();
		}
		
		override public function nextLevel():Boolean
		{
			if( startTime > 0 )
			{
				startTime -= FlxG.elapsed;
				return false;
			}
			
			if(FlxG.keys.any() )
			{
				return true;
			}
			return false;
		}
		
		public function createForegroundAndBackground():void {
			
			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(backgroundSprite);
			
			wasd = new FlxSprite(0,0);
			wasd.loadGraphic(ImgWasd, true, true, 32, 32);	
			wasd.x = FlxG.width/2 - 52;
			wasd.y = 86;
			wasd.alpha = 0;
			PlayState.groupForeground.add(wasd);
	
		}
		
		
		public function updateNumPad():void 
		{		
			if( wasdFadeInTime <= 0 )
			{
				if( wasd.alpha < 1 )
				{
					wasd.alpha += 0.025;		
				}
				else
				{
					if( wasdBounceTime <= 0 )
					{
						wasdBounceTime = 0.02;
						if( wasdBounceToggle )
						{
							wasd.y += 1;
							wasdBounceToggle = false;
						}
						else
						{
							wasd.y -= 1;
							wasdBounceToggle = true;
						}
					}
					else
					{
						wasdBounceTime -= FlxG.elapsed;
					}
				}
			}
			else
			{
				wasdFadeInTime -= FlxG.elapsed;
			}
		}
		
		override public function update():void
		{			
			//UPDATE POSITION AND ANIMATION
			super.update();
			updateNumPad();
		}	
	}
}
