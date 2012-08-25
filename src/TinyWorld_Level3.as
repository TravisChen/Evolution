package    {
	
	import org.flixel.*;
	
	public class TinyWorld_Level3 extends Level{
		
		[Embed(source= '../data/Audio/launch.mp3')] public var LaunchAudio:Class;
		[Embed(source = '../data/atmosphere-back.png')] private var ImgBackground:Class;

		public var sound:FlxSound;
		
		public var negativeReturnTimer:Number = 37.5;
		public var isNegativeReturn:Boolean = false;

		public var boosterSeperationTimer:Number = 12.0;
		public var isBoosterSeperation:Boolean = false;
		
		public function TinyWorld_Level3( group:FlxGroup ) {
			
			super();
			
			sound = new FlxSound();
			sound.loadEmbedded(LaunchAudio, false, true);
			sound.play();
			
			levelSizeX = 178;
			levelSizeY = 500;
			endX = 275;
			
			// Create player
			shuttle = new Shuttle(89 - 8,450);
			PlayState.groupPlayer.add(shuttle);
			
			createForegroundAndBackground();
		}
		
		public function boosterSeperation():void
		{
			
		}
		
		override public function update():void
		{
			FlxG.bgColor = 0x11000000;
			
			if( boosterSeperationTimer >= 0.0 )
			{
				boosterSeperationTimer = boosterSeperationTimer - FlxG.elapsed
			}
			else
			{
				if( !isBoosterSeperation )
				{
					isBoosterSeperation = true;
					boosterSeperation();
				}
			}
			
			if( negativeReturnTimer >= 0.0 )
			{
				negativeReturnTimer = negativeReturnTimer - FlxG.elapsed
			}
			else
			{
				if( !isNegativeReturn )
				{
					isNegativeReturn = true;
				}
			}
		}
		
		override public function nextLevel():Boolean
		{
			if( isNegativeReturn )
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
			backgroundSprite.alpha = 1.0;
			
//			var foregroundSprite:FlxSprite;
//			foregroundSprite = new FlxSprite(0,0);
//			foregroundSprite.loadGraphic(ImgForeground, true, true, levelSizeX, levelSizeY);	
//			PlayState.groupForeground.add(foregroundSprite);
		}
	}
}
