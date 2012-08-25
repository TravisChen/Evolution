package
{
	import flash.display.*;
	
	import org.flixel.*;
	
	public class BasePlayState extends FlxState
	{
		public static var levelArray:Array = [
			TinyWorld_Level0,
			TinyWorld_Level1,
			TinyWorld_Level2,
			TinyWorld_Level3,
			TinyWorld_Level4,
			TinyWorld_Level5
		]
		
		public function BasePlayState():void
		{
		}
	}
}
