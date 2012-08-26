package
{
	import org.flixel.*;
	
	public class Inventory extends FlxSprite
	{
		[Embed(source="../data/inventory.png")] private var imgInventory:Class;
		[Embed(source="../data/skull1.png")] private var imgSkull:Class;
		
		public const TEXT_COLOR:uint = 0xFF666666;
		
		public var inventoryArray:Array; 
		
		public function Inventory(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(imgInventory, true, true, 74, 74);
			
			createItems();
			
			inventoryArray = new Array();
		}
		
		public function createItems():void
		{
			var index:int = 0;
			for (var i:int = 0; i < 3; i++) {
				for (var j:int = 0; j < 3; j++) {
					
					var timerText:FlxText = new FlxText(0, 0, 12, "" + ( 7 + i - ( 3 * j ) ));
					timerText.setFormat(null,8,TEXT_COLOR,"center");
					timerText.scrollFactor.x = timerText.scrollFactor.y = 0;
					timerText.x = this.x + i*22 + 4 + 3*i;
					timerText.y = this.y + j*22 + 5 + 3*j;
					PlayState.groupForegroundHigh.add(timerText);
					
					var skull:FlxSprite;
					skull = new FlxSprite(0,0);
					skull.loadGraphic(imgSkull, true, true, 16,16);	
					skull.scrollFactor.x = skull.scrollFactor.y = 0;
					skull.x = this.x + i*22 + 4 + 3*i;
					skull.y = this.y + j*22 + 4 + 3*j;
					PlayState.groupForegroundHigh.add(skull);
					
					
					
					index++;
				}
			}

		}
	}
}