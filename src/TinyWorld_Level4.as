package    {
	
	import org.flixel.*;
	
	public class TinyWorld_Level4 extends Level{
		
		[Embed(source= '../data/Audio/hallway.mp3')] public var HallwayAudio:Class;
		
		[Embed(source= '../data/Audio/hum.mp3')] public var Hum:Class;
		
		public var sound:FlxSound;
		public var soundEngineNoise:FlxSound;	
		
		public function TinyWorld_Level4( group:FlxGroup ) {
			
			super();
			
			soundEngineNoise = new FlxSound();
			playHum();
			
			sound = new FlxSound();
			sound.loadEmbedded(HallwayAudio, false, true);
			sound.play();
			
			levelSizeX = 178;
			levelSizeY = 120;
			
			// Create player
			playerZeroG = new PlayerZeroG(16,80);
			PlayState.groupPlayer.add(playerZeroG);
			
			createForegroundAndBackground();
		}
		
		public function createForegroundAndBackground():void {
			var backgroundSprite:FlxSprite = new ShuttleHall(0,0);
			PlayState.groupBackground.add(backgroundSprite);
		}

		public function playHum():void
		{
			soundEngineNoise.loadEmbedded(Hum,true,true);
			soundEngineNoise.play();
		}
		
		override public function nextLevel():Boolean
		{
			if( playerZeroG.y <= 0)
			{
				soundEngineNoise.stop();
				soundEngineNoise.destroy();
				
				sound.stop();
				sound.destroy();
				return true;
			}
			return false;
		}
		
		override public function destroy():void
		{
		}
	}
}
