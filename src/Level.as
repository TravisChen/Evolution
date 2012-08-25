package    {
	
	import org.flixel.*;
	
	public class Level {
		
		public var player:Player;

		public var levelSizeX:Number = 0;
		public var levelSizeY:Number = 0;
		public var endX:Number = 0;
		
		public function update():void
		{
			
		}
		
		public function nextLevel():Boolean
		{
			if( player.x >= endX )
			{
				return true;
			}
			return false;
		}
		
		public function destroy():void
		{
			
		}
	}
	
}
