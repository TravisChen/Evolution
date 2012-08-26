package
{
	import org.flixel.*;
	
	public class Skull extends FlxSprite
	{
		[Embed(source='../data/skull.png')] private var ImgCollect:Class;
		[Embed(source="../data/particles.png")] private var ImgParticle:Class;
		
		private var _player:Player;
		
		private var _particle:FlxEmitter;
		private var _tilemap:FlxTilemap;
		public const EXPLOSION_SPEED:Number = 45;
		public const NUM_PARTICLES:Number = 64;
		public var collected:Boolean;
		
		public var digging:Boolean;
		public var numDigs:uint;
		public var downTimer:Number;
		
		public const DOWN_TIME:Number = 0.5;
		public const DIGS_TO_COLLECT:uint = 8;
		
		public function Skull( X:Number,Y:Number, player:Player, groupCollect:FlxGroup, tilemap:FlxTilemap ):void
		{
			super(X,Y);
			
			_player = player;
			_tilemap = tilemap;
			collected = false;
			digging = false;
			numDigs = 0;
			downTimer = DOWN_TIME;
			
			width = 12;
			height = 32;
			offset.y = -16;
			
			loadGraphic(ImgCollect, true, true, 12, 15);
			
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
		}
		
		
		override public function update():void
		{		
			// Collide
			FlxG.collide(_tilemap,_particle);
			_particle.update();
			
			downTimer -=  FlxG.elapsed;
			
			if( downTimer <= 0 && numDigs > 0 )
			{
				downTimer = DOWN_TIME; 
				numDigs --;
				y += 2;	
			}
				
			if(!collected)
			{
				play("on");
				if( _player.overlaps( this ) )
				{
					if( FlxG.keys.DOWN )
					{
						if( !digging )
						{
							dig();
							y -= 2;
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
					collected = true;
					visible = false;
				}
			}
			super.update();
		}
	}
}