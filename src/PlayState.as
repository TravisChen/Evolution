package
{
	import org.flixel.*;
	
	public class PlayState extends BasePlayState
	{
		[Embed(source = '../data/shuttle-gantry.png')] private var ImgForeground:Class;
		
		public static var _currLevel:Level;
		
		public static var groupBackground:FlxGroup;
		public static var groupPlayer:FlxGroup;
		public static var groupForeground:FlxGroup;
			
		function PlayState():void
		{
			super();

			groupBackground = new FlxGroup;
			groupPlayer = new FlxGroup;
			groupForeground = new FlxGroup;
			
			// Create the level
			var currLevelClass:Class = levelArray[Evolution.currLevelIndex];
			_currLevel = new currLevelClass( groupBackground );

			this.add(groupBackground);
			this.add(groupPlayer);
			this.add(groupForeground);
		}
		
		override public function update():void
		{
			// Camera
			if( _currLevel.player != null )
			{
				FlxG.camera.follow(_currLevel.player, FlxCamera.STYLE_PLATFORMER);
				FlxG.camera.setBounds(0,0,_currLevel.levelSizeX,_currLevel.levelSizeY);
			}
			
			if( _currLevel.shuttle != null )
			{
				FlxG.camera.follow(_currLevel.shuttle, FlxCamera.STYLE_PLATFORMER);
				FlxG.camera.setBounds(0,0,_currLevel.levelSizeX,_currLevel.levelSizeY);
			}
			
			// Camera
			if( _currLevel.playerZeroG != null )
			{
				FlxG.camera.follow(_currLevel.playerZeroG, FlxCamera.STYLE_PLATFORMER);
				FlxG.camera.setBounds(0,0,_currLevel.levelSizeX,_currLevel.levelSizeY);
			}
			
			// Update level
			_currLevel.update();
			
			// Next level
			if( _currLevel.nextLevel() )
			{
				nextLevel();				
			}
			
			super.update();
		}
		
		public function nextLevel():void
		{
			Evolution.currLevelIndex++;
			if( Evolution.currLevelIndex > levelArray.length - 1 )
			{
				Evolution.currLevelIndex = 0;
			}
			FlxG.switchState(new PlayState());
		}
		
		override public function create():void
		{
		}

		override public function destroy():void
		{
			// Update level
			_currLevel.destroy();
			
			super.destroy();
		}
	}
}