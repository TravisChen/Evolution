package
{
	import org.flixel.*;
	
	public class ShuttleNoseCone extends FlxSprite
	{
		[Embed(source='../data/shuttle-nose-cone.png')] private var ImgShuttleNoseCone:Class;
		
		public var noseConeOn:Boolean = false;
		public var goalAngle:int = -90;
		
		public function ShuttleNoseCone(X:int,Y:int):void
		{
			super(X,Y);
			
			loadGraphic(ImgShuttleNoseCone, true, true, 120, 56);
			
			this.origin = new FlxPoint( 0, 0 );
			
		}
		
		override public function update():void
		{
			if( noseConeOn )
			{
				if( this.angle > goalAngle )
				{
					this.angle = this.angle - 0.5;
				}
			}
		}
	}
}
