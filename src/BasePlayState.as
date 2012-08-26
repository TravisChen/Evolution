package
{
	import flash.display.*;
	
	import org.flixel.*;
	
	public class BasePlayState extends FlxState
	{
		public static var levelArray:Array = [
			Evolution_LevelMenu,
			Evolution_LevelMain
		]
		
		public function BasePlayState():void
		{
		}
	}
}
