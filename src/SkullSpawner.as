package
{
	import org.flixel.*;
	
	public class SkullSpawner extends FlxObject
	{
		private var _player:Player;
		private var _tilemap:FlxTilemap;
		private var _inventory:Inventory;
		
		public var skullArray:Array;
		public var currType:uint;
		
		public const START_SKULLS:uint = 10;
		public const MAX_SKULLS:uint = 20;
		
		public function SkullSpawner( player:Player, tilemap:FlxTilemap, inventory:Inventory )
		{
			_player = player;
			_tilemap = tilemap;
			_inventory = inventory;
			
			skullArray = new Array(MAX_SKULLS);
			
			for (var i:int = 0; i < START_SKULLS; i++) {
				addSkull();
			}
		}
		
		public function addSkull():void
		{
			var x:uint = Math.floor(Math.random() * 540) + 40;
			var y:uint = FlxG.height - 40;
			
			var skull:Skull = new Skull(x, y, _player, PlayState.groupForeground, _tilemap, _inventory, currType);		
			PlayState.groupCollects.add(skull);
			
			updateCurrType();
		}
		
		public function updateCurrType():void 
		{
			currType++;
			if( currType > 5 )
			{
				currType = 0;				
			}
		}
		
		override public function update():void
		{
		}
	}
}