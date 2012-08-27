package
{
	import org.flixel.*;
	
	public class PlayerIntro extends FlxSprite
	{
		[Embed(source="data/darwin.png")] private var ImgDarwin:Class;
		[Embed(source="../data/particles.png")] private var ImgParticle:Class;
		
		private var _particle:FlxEmitter;
		private var _tilemap:FlxTilemap;
		
		public function PlayerIntro(X:int,Y:int,tilemap:FlxTilemap)
		{
			_tilemap = tilemap;
				
			super(X,Y);
			loadGraphic(ImgDarwin,true,true,32,32);
				
			// Add gibs
			_particle = new FlxEmitter(0,0,-1);
			_particle.makeParticles(ImgParticle,80,16,true,1.0);
			PlayState.groupForeground.add(_particle);
			
			addAnimation("dig", [5,6,7], 8);
		}
	
		public function dig():void
		{
			_particle.x = x + 22;
			_particle.y = y + 33;
			
			_particle.gravity = 350;
			_particle.setXSpeed(-30, 30);
			_particle.setYSpeed(-50, -80);
			
			_particle.on = true;
		}
		
		
		override public function update():void
		{
			FlxG.collide(_tilemap,_particle);
			_particle.update();
			
			//UPDATE POSITION AND ANIMATION
			super.update();
			
			play("dig");
			if( finished )
			{
				dig();
				finished = false;
			}
		}
	}
}