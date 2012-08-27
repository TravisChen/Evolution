package
{
	import org.flixel.*;
	
	public class Skull extends FlxSprite
	{
		[Embed(source='../data/skull1.png')] private var ImgSkull1:Class;
		[Embed(source='../data/skull2.png')] private var ImgSkull2:Class;
		[Embed(source='../data/skull3.png')] private var ImgSkull3:Class;
		[Embed(source='../data/skull4.png')] private var ImgSkull4:Class;
		[Embed(source='../data/skull5.png')] private var ImgSkull5:Class;
		[Embed(source='../data/skull6.png')] private var ImgSkull6:Class;
		[Embed(source="../data/particles.png")] private var ImgParticle:Class;
		
		private var _player:Player;
		private var _particle:FlxEmitter;
		private var _tilemap:FlxTilemap;
		private var _inventory:Inventory;
		private var _skullSpawner:SkullSpawner;
		public var skullType:uint;
		
		public const EXPLOSION_SPEED:Number = 45;
		public const NUM_PARTICLES:Number = 64;
		public var collected:Boolean;
		public var collectedTime:Number;
		public var collectedHoldTime:Number;

		public var digging:Boolean;
		public var numDigs:uint;
		public var downTimer:Number;
		
		public const DOWN_TIME:Number = 0.5;
		public const DIGS_TO_COLLECT:uint = 4;
		public const DIG_Y:uint = 4;
		public const COLLECTED_TIME:Number = 0.75;
		
		public function Skull( X:Number,Y:Number, player:Player, groupCollect:FlxGroup, tilemap:FlxTilemap, inventory:Inventory, skullSpawner:SkullSpawner, type:uint ):void
		{
			super(X,Y);
			
			_player = player;
			_tilemap = tilemap;
			_inventory = inventory;
			_skullSpawner = skullSpawner;
			skullType = type;
				
			digging = false;
			numDigs = 0;
			downTimer = DOWN_TIME;
			
			collected = false;
			collectedTime = COLLECTED_TIME;
			collectedHoldTime = 0.25;
			
			width = 12;
			height = 32;
			offset.y = -16;
			
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

			alpha = 0.5;
			
			// Add gibs
			_particle = new FlxEmitter(0,0,-1);
			_particle.makeParticles(ImgParticle,80,16,true,1.0);
			groupCollect.add(_particle);
			
		}
		
		public function dig():void
		{
			_particle.x = x + 6;
			_particle.y = y + 14 + numDigs*2;
			
			_particle.gravity = 350;
			_particle.setXSpeed(-30, 30);
			_particle.setYSpeed(-50, -80);

			_particle.on = true;
			_player.digging = true;
		}
		
		
		override public function update():void
		{
			// Collide
			FlxG.collide(_tilemap,_particle);
			_particle.update();

			if( collected )
			{
				if( y > FlxG.height - 90 )
				{
					y -= 5.0;
				}
				else
				{
					collectedHoldTime -= FlxG.elapsed;
					if( collectedHoldTime <= 0 )
					{
						alpha -= 0.05;
					}
				}
				collectedTime -= FlxG.elapsed;
				if( collectedTime <= 0 )
				{
					// Collect item, kill
					_particle.kill();
					kill();
				}
				
				return;
			}
			
			// Initial rise			
			if( y > FlxG.height - 40 )
			{
				y -= 0.5;	
			}			
			downTimer -=  FlxG.elapsed;
			
			// Rise
			if( downTimer <= 0 && numDigs > 0 )
			{
				downTimer = DOWN_TIME; 
				numDigs --;
				y += DIG_Y;	
			}

			// Dig
			if( _player.overlaps( this ) && _player.stunTime <= 0 )
			{
				if( FlxG.keys.DOWN ||  FlxG.keys.S )
				{
					if( !digging )
					{
						dig();
						y -= DIG_Y;
						downTimer = DOWN_TIME; 
						numDigs++;
					}
					digging = true;
				}
				else
				{
					digging = false;
				}
				
				alpha = 1.0;
			}
			else
			{
				alpha = 0.5;
			}
			
			if( numDigs >= DIGS_TO_COLLECT )
			{
				_inventory.addItem( skullType );
				_skullSpawner.removeSkull( this );
				collected = true;
			}
			
			super.update();
		}
	}
}