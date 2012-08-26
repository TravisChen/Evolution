package
{
	import org.flixel.*; 
	[SWF(width="1280", height="512", backgroundColor="#000000")] 
	
	public class Evolution extends FlxGame
	{
		public static var currLevelIndex:uint = 0;
		
		public function Evolution()
		{
			super(320,128,PlayState,4);
		}
	}
}