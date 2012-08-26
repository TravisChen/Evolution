package    {
	
	import org.flixel.*;
	
	public class Evolution_LevelMenu extends Level{
		
		[Embed(source = '../data/intro.png')] private var ImgBackground:Class;
		
		public const TEXT_COLOR:uint = 0xFF33d72ae;
		public const TEXT_COLOR_LIGHT:uint = 0xFF4fa5b8;
		
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

			var header:FlxText = new FlxText(0, 1, FlxG.width, "FOR THE");
			header.setFormat(null,32,TEXT_COLOR,"center");
			header.scrollFactor.x = header.scrollFactor.y = 0;	
			PlayState.groupForeground.add(header);

			var header0:FlxText = new FlxText(0, 40, FlxG.width, "WIN");
			header0.setFormat(null,32,TEXT_COLOR,"center");
			header0.scrollFactor.x = header.scrollFactor.y = 0;	
			PlayState.groupForeground.add(header0);

			var header1:FlxText = new FlxText(-56, 50, FlxG.width, "DAR");
			header1.setFormat(null,16,TEXT_COLOR_LIGHT,"center");
			header1.scrollFactor.x = header.scrollFactor.y = 0;	
			PlayState.groupForeground.add(header1);
			
			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(backgroundSprite);
		}
	}
}
