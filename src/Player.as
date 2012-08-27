package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source="data/darwin.png")] private var ImgDarwin:Class;
		[Embed(source="data/questionmark.png")] private var ImgQuestionMark:Class;
		
		private var jumpPower:int;
		private var jumping:Boolean;
		public var digging:Boolean;
		public var landing:Boolean;
		public var stunTime:Number;
		public var stunProtectTime:Number;
		public var lastVelocityY:Number;

		public const STUN_TIME:Number = 2.0;
		public const STUN_PROTECT_TIME:Number = 1.0;
		public var questionMark:FlxSprite;
		public var questionMarkBlinkTime:Number;
		
		public function Player(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgDarwin,true,true,32,32);
			
			//bounding box tweaks
			width = 16;
			height = 16;
			offset.x = 8;
			offset.y = 16;
			jumping = false;
			digging = false;
			
			stunTime = 0;
			stunProtectTime = 0;
			questionMarkBlinkTime = 0;
			
			questionMark = new FlxSprite(0,0);
			questionMark.loadGraphic(ImgQuestionMark, true, true, 16, 16);
			questionMark.alpha = 0;
			PlayState.groupForeground.add(questionMark);
			
			lastVelocityY = velocity.y;
			
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
			addAnimation("jump", [8,9,10], 18, false);
			addAnimation("land", [8], 20);
			addAnimation("stun", [11,12], 15);
		}
		
		public function updateStun():Boolean
		{
			if( stunProtectTime > 0 )
			{
				stunProtectTime -= FlxG.elapsed;
				return false;
			}
			
			var enemy:Enemy = PlayState._currLevel.enemy;
			if( enemy && stunTime <= 0 )
			{
				if( enemy.overlaps(this) )
				{
					stunTime = STUN_TIME;
				}
			}
			
			if( stunTime > 0 )
			{
				questionMark.y = y - 34;
				questionMark.x = x;
				
				if( questionMarkBlinkTime <= 0 )
				{
					questionMarkBlinkTime = 0.035;
					if( questionMark.alpha == 0 )
						questionMark.alpha = 1;
					else
						questionMark.alpha = 0;
				}
				else
				{
					questionMarkBlinkTime -= FlxG.elapsed;
				}
				
				play("stun");
				velocity.x = 0;
				acceleration.x = 0;
				stunTime -= FlxG.elapsed;
				
				if( stunTime <= 0 )
				{
					questionMark.alpha = 0;
					stunProtectTime = STUN_PROTECT_TIME;
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
				
			if( landing ) 
			{
				play("land");
				if(finished)
				{
					landing = false;					
				}
				return;
			}
			
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

			if( lastVelocityY != 0 && velocity.y == 0 )
			{
				landing = true;
				lastVelocityY = 0;		
			}
			else
			{
				lastVelocityY = velocity.y;
			}
		}
	}
}