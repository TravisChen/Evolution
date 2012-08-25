package
{
	import org.flixel.*; 
	[SWF(width="890", height="600", backgroundColor="#000000")] 
	
	public class Evolution extends FlxGame
	{
		public static var currLevelIndex:uint = 0;
		
		public function Evolution()
		{
			super(178,120,PlayState,5);
		}
	}
}