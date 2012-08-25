package    {
	
	import org.flixel.*;
	
	public class TinyWorld_Level5 extends Level{
		
		[Embed(source = '../data/window-back.png')] private var ImgBackground:Class;
		[Embed(source = '../data/window-fore.png')] private var ImgForeground:Class;
		[Embed(source = '../data/world.png')] private var ImgWorld:Class;
		
		[Embed(source= '../data/Audio/hum.mp3')] public var Hum:Class;
		[Embed(source= '../data/Audio/window.mp3')] public var WindowAudio:Class;
		
		public var sound:FlxSound;
		public var soundEngineNoise:FlxSound;	
		
		public var worldSprite:FlxSprite;	
		
		public function TinyWorld_Level5( group:FlxGroup ) {
			
			super();

			soundEngineNoise = new FlxSound();
			playHum();
			
			sound = new FlxSound();
			sound.loadEmbedded(WindowAudio, false, true);
			sound.play();
			
			levelSizeX = 178;
			levelSizeY = 120;
			
			// Create player
			player = new Player(-180,10);
			PlayState.groupPlayer.add(player);
			Helpers.scale(player,10.0);
			
			createForegroundAndBackground();
		}
		
		public function createForegroundAndBackground():void {
			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(backgroundSprite);
			
			worldSprite = new FlxSprite(70,80);
			worldSprite.loadGraphic(ImgWorld, true, true, 112, 113);	
			PlayState.groupBackground.add(worldSprite);
			
			var foregroundSprite:FlxSprite;
			foregroundSprite = new FlxSprite(0,0);
			foregroundSprite.loadGraphic(ImgForeground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(foregroundSprite);
		}
		
		override public function update():void{
			worldSprite.y = worldSprite.y - 0.1;	
			worldSprite.x = worldSprite.x - 0.02;	
		}
		
		public function playHum():void
		{
			soundEngineNoise.loadEmbedded(Hum,true,true);
			soundEngineNoise.play();
		}
		
		override public function nextLevel():Boolean
		{
			if( worldSprite.y < -50 )
			{
				soundEngineNoise.stop();
				soundEngineNoise.destroy();
				
				sound.stop();
				sound.destroy();
				
				return true;
			}
			return false;
		}
	}
}
