package
{
	import org.flixel.*;
	
	public class Shuttle extends FlxSprite
	{
		[Embed(source="data/shuttle.png")] private var ImgPilot:Class;
		public var isSittingDown:Boolean = false;
		private var sitDownAnim:Boolean = false;
		
		public function Shuttle(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgPilot,true,true,16,32);
			
			//basic player physics
			var runSpeed:uint = 12;
			drag.x = runSpeed*12;
			maxVelocity.x = runSpeed;
			maxVelocity.y = 12;
//			
//			scale.x = 0.4;
//			scale.y = 0.4;
			
			addAnimation("idle", [0]);
			addAnimation("walk", [1,2,3,4], 6);
			addAnimation("sit_down", [5,6,7,8], 5, false);
			addAnimation("sit_down_idle", [8]);
		}
		
		public function updateSitDown():void
		{
			velocity.x = 0;
			acceleration.x = 0;
			if( !sitDownAnim )
			{
				play("sit_down");
				sitDownAnim = true;
			}
		}
		
		override public function update():void
		{
			// SIT DOWN UPDATE
			if( isSittingDown )
			{
				updateSitDown();
				
				//UPDATE POSITION AND ANIMATION
				super.update();
				
				return;
			}
			
			//MOVEMENT
			acceleration.x = 0;
			acceleration.y = -3.5;
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
			
			//BOUNDARY
			if( x <= 0 - this.width/2)
			{
				velocity.x = 0;
				x = 0 - this.width/2;
			}
			
			if( x >= PlayState._currLevel.levelSizeX)
			{
				velocity.x = 0;
				x = PlayState._currLevel.levelSizeX;				
			}
			
			//ANIMATION
			if(velocity.x == 0)
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