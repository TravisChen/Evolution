package
{
	import org.flixel.*;
	
	public class Inventory extends FlxSprite
	{
		[Embed(source="../data/inventory.png")] private var imgInventory:Class;
		
		public function Inventory(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(imgInventory, true, true, 56, 56);
		}
	}
}