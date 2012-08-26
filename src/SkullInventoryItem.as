package
{
	import org.flixel.*;
	
	public class SkullInventoryItem extends FlxSprite
	{
		[Embed(source='../data/skull1.png')] private var ImgSkull1:Class;
		[Embed(source='../data/skull2.png')] private var ImgSkull2:Class;
		[Embed(source='../data/skull3.png')] private var ImgSkull3:Class;
		[Embed(source='../data/skull4.png')] private var ImgSkull4:Class;
		[Embed(source='../data/skull5.png')] private var ImgSkull5:Class;
		[Embed(source='../data/skull6.png')] private var ImgSkull6:Class;
		[Embed(source="../data/skull1.png")] private var imgSkull:Class;
		
		public var hasItem:Boolean;
		public var skullType:uint;
		
		public function SkullInventoryItem(X:int,Y:int)
		{
			super(X,Y);
			hasItem = false;
			
			skullType = 0;
			
			loadGraphic(imgSkull, true, true, 16, 16);
		}
		
		public function setItem( type:uint ):void
		{
			skullType = type;
			hasItem = true;
			
			switch (skullType){
				case 0:
					loadGraphic(ImgSkull1, true, true, 16, 16);
					break;
				case 1:
					loadGraphic(ImgSkull2, true, true, 16, 16);
					break;
				case 2:
					loadGraphic(ImgSkull3, true, true, 16, 16);
					break;
				case 3:
					loadGraphic(ImgSkull4, true, true, 16, 16);
					break;
				case 4:
					loadGraphic(ImgSkull5, true, true, 16, 16);
					break;
				case 5:
					loadGraphic(ImgSkull6, true, true, 16, 16);
					break;
			}
		}
		
		public function clearItem():void
		{
			hasItem = false;			
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