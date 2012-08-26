package
{
	import org.flixel.*;
	
	public class SkullInventoryItem extends FlxSprite
	{
		[Embed(source="../data/skull1.png")] private var imgSkull:Class;
		
		public var hasItem:Boolean;
		
		public function SkullInventoryItem(X:int,Y:int)
		{
			super(X,Y);
			hasItem = false;
			loadGraphic(imgSkull, true, true, 16, 16);
		}
		
		override public function update():void
		{
			super.update();
			
			if( hasItem )
				this.visible = true;
			else
				this.visible = false;
		}
	}
}