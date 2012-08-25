package    {
		
	import org.flixel.*;
	
	public class Evolution_Level1 extends Level{
		
		[Embed(source = '../data/shuttle-gantry-back.png')] private var ImgBackground:Class;
		[Embed(source = '../data/shuttle-gantry-fore.png')] private var ImgForeground:Class;
		[Embed(source= '../data/Audio/hum.mp3')] public var Hum:Class;
		
		public var soundEngineNoise:FlxSound;	
		
		public function Evolution_Level1( group:FlxGroup ) {
			
			super();
			
			soundEngineNoise = new FlxSound();
			playHum();
			
			levelSizeX = 406;
			levelSizeY = 120;
			endX = 275;
			
			// Create player
			player = new Player(0,66);
			PlayState.groupPlayer.add(player);

			createForegroundAndBackground();
		}
		
		public function createForegroundAndBackground():void {
			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(backgroundSprite);
			
			var foregroundSprite:FlxSprite;
			foregroundSprite = new FlxSprite(0,0);
			foregroundSprite.loadGraphic(ImgForeground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupForeground.add(foregroundSprite);
		}
		
		override public function nextLevel():Boolean
		{
			if( player.x >= endX )
			{
				soundEngineNoise.stop();
				soundEngineNoise.destroy();
				return true;
			}
			return false;
		}

		public function playHum():void
		{
			soundEngineNoise.loadEmbedded(Hum,true,true);
			soundEngineNoise.play();
		}
		
	}
}
