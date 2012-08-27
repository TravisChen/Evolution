package    {
	
	import org.flixel.*;
	
	public class Evolution_LevelMenu extends Level{
		
		[Embed(source = '../data/intro.png')] private var ImgBackground:Class;
		[Embed(source='../data/Tilemaps/map-tiles.png')] private var ImgTiles:Class;
		[Embed(source='../data/Tilemaps/MapCSV_Evolution_Intro.txt',mimeType="application/octet-stream")] private var TxtMap:Class;
		
		private var _particle:FlxEmitter;
		
		private var tilemap:FlxTilemap;
		public const TEXT_COLOR:uint = 0xFF33d72ae;
		public const TEXT_COLOR_LIGHT:uint = 0xFFbeec5b;
		
		public var playerIntro:PlayerIntro;
		
		public function Evolution_LevelMenu( group:FlxGroup ) {
			
			super();
			
			levelSizeX = 320;
			levelSizeY = 128;
			
			// Tilemap
			tilemap = new FlxTilemap();
			tilemap.loadMap(new TxtMap,ImgTiles,8);
			tilemap.visible = false;
			PlayState.groupTilemap.add(tilemap);

			// Create player
			playerIntro = new PlayerIntro(FlxG.width/2 - 16,FlxG.height - 50,tilemap);
			PlayState.groupPlayer.add(playerIntro);
			
			createForegroundAndBackground();
		}
		
		override public function nextLevel():Boolean
		{
			if(FlxG.keys.any() )
			{
				return true;
			}
			return false;
		}
		
		public function createForegroundAndBackground():void {

//			var header:FlxText = new FlxText(0, 1, FlxG.width, "FOR THE");
//			header.setFormat(null,32,TEXT_COLOR,"center");
//			header.scrollFactor.x = header.scrollFactor.y = 0;	
//			PlayState.groupForeground.add(header);
//
//			var header0:FlxText = new FlxText(0, 40, FlxG.width, "WIN");
//			header0.setFormat(null,32,TEXT_COLOR,"center");
//			header0.scrollFactor.x = header.scrollFactor.y = 0;	
//			PlayState.groupForeground.add(header0);
//
			var header1:FlxText = new FlxText(0, 116, FlxG.width, "PRESS ANY KEY TO PLAY");
			header1.setFormat(null,8,TEXT_COLOR_LIGHT,"center");
			header1.scrollFactor.x = header1.scrollFactor.y = 0;	
			PlayState.groupForeground.add(header1);

			var backgroundSprite:FlxSprite;
			backgroundSprite = new FlxSprite(0,0);
			backgroundSprite.loadGraphic(ImgBackground, true, true, levelSizeX, levelSizeY);	
			PlayState.groupBackground.add(backgroundSprite);
		}
	}
}
