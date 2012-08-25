package    {
	
	import org.flixel.*;
	
	public class TinyWorld_Level2 extends Level{
		
		[Embed(source = '../data/shuttle-cockpit-back.png')] private var ImgBackground:Class;
		[Embed(source = '../data/shuttle-cockpit-fore.png')] private var ImgForeground:Class;
		[Embed(source = '../data/shuttle-cockpit-sky.png')] private var ImgSky:Class;
		
		[Embed(source= '../data/Audio/otc.mp3')] public var OtcRadio:Class;
		[Embed(source= '../data/Audio/tbc.mp3')] public var TbcRadio:Class;
		[Embed(source= '../data/Audio/ttc.mp3')] public var TtcRadio:Class;
		[Embed(source= '../data/Audio/lts.mp3')] public var LtsRadio:Class;
		[Embed(source= '../data/Audio/hf.mp3')] public var HfRadio:Class;
		[Embed(source= '../data/Audio/discovery.mp3')] public var DiscoveryRadio:Class;
		[Embed(source= '../data/Audio/sro.mp3')] public var SroRadio:Class;
		[Embed(source= '../data/Audio/launchteam.mp3')] public var LaunchteamRadio:Class;
		[Embed(source= '../data/Audio/enginenoise0.mp3')] public var EngineNoise0:Class;
		[Embed(source= '../data/Audio/hum.mp3')] public var Hum:Class;
		[Embed(source= '../data/Audio/liftoff.mp3')] public var LiftOff:Class;
		
		public var shuttleControls:ShuttleControls;
		public var shuttleLights:ShuttleLights;
		public var shuttleNoseCone:ShuttleNoseCone;
		
		public var addCursor:Boolean = true;
		public var cursor:AnimatedCursor;
		public var button0:CockpitButton;
		public var button1:CockpitButton;
		public var button2:CockpitButton;
		public var button3:CockpitButton;
		public var button4:CockpitButton;
		
		public var switch0:CockpitSwitch;
		public var switch1:CockpitSwitch;
		public var switch2:CockpitSwitch;
		
		public var controlArray:Array;
		public var soundArray:Array;
		public var waitArray:Array;
		public var functionArray:Array;
		public var currControlIndex:uint = 0;
		public var radioPlayed:Boolean = false;
		
		public var liftOffWait:Number = 6.0;
		public var isLiftOff:Boolean = false;

		public var liftOff1Wait:Number = 4.0;
		public var isLiftOff1:Boolean = false;

		public var liftOff2Wait:Number = 5.0;
		public var isLiftOff2:Boolean = false;

		public var liftOff3Wait:Number = 5.0;
		public var isLiftOff3:Boolean = false;
		
		public var sound:FlxSound;
		public var soundEngineNoise:FlxSound;
		
		public var skySprite:FlxSprite;
		
		public function TinyWorld_Level2( group:FlxGroup ) {
			super();
			
			sound = new FlxSound();
			soundEngineNoise = new FlxSound();
			sound.loadEmbedded(OtcRadio, false, true);
			sound.play();
			
			playHum();
			
			levelSizeX = 178;
			levelSizeY = 120;
			endX = 260;
			
			// Create player
			player = new Player(-64,20);
			PlayState.groupPlayer.add(player);
			Helpers.scale(player,5.0);
			
			createForegroundAndBackground();
			
			// Create shuttle controls
			shuttleControls = new ShuttleControls(5, -8);
			PlayState.groupBackground.add(shuttleControls);

			shuttleLights = new ShuttleLights(55, 88);
			PlayState.groupBackground.add(shuttleLights);
			
			// Buttons
			button0 = new CockpitButton( 83,60 );
			PlayState.groupBackground.add( button0 );
			
			button1 = new CockpitButton( 79,72 );
			PlayState.groupBackground.add( button1 );
		
			button2 = new CockpitButton( 79,78 );
			PlayState.groupBackground.add( button2 );
			
			button3 = new CockpitButton( 89,72 );
			PlayState.groupBackground.add( button3 );
			
			button4 = new CockpitButton( 89,78 );
			PlayState.groupBackground.add( button4 );

			switch0 = new CockpitSwitch( 100,71 );
			PlayState.groupBackground.add( switch0 );

			switch2 = new CockpitSwitch( 65,71 );
			PlayState.groupBackground.add( switch2 );
			
			controlArray = new Array(button0,button4,switch2,button3,button1,button2,switch0);
			soundArray = new Array(TbcRadio,TtcRadio,LtsRadio,HfRadio,DiscoveryRadio,SroRadio,LaunchteamRadio);
			waitArray = new Array(1.0,1.0,1.0,1.0,1.0,1.0,1.0);
			functionArray = new Array(monitorsOn,null,playEngineNoise0,null,lightsOn,noseConeOn,null);
		}
		
		public function createForegroundAndBackground():void {
			skySprite:FlxSprite;
			skySprite = new FlxSprite(0,0);
			skySprite.loadGraphic(ImgSky, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(skySprite);

			shuttleNoseCone = new ShuttleNoseCone(0, 0);
			PlayState.groupBackground.add(shuttleNoseCone);
			
			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(backgroundSprite);
			
			var foregroundSprite:FlxSprite;
			foregroundSprite = new FlxSprite(0,0);
			foregroundSprite.loadGraphic(ImgForeground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupForeground.add(foregroundSprite);
		}
		
		public function monitorsOn():void
		{
			shuttleControls.monitorsOn = true;
		}

		public function lightsOn():void
		{
			shuttleLights.lightsOn = true;
		}
		
		public function noseConeOn():void
		{
			shuttleNoseCone.noseConeOn = true;
		}
		
		public function playHum():void
		{
			soundEngineNoise.loadEmbedded(Hum,true,true);
			soundEngineNoise.play();
		}
		
		public function playEngineNoise0():void
		{
			soundEngineNoise.loadEmbedded(EngineNoise0,true,true);
			soundEngineNoise.play();
			
			FlxG.shake( 0.001, 100 );
		}
		
		public function liftOff():void
		{
			soundEngineNoise.loadEmbedded(LiftOff,false,true);
			soundEngineNoise.play();
			FlxG.shake( 0.003, 100 );
		}

		public function liftOff1():void
		{
			FlxG.shake( 0.01, 100 );
		}

		public function liftOff2():void
		{
			FlxG.shake( 0.015, 100 );
			
			//By setting the background color to a value with a low transparency,
			//we can generate a cool "blur" effect.
			FlxG.bgColor = 0x11000000;
		}
		
		override public function nextLevel():Boolean
		{
			if( isLiftOff3 )
			{
				soundEngineNoise.stop();
				soundEngineNoise.destroy();
				return true;
			}
			return false;
		}
		
		override public function update():void
		{
			// Make player sit down
			if( !player.isSittingDown && player.x >= 75 )
			{
				player.isSittingDown = true;
			}
			
			if( isLiftOff2 )
			{
				skySprite.x = -10 + FlxG.random()* 20;
				skySprite.y = -10 + FlxG.random()* 20;
			}
			
			// Sitting down
			if( player.isSittingDown )
			{
				button0.controlActive = true;
				
				if( addCursor )
				{
					addCursor = false;
					cursor = new AnimatedCursor();
					PlayState.groupForeground.add(cursor);
				}
				
				// Loop through controls
				if( currControlIndex < controlArray.length )
				{
					var control:CockpitBaseControl = controlArray[currControlIndex];
					var currRadio:Class = soundArray[currControlIndex];
					var currFunction:Function = functionArray[currControlIndex];
	
					if( !control.controlOn )
					{
						if( !radioPlayed )
						{
							sound.loadEmbedded(currRadio, false, true);
							sound.play();
							radioPlayed = true;
							
							if( currFunction != null )
							{
								currFunction();
							}
						}
						
						if( currControlIndex < controlArray.length - 1 )
						{	
							var currWait:Number = waitArray[currControlIndex];
							if( currWait <= 0.0 )
							{
								currControlIndex++;
								controlArray[currControlIndex].controlActive = true;
								radioPlayed = false;
							}
							else
							{
								waitArray[currControlIndex] = currWait - FlxG.elapsed;	
							}
						}
						else
						{
							if( liftOffWait >= 0.0 )
							{
								liftOffWait = liftOffWait - FlxG.elapsed
							}
							else
							{
								if( !isLiftOff )
								{
									liftOff();
									isLiftOff = true;
								}
								
								if( liftOff1Wait >= 0.0 )
								{
									liftOff1Wait = liftOff1Wait - FlxG.elapsed
								}
								else
								{
									if( !isLiftOff1 )
									{
										liftOff1();
										isLiftOff1 = true;
									}
									
									if( liftOff2Wait >= 0.0 )
									{
										liftOff2Wait = liftOff2Wait - FlxG.elapsed
									}
									else
									{
										if( !isLiftOff2 )
										{
											liftOff2();
											isLiftOff2 = true;
										}
										
										if( liftOff3Wait >= 0.0 )
										{
											liftOff3Wait = liftOff3Wait - FlxG.elapsed
										}
										else
										{
											if( !isLiftOff3 )
											{
												isLiftOff3 = true;
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
