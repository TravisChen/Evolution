package
{
	import flash.ui.Keyboard;
	
	import org.flixel.*;
	
	public class Inventory extends FlxSprite
	{
		[Embed(source="../data/inventory.png")] private var imgInventory:Class;
		[Embed(source="../data/sequencer.png")] private var imgSequencer:Class;
		[Embed(source="../data/sequenceron.png")] private var imgSequencerFlash:Class;
		[Embed(source="../data/skull1.png")] private var imgSkull:Class;
		
		[Embed(source = '../data/Audio/sequencegood.mp3')] private var SndSequenceGood:Class;
		[Embed(source = '../data/Audio/sequencebadalt.mp3')] private var SndSequenceBad:Class;
		
		[Embed(source="../data/1.png")] private var img1:Class;
		[Embed(source="../data/2.png")] private var img2:Class;
		[Embed(source="../data/3.png")] private var img3:Class;
		[Embed(source="../data/4.png")] private var img4:Class;
		[Embed(source="../data/5.png")] private var img5:Class;
		[Embed(source="../data/6.png")] private var img6:Class;
		[Embed(source="../data/7.png")] private var img7:Class;
		[Embed(source="../data/8.png")] private var img8:Class;
		[Embed(source="../data/9.png")] private var img9:Class;
		
		public const TEXT_COLOR:uint = 0xFF555555;
		
		private var _hudTilemap:FlxTilemap;
		
		public var inventoryArray:Array; 
		public var sequencerArray:Array;
		public var numberArray:Array;
		
		public var sevenPressed:Boolean;
		public var eightPressed:Boolean;
		public var ninePressed:Boolean;
		public var fourPressed:Boolean;
		public var fivePressed:Boolean;
		public var sixPressed:Boolean;
		public var onePressed:Boolean;
		public var twoPressed:Boolean;
		public var threePressed:Boolean;
		
		public var sequencerFlash:FlxSprite;
		public var sequencerFlashTimer:Number;
		public var sequencerFlashToggle:Number;
		
		public var inventoryDisabledTime:Number;
		
		public function Inventory(X:int,Y:int,hudTilemap:FlxTilemap)
		{
			_hudTilemap = hudTilemap;
			
			super(X,Y);
			loadGraphic(imgInventory, true, true, 74, 79);
		
			inventoryArray = new Array();
			sequencerArray = new Array();
			numberArray = new Array();
			
			sequencerFlashTimer = 0.0;
			sequencerFlashToggle = 0.0;
			
			sevenPressed = false;
			inventoryDisabledTime = 0.0;
			
			createItems();
			createSequencer();
		}
		
		public function addItem( type:uint ):void
		{
			var inventoryFull:Boolean = true;
			for (var i:int = 0; i < inventoryArray.length; i++) {
				if( !inventoryArray[i].hasItem )
				{
					inventoryFull = false;
					inventoryArray[i].setItem( type );
					numberArray[i].visible = false;
					break;
				}
			}
			
			if( inventoryFull )
			{
				var typeSave:uint = type;
				for (var j:int = 0; j < inventoryArray.length; j++) 
				{
					typeSave = inventoryArray[j].skullType;
					inventoryArray[j].setItem( type );
					type = typeSave;
				}
			}
			
			
			PlayState._currLevel.points += (50 * PlayState._currLevel.multiplier);
		}
		
		public function addSequencerItem( type:uint ):void
		{
			for (var i:int = 0; i < sequencerArray.length; i++) {
				if( !sequencerArray[i].hasItem )
				{
					sequencerArray[i].setItem( type );
					if( i == 2 )
					{
						sequenceComplete();	
					}
					break;
				}
			}
		}
		
		public function sequenceComplete():void
		{
			var goodSequence:Boolean = true;
			if( sequencerArray[0].skullType != 0 && sequencerArray[0].skullType != 3 )
			{
				goodSequence = false;								
			}
			
			if( sequencerArray[0].skullType + 1 != sequencerArray[1].skullType )
			{
				goodSequence = false;
			}
			
			if( sequencerArray[1].skullType + 1 != sequencerArray[2].skullType )
			{
				goodSequence = false;
			}
			
			if( goodSequence )
			{
				PlayState._currLevel.multiplier += 1;
				PlayState._currLevel.points += (1000 * PlayState._currLevel.multiplier);
				sequencerFlashTimer = 1.0;
				FlxG.play(SndSequenceGood, 0.2);
			}
			else
			{
				PlayState._currLevel.multiplier = 1;
				FlxG.play(SndSequenceBad, 0.7);
			}
			
			for (var i:int = 0; i < sequencerArray.length; i++) {
				sequencerArray[i].sequencerClearItem( goodSequence );	
			}
			
			inventoryDisabledTime = 0.5
		}
		
		public function createSequencer():void
		{
			var sequencer:FlxSprite;
			sequencer = new FlxSprite(0,0);
			sequencer.loadGraphic(imgSequencer, true, true, 100, 48);
			sequencer.scrollFactor.x = sequencer.scrollFactor.y = 0;
			sequencer.y = this.y - 47;
			sequencer.x = this.x - 22;
			PlayState.groupForegroundHigh.add(sequencer);
			
			sequencerFlash = new FlxSprite(0,0);
			sequencerFlash.loadGraphic(imgSequencerFlash, true, true, 100, 48);
			sequencerFlash.scrollFactor.x = sequencerFlash.scrollFactor.y = 0;
			sequencerFlash.y = this.y - 47;
			sequencerFlash.x = this.x - 22;
			sequencerFlash.visible = false;
			PlayState.groupForegroundHigh.add(sequencerFlash);
			
			for (var i:int = 0; i < 3; i++) {
				var skull:SkullInventoryItem;
				skull = new SkullInventoryItem(0,0,true,_hudTilemap);
				skull.scrollFactor.x = skull.scrollFactor.y = 0;
				skull.y = sequencer.y + 16;
				skull.x = sequencer.x + i*22 + 17 + 3*i;
				PlayState.groupForegroundHigh.add(skull);
					
				sequencerArray.push(skull);
			}
		}
		
		public function createItems():void
		{
			var index:int = 0;
			for (var i:int = 0; i < 3; i++) {
				for (var j:int = 0; j < 3; j++) {
					
					var number:FlxSprite;
					number = new FlxSprite(0,0);
					number.loadGraphic( getNumberImage( 6 + j - ( 3 * i ) ), true, true, 11, 11);
					number.scrollFactor.x = number.scrollFactor.y = 0;
					number.y = this.y + i*22 + 12 + 3*i;
					number.x = this.x + j*22 + 7 + 3*j;
					number.alpha = 0.75;
					numberArray.push( number );
					PlayState.groupForegroundHigh.add(number);
					
					var skull:SkullInventoryItem;
					skull = new SkullInventoryItem(0,0,false,_hudTilemap);
					skull.scrollFactor.x = skull.scrollFactor.y = 0;
					skull.y = this.y + i*22 + 9 + 3*i;
					skull.x = this.x + j*22 + 4 + 3*j;
					PlayState.groupForegroundHigh.add(skull);
					
					inventoryArray.push(skull);
					index++;
				}
			}

		}
		
		public function getNumberImage( index:uint ):Class 
		{
			var numberImage:Class = img1;
			
			switch (index){
				case 0:
					numberImage = img1;
					break;				
				case 1:
					numberImage = img2;
					break;
				case 2:
					numberImage = img3;
					break;
				case 3:
					numberImage = img4;
					break;
				case 4:
					numberImage = img5;
					break;
				case 5:
					numberImage = img6;
					break;
				case 6:
					numberImage = img7;
					break;
				case 7:
					numberImage = img8;
					break;
				case 8:
					numberImage = img9;
					break;
			}
			return numberImage;
		}
		
		override public function update():void
		{	
			if( sequencerFlashTimer > 0 )
			{
				sequencerFlashTimer -= FlxG.elapsed;
				if( sequencerFlashToggle <= 0 )
				{
					if( sequencerFlash.visible )
						sequencerFlash.visible = false;
					else
						sequencerFlash.visible = true;
					
					sequencerFlashToggle = 0.035;
				}
				else
				{
					sequencerFlashToggle -= FlxG.elapsed;
				}
			}
			else
			{
				sequencerFlashToggle = 0;
				sequencerFlash.visible = false;
			}
						
			if( inventoryDisabledTime > 0 )
			{
				inventoryDisabledTime -= FlxG.elapsed;
				return;
			}
			
			checkButton( FlxG.keys.NUMPADSEVEN, FlxG.keys.SEVEN, 0, sevenPressed );
			checkButton( FlxG.keys.NUMPADEIGHT, FlxG.keys.EIGHT, 1, eightPressed );
			checkButton( FlxG.keys.NUMPADNINE, FlxG.keys.NINE, 2, ninePressed );
			checkButton( FlxG.keys.NUMPADFOUR, FlxG.keys.FOUR, 3, fourPressed );
			checkButton( FlxG.keys.NUMPADFIVE, FlxG.keys.FIVE, 4, fivePressed );
			checkButton( FlxG.keys.NUMPADSIX, FlxG.keys.SIX, 5, sixPressed );
			checkButton( FlxG.keys.NUMPADONE, FlxG.keys.ONE, 6, onePressed );
			checkButton( FlxG.keys.NUMPADTWO, FlxG.keys.TWO, 7, twoPressed );
			checkButton( FlxG.keys.NUMPADTHREE, FlxG.keys.THREE, 8, threePressed );
			super.update();
		}
		
		public function checkButton( key:Boolean, altKey:Boolean, index:int, bool:Boolean ):void
		{
			if( key || altKey )
			{
				if( inventoryArray[index].hasItem && !sevenPressed )
				{
					numberArray[index].visible = true;
					inventoryArray[index].clearItem();
					addSequencerItem( inventoryArray[index].skullType );
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