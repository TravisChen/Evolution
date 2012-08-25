package
{
	import org.flixel.*;
	
	public class CockpitBaseControl extends FlxSprite
	{
		public var controlOn:Boolean = true;
		public var controlActive:Boolean = false;
		
		public function CockpitBaseControl(X:int,Y:int)
		{
			super(X,Y);
		}

		override public function update():void
		{
			super.update();
			if( !controlActive )
			{
				play( "inactive" );	
			}
			else
			{
				if( controlOn )
				{
					play("normal");
					var point:FlxPoint = new FlxPoint(FlxG.mouse.x,FlxG.mouse.y);
					if (this.overlapsPoint(point) && FlxG.mouse.justPressed())
					{
						play( "animate" );
						controlOn = false;
					}
				}
			}
		}
	}
}