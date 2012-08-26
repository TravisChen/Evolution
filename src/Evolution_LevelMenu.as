package    {
	
	import org.flixel.*;
	
	public class Evolution_LevelMenu extends Level{
		
		[Embed(source = '../data/intro.png')] private var ImgBackground:Class;
		
		public function Evolution_LevelMenu( group:FlxGroup ) {
			
			super();
			
			levelSizeX = 320;
			levelSizeY = 128;
			
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

			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(backgroundSprite);
		}
	}
}
