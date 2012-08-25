package
{
	import org.flixel.*;
	
	public class IntroSplash extends FlxSprite
	{
		[Embed(source='../data/intro.png')] private var ImgIntro:Class;
		
		public var monitorsOn:Boolean = false;
		
		public function IntroSplash(X:int,Y:int):void
		{
			super(X,Y);
			
			loadGraphic(ImgIntro, true, true, 178, 120);

			addAnimation("animate", [0,1], 6);
		}
		
		override public function update():void
		{
			play( "animate" );
			super.update();
		}
	}
}
