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
		public var skullTimer:Number;
		
		public const START_SKULLS:uint = 6;
		public const MAX_SKULLS:uint = 12;
		public const MAX_TIME:Number = 4.0;
		public const MIN_TIME:Number = 3.0;
		
		public function SkullSpawner( player:Player, tilemap:FlxTilemap, inventory:Inventory )
		{
			super();
			
			_player = player;
			_tilemap = tilemap;
			_inventory = inventory;
			
			skullArray = new Array();
			skullTimer = MAX_TIME;
			
			for (var i:int = 0; i < START_SKULLS; i++) {
				addSkull();
			}
		}
		
		public function addSkull():void
		{
			var x:uint = Math.floor(Math.random() * 540) + 40;
			var y:uint = FlxG.height - 40;
			
			// Too close, try again
			if( isNearby(x) )
			{
				addSkull();
				return;
			}
			
			var skull:Skull = new Skull(x, y, _player, PlayState.groupForeground, _tilemap, _inventory, this, currType);		
			PlayState.groupCollects.add(skull);
			
			skullArray.push(skull);
			
			updateCurrType();
		}
		
		public function removeSkull( skull:Skull ):void
		{
			for (var i:int = 0; i < skullArray.length; i++) {
				if( skull == skullArray[i] )
				{
					skullArray.splice(i,1);
					return;
				}
			}			
		}
		
		public function isNearby( randX:uint ):Boolean 
		{
			for (var i:int = 0; i < skullArray.length; i++) {
				if( Math.abs( skullArray[i].x - randX ) < 32 )
				{
					return true;					
				}
			}			
			return false;
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
			super.update();
			
			if( skullTimer >= 0 )
			{
				skullTimer -= FlxG.elapsed;
			}
			else
			{
				if( skullArray.length < MAX_SKULLS )
				{
					addSkull();
				}
				skullTimer = ( Math.random() * MAX_TIME - MIN_TIME ) + MIN_TIME;
			}
		}
	}
}