package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source="data/darwin.png")] private var ImgDarwn:Class;
		private var jumpPower:int;
		private var jumping:Boolean;

		public function Player(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgDarwn,true,true,32,32);
			
			//bounding box tweaks
			width = 16;
			height = 32;
			offset.x = 8;
			jumping = false;
			
			//basic player physics
			var runSpeed:uint = 80;
			drag.x = runSpeed*8;
			acceleration.y = 420;
			jumpPower = 200;
			maxVelocity.x = runSpeed;
			maxVelocity.y = jumpPower;
				
			addAnimation("idle", [0]);
		}

		override public function update():void
		{
			//MOVEMENT
			acceleration.x = 0;
			if(FlxG.keys.LEFT)
			{
				facing = LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				acceleration.x += drag.x;
			}
			
			if( FlxG.keys.UP )
			{
				if( !velocity.y && !jumping )
					velocity.y = -jumpPower;
				jumping = true;
			}
			else
			{
				jumping = false;
			}
			
			//ANIMATION
			if(velocity.x == 0)
			{
				play("idle");
			}

			//UPDATE POSITION AND ANIMATION
			super.update();
		}
	}
}