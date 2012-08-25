package
{
	import org.flixel.*;
	
	public class ShuttleLights extends FlxSprite
	{
		[Embed(source='../data/cockpit-lights.png')] private var ImgLights:Class;
		
		public var lightsOn:Boolean = false;
		
		public function ShuttleLights(X:int,Y:int):void
		{
			super(X,Y);
			
			loadGraphic(ImgLights, true, true, 68, 32);
			
			addAnimation("idle", [0]);
			addAnimation("lights_on", [1,2,3,1,3,1,2,3,2,1,2,3,1,3,2,], 6);
		}
		
		override public function update():void
		{
			if( !lightsOn )
			{
				play( "idle" );
			}
			else
			{
				play( "lights_on" );
			}
			super.update();
		}
	}
}
