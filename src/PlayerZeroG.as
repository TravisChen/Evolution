package
{
	import org.flixel.*;
	
	public class PlayerZeroG extends FlxSprite
	{
		[Embed(source="data/pilot-zerog-anims.png")] private var ImgPilot:Class;
		public var baseScale:Number = 4.0;
		public var currSpeed:Number = 30;
		public var baseSpeed:Number = 30;
		public var startY:Number = 0;
		
		public function PlayerZeroG(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgPilot,true,true,32,32);
			
			Helpers.scale(this,baseScale);
			
			//basic player physics
			drag.y = baseSpeed*8;
			maxVelocity.y = baseSpeed;
			startY = Y;
			
			addAnimation("idle", [0]);
			addAnimation("walk", [0,1,2], 6);
		}
		
		override public function update():void
		{
			if( y < 80 )
			{
				scale.x = baseScale - ( startY - y )/24;
				scale.y = baseScale - ( startY - y )/24;
				currSpeed = baseSpeed - ( startY - y )/2.8;
				
				drag.y = currSpeed*8;
				maxVelocity.y = currSpeed;
			}
			
			//MOVEMENT
			acceleration.y = 0;
			if(FlxG.keys.UP)
			{
				acceleration.y -= drag.y;
			}
			else if(FlxG.keys.DOWN)
			{
				acceleration.y += drag.y;
			}
			
			//BOUNDARY
			if( y <= 0 - this.height/2)
			{
				velocity.y = 0;
				y = 0 - this.height/2;
			}
			
			if( y >= PlayState._currLevel.levelSizeY)
			{
				velocity.y = 0;
				y = PlayState._currLevel.levelSizeY;				
			}
			
			//ANIMATION
			if(velocity.y == 0)
			{
				play("idle");
			}
			else
			{
				play("walk");
			}
			
			//UPDATE POSITION AND ANIMATION
			super.update();
		}
	}
}