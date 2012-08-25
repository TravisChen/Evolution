package
{
	import org.flixel.*;
	
	public class ShuttleControls extends FlxSprite
	{
		[Embed(source='../data/shuttle-anims.png')] private var ImgShuttleAnims:Class;
		
		public var monitorsOn:Boolean = false;
		
		public function ShuttleControls(X:int,Y:int):void
		{
			super(X,Y);
			
			loadGraphic(ImgShuttleAnims, true, true, 170, 120);
			
			addAnimation("idle", [0]);
			addAnimation("monitors_on", [1,2,3,2,3,1,3,2,3,1,2,3,2,1], 6);
		}
		
		override public function update():void
		{
			if( !monitorsOn )
			{
				play( "idle" );
			}
			else
			{
				play( "monitors_on" );
			}
			super.update();
		}
	}
}
