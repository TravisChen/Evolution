package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source="data/darwin.png")] private var ImgDarwin:Class;
		[Embed(source="data/questionmark.png")] private var ImgQuestionMark:Class;
		[Embed(source="data/wasd.png")] private var ImgWasd:Class;

		[Embed(source = '../data/Audio/dig.mp3')] private var SndDig:Class;
		[Embed(source = '../data/Audio/jump.mp3')] private var SndJump:Class;
		[Embed(source = '../data/Audio/preach.mp3')] private var SndStun:Class;
		
		public var startTime:Number;
		
		private var jumpPower:int;
		private var jumping:Boolean;
		public var digging:Boolean;
		public var fakeDigging:Boolean;
		public var landing:Boolean;
		public var stunTime:Number;
		public var stunProtectTime:Number;
		public var lastVelocityY:Number;
		public var roundOver:Boolean;

		public const STUN_TIME:Number = 2.0;
		public const STUN_PROTECT_TIME:Number = 1.0;
		
		public var questionMark:FlxSprite;
		public var questionMarkBlinkTime:Number;
		
		public var wasd:FlxSprite;
		public var wasdFadeOutTime:Number;
		public var wasdBounceTime:Number;
		public var wasdBounceToggle:Boolean;
		
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
			roundOver = false;
			
			startTime = 0.5;
			
			stunTime = 0;
			stunProtectTime = 0;
			questionMarkBlinkTime = 0;
			wasdFadeOutTime = 0;
			wasdBounceToggle = true;
			wasdBounceTime = 0;
			
			questionMark = new FlxSprite(0,0);
			questionMark.loadGraphic(ImgQuestionMark, true, true, 16, 16);
			questionMark.alpha = 0;
			PlayState.groupForeground.add(questionMark);
			
			wasd = new FlxSprite(0,0);
			wasd.loadGraphic(ImgWasd, true, true, 32, 32);
			wasd.alpha = 1;
			PlayState.groupForeground.add(wasd);
			
			lastVelocityY = velocity.y;
			
			// Basic player physics
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
		
		public function updateNumPad():void 
		{
			wasd.y = y - 40;
			wasd.x = x - 8;
			
			if( stunTime > 0 )
			{
				wasd.visible = false;
			}
			else
			{
				wasd.visible = true;
			}
			
			if( velocity.x != 0 || velocity.y != 0 )
			{
				wasd.alpha -= 0.025;		
			}
			else
			{
				if( wasdBounceTime <= 0 )
				{
					wasdBounceTime = 0.02;
					if( wasdBounceToggle )
					{
						wasd.y += 1;
						wasdBounceToggle = false;
					}
					else
					{
						wasd.y -= 1;
						wasdBounceToggle = true;
					}
				}
				else
				{
					wasdBounceTime -= FlxG.elapsed;
				}
			}
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
					FlxG.play(SndStun,0.2);
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
			updateNumPad();
			
			if( startTime > 0 )
			{
				startTime -= FlxG.elapsed;
				return;
			}
				
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
			
			if( roundOver )
			{
				play("idle");
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
					FlxG.play(SndJump,1.0);
					
					play("jump");
					velocity.y = -jumpPower;
				}
				jumping = true;
			}
			else
			{
				jumping = false;
			}
			
			if( FlxG.keys.DOWN || FlxG.keys.S )
			{
				if( !fakeDigging )
				{
					FlxG.play(SndDig,0.3);
					fakeDigging = true;
					digging = true;
				}
			}
			else
			{
				fakeDigging = false;				
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