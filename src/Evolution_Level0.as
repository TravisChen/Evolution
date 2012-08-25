package    {
	
	import org.flixel.*;
	
	public class Evolution_Level0 extends Level{
		
		[Embed(source = '../data/intro.png')] private var ImgBackground:Class;
		
		public function Evolution_Level0( group:FlxGroup ) {
			
			super();
			
			levelSizeX = 178;
			levelSizeY = 120;
			
			createForegroundAndBackground();
		}
		
		override public function nextLevel():Boolean
		{
			if(FlxG.keys.any() )
			{
				return true;
			}
			return false;
		}
		
		public function createForegroundAndBackground():void {
			var backgroundSprite:FlxSprite = new IntroSplash(0,0);
			PlayState.groupBackground.add(backgroundSprite);
		}
	}
}
