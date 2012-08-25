package
{
	import org.flixel.*;
	
	public class ShuttleHall extends FlxSprite
	{
		[Embed(source = '../data/shuttle-hall.png')] private var ImgShuttleHall:Class;
		
		public function ShuttleHall(X:int,Y:int):void
		{
			super(X,Y);
			
			loadGraphic(ImgShuttleHall, true, true, 178, 120);
			
			addAnimation("animate", [1,2,3,2,1], 7);
		}
		
		override public function update():void
		{
			play( "animate" );
			super.update();
		}
	}
}
