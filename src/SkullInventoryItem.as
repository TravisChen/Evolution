package
{
	import org.flixel.*;
	
	public class SkullInventoryItem extends FlxSprite
	{
		[Embed(source='../data/skull1.png')] private var ImgSkull1:Class;
		[Embed(source='../data/skull2.png')] private var ImgSkull2:Class;
		[Embed(source='../data/skull3.png')] private var ImgSkull3:Class;
		[Embed(source='../data/skull4.png')] private var ImgSkull4:Class;
		[Embed(source='../data/skull5.png')] private var ImgSkull5:Class;
		[Embed(source='../data/skull6.png')] private var ImgSkull6:Class;
		[Embed(source="../data/skull1.png")] private var imgSkull:Class;
		[Embed(source="../data/particles.png")] private var ImgParticle:Class;
	
		private var _hudTilemap:FlxTilemap;
		
		public var hasItem:Boolean;
		public var skullType:uint;
		public var particle:FlxEmitter;
	
		public var collected:Boolean;
		public var collectedTime:Number;
		public var collectedHoldTime:Number;
		
		public const COLLECTED_TIME:Number = 0.5;
		
		public function SkullInventoryItem(X:int,Y:int,sequencer:Boolean,hudTilemap:FlxTilemap)
		{
			_hudTilemap = hudTilemap;

			super(X,Y);
			hasItem = false;
			
			skullType = 0;
			
			collected = false;
			collectedTime = COLLECTED_TIME;
			collectedHoldTime = 0.25;
			
			if( sequencer )
			{
				// Add gibs
				particle = new FlxEmitter(0,0,-1);
				particle.makeParticles(ImgParticle,80,16,true,1.0);
				PlayState.groupForegroundHigh.add(particle);
			}				
			
			loadGraphic(imgSkull, true, true, 16, 16);
		}
		
		public function setItem( type:uint ):void
		{
			skullType = type;
			hasItem = true;
			
			// Reset collected
			alpha = 1.0;
			collected = false;
			collectedTime = COLLECTED_TIME;
			collectedHoldTime = 0.25;
			
			switch (skullType){
				case 0:
					loadGraphic(ImgSkull1, true, true, 16, 16);
					break;
				case 1:
					loadGraphic(ImgSkull2, true, true, 16, 16);
					break;
				case 2:
					loadGraphic(ImgSkull3, true, true, 16, 16);
					break;
				case 3:
					loadGraphic(ImgSkull4, true, true, 16, 16);
					break;
				case 4:
					loadGraphic(ImgSkull5, true, true, 16, 16);
					break;
				case 5:
					loadGraphic(ImgSkull6, true, true, 16, 16);
					break;
			}
		}
		
		public function clearItem():void
		{
			hasItem = false;			
		}
		
		public function sequencerClearItem( success:Boolean ):void
		{
			this.visible = true;
			collected = true;	

			particle.x = x + FlxG.camera.scroll.x;
			particle.y = y;
			
			if( success )
			{
				particle.gravity = 350;
				particle.setXSpeed(-30, 30);
				particle.setYSpeed(-50, -200 );				
			}
			else
			{
				particle.gravity = 350;
				particle.setXSpeed(-30, 30);
				particle.setYSpeed(-50, -80);
			}
			
			particle.on = true;
		}
		
		override public function update():void
		{
			if( particle )
			{
				particle.update();
				FlxG.collide(particle,_hudTilemap);
			}
			
			if( collected )
			{
				collectedHoldTime -= FlxG.elapsed;
				if( collectedHoldTime <= 0 )
				{
					alpha -= 0.05;
				}

				collectedTime -= FlxG.elapsed;
				if( collectedTime <= 0 )
				{
					collected = false;
					hasItem = false;
				}
				
				return;
			}
			
			super.update();
			
			if( hasItem )
				this.visible = true;
			else
				this.visible = false;
		}
	}
}