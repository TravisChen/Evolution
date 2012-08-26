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
		
		public function Enemy(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgPriest,true,true,32,32);
			
			// bounding box tweaks
			width = 16;
			height = 16;
			offset.x = 8;
			offset.y = 16;
			jumping = false;
			digging = false;
			
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

		override public function update():void
		{	
			right = false;
			left = false;
			
			if( !PlayState._currLevel.player )
			{
				return;
			}
			
			if( PlayState._currLevel.player.x >= x )
				right = true;
			else
				left = true;
			
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
				if( Math.abs( PlayState._currLevel.player.x - x ) < 80 )
				{
					drag.x = RUN_SPEED*8;
					play("run");	
				}
				else
				{
					if( velocity.x >= 0 )
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

			//UPDATE POSITION AND ANIMATION
			super.update();
		}
	}
}