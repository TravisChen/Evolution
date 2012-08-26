package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source="data/darwin.png")] private var ImgDarwn:Class;
		private var jumpPower:int;
		private var jumping:Boolean;
		public var digging:Boolean;

		public function Player(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgDarwn,true,true,32,32);
			
			//bounding box tweaks
			width = 16;
			height = 16;
			offset.x = 8;
			offset.y = 16;
			jumping = false;
			digging = false;
			
			//basic player physics
			var runSpeed:uint = 140;
			drag.x = runSpeed*8;
			acceleration.y = 420;
			jumpPower = 180;
			maxVelocity.x = runSpeed;
			maxVelocity.y = jumpPower;
				
			addAnimation("idle", [0]);
			addAnimation("run", [1,2,3,4], 18);
			addAnimation("dig", [5,6,7], 32);
			addAnimation("jump", [8,9,10], 18 ,false);
		}

		override public function update():void
		{
			if( digging ) 
			{
				play("dig");
				if(finished)
				{
					digging = false;					
				}
				return;
			}
			
			//MOVEMENT
			acceleration.x = 0;
			if(FlxG.keys.LEFT || FlxG.keys.A)
			{
				facing = LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT || FlxG.keys.D)
			{
				facing = RIGHT;
				acceleration.x += drag.x;
			}
			
			if( FlxG.keys.UP || FlxG.keys.W)
			{
				if( !velocity.y && !jumping )
				{
					play("jump");
					velocity.y = -jumpPower;
				}
				jumping = true;
			}
			else
			{
				jumping = false;
			}

			if( !velocity.y )
			{
				if(velocity.x == 0)
				{
					play("idle");
				}
				else
				{
					play("run");
				}
			}
			
			//UPDATE POSITION AND ANIMATION
			super.update();
		}
	}
}