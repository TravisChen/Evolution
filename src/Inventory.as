package
{
	import flash.ui.Keyboard;
	
	import org.flixel.*;
	
	public class Inventory extends FlxSprite
	{
		[Embed(source="../data/inventory.png")] private var imgInventory:Class;
		[Embed(source="../data/sequencer.png")] private var imgSequencer:Class;
		[Embed(source="../data/skull1.png")] private var imgSkull:Class;
		
		public const TEXT_COLOR:uint = 0xFF555555;
		
		public var inventoryArray:Array; 
		public var sequencerArray:Array;
		
		public var sevenPressed:Boolean;
		public var eightPressed:Boolean;
		public var ninePressed:Boolean;
		public var fourPressed:Boolean;
		public var fivePressed:Boolean;
		public var sixPressed:Boolean;
		public var onePressed:Boolean;
		public var twoPressed:Boolean;
		public var threePressed:Boolean;
		
		public function Inventory(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(imgInventory, true, true, 74, 74);
		
			inventoryArray = new Array();
			sequencerArray = new Array();
			
			sevenPressed = false;
			
			createItems();
			createSequencer();
		}
		
		public function addItem():void
		{
			for (var i:int = 0; i < inventoryArray.length; i++) {
				if( !inventoryArray[i].hasItem )
				{
					inventoryArray[i].hasItem = true;
					return;
				}
			}
		}
		
		public function addSequencerItem():void
		{
			for (var i:int = 0; i < inventoryArray.length; i++) {
				if( !sequencerArray[i].hasItem )
				{
					sequencerArray[i].hasItem = true;
					return;
				}
			}
		}
		
		public function createSequencer():void
		{
			var sequencer:FlxSprite;
			sequencer = new FlxSprite(0,0);
			sequencer.loadGraphic(imgSequencer, true, true, 74, 24);
			sequencer.scrollFactor.x = sequencer.scrollFactor.y = 0;
			sequencer.y = this.y - 26;
			sequencer.x = this.x;
			PlayState.groupForegroundHigh.add(sequencer);	
			
			for (var i:int = 0; i < 3; i++) {
				var skull:SkullInventoryItem;
				skull = new SkullInventoryItem(0,0);
				skull.scrollFactor.x = skull.scrollFactor.y = 0;
				skull.y = sequencer.y + 4;
				skull.x = sequencer.x + i*22 + 4 + 3*i;
				PlayState.groupForegroundHigh.add(skull);
					
				sequencerArray.push(skull);
			}
		}
		
		public function createItems():void
		{
			var index:int = 0;
			for (var i:int = 0; i < 3; i++) {
				for (var j:int = 0; j < 3; j++) {
					
					var timerText:FlxText = new FlxText(0, 0, 12, "" + ( 7 + j - ( 3 * i ) ));
					timerText.setFormat(null,8,TEXT_COLOR,"center");
					timerText.scrollFactor.x = timerText.scrollFactor.y = 0;
					timerText.y = this.y + i*22 + 5 + 3*i;
					timerText.x = this.x + j*22 + 4 + 3*j;
					PlayState.groupForegroundHigh.add(timerText);
					
					var skull:SkullInventoryItem;
					skull = new SkullInventoryItem(0,0);
					skull.scrollFactor.x = skull.scrollFactor.y = 0;
					skull.y = this.y + i*22 + 4 + 3*i;
					skull.x = this.x + j*22 + 4 + 3*j;
					PlayState.groupForegroundHigh.add(skull);
					
					inventoryArray.push(skull);
					index++;
				}
			}

		}
		
		override public function update():void
		{	
			checkButton( FlxG.keys.NUMPADSEVEN, 0, sevenPressed );
			checkButton( FlxG.keys.NUMPADEIGHT, 1, eightPressed );
			checkButton( FlxG.keys.NUMPADNINE, 2, ninePressed );
			checkButton( FlxG.keys.NUMPADFOUR, 3, fourPressed );
			checkButton( FlxG.keys.NUMPADFIVE, 4, fivePressed );
			checkButton( FlxG.keys.NUMPADSIX, 5, sixPressed );
			checkButton( FlxG.keys.NUMPADONE, 6, onePressed );
			checkButton( FlxG.keys.NUMPADTWO, 7, twoPressed );
			checkButton( FlxG.keys.NUMPADTHREE, 8, threePressed );
			super.update();
		}
		
		public function checkButton( key:Boolean, index:int, bool:Boolean ):void
		{
			if( key )
			{
				if( inventoryArray[index].hasItem && !sevenPressed )
				{
					inventoryArray[index].hasItem = false;
					addSequencerItem();
				}
				sevenPressed = true;
			}
			else
			{
				sevenPressed = false;
			}
		}
	}
}