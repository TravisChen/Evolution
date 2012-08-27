package
{
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{
		[Embed(source="data/priest.png")] private var ImgPriest:Class;
		private var jumpPower:int;
		private var jumping:Boolean;
		public var digging:Boolean;
		public var left:Boolean;
		public var right:Boolean;

		public const WALK_SPEED:Number = 40;
		public const RUN_SPEED:Number = 72;
		
		public var stunTime:Number;
		public const STUN_TIME:Number = 0.75;
		public var walkAwayTime:Number;
		public const WALK_AWAY_TIME:Number = 2.0;
		
		public function Enemy(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgPriest,true,true,32,32);
			
			// bounding box tweaks
			width = 44;
			height = 16;
			offset.x = 0;
			offset.y = 16;
			jumping = false;
			digging = false;
			
			stunTime = 0.0;
			walkAwayTime = 0.0;
			
			// enemy physics
			var speed:uint = WALK_SPEED;
			drag.x = speed*8;
			acceleration.y = 420;
			jumpPower = 180;
			maxVelocity.x = RUN_SPEED;
			maxVelocity.y = jumpPower;
				
			addAnimation("idle", [0]);
			addAnimation("walk", [0,1,2], 10);
			addAnimation("run", [3,4], 10);
		}
		
		public function updateStun():Boolean
		{
			var player:Player = PlayState._currLevel.player;
			if( player && walkAwayTime <= 0 && stunTime <= 0 )
			{
				if( player.overlaps(this) )
				{
					stunTime = STUN_TIME;
				}
			}
			
			if( stunTime > 0 )
			{
				velocity.x = 0;
				acceleration.x = 0;
				stunTime -= FlxG.elapsed;
				if( stunTime <= 0 )
				{
					walkAwayTime = WALK_AWAY_TIME;
				}
				return true;				
			}
			
			return false;			
		}

		override public function update():void
		{	
			//UPDATE POSITION AND ANIMATION
			super.update();
			
			if( updateStun() )
			{
				return;
			}
			
			right = false;
			left = false;
			
			if( !PlayState._currLevel.player )
			{
				return;
			}
			
			if( walkAwayTime <= 0 )
			{
				if( PlayState._currLevel.player.x >= x )
					right = true;
				else
					left = true;
			}
			else
			{
				walkAwayTime -= FlxG.elapsed;
				
				if( PlayState._currLevel.player.x >= x )
					left = true;
				else
					right = true;
			}
			
			//MOVEMENT
			acceleration.x = 0;
			if(left)
			{
				facing = RIGHT;
				acceleration.x -= drag.x;
			}
			else if(right)
			{
				facing = LEFT;
				acceleration.x += drag.x;
			}
			
			//ANIMATION
			if(velocity.x == 0)
			{
				play("idle");
			}
			else
			{
				if( Math.abs( PlayState._currLevel.player.x - x ) < 100 && walkAwayTime <= 0 )
				{
					drag.x = RUN_SPEED*8;
					play("run");	
				}
				else
				{
					if( right )
					{
						velocity.x = WALK_SPEED;
					}
					else
					{
						velocity.x = -WALK_SPEED;
					}
					drag.x = WALK_SPEED*8;
					play("walk");
				}
			}
		}
	}
}