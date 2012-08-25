package
{
	import org.flixel.*;
	
	public class CockpitSwitch extends CockpitBaseControl
	{
		[Embed(source="../data/cockpit-lever.png")] private var imgButton:Class;
		
		public function CockpitSwitch(X:int,Y:int)
		{			
			super(X,Y);
			
			this.width = 14;
			this.height = 20;
			
			loadGraphic(imgButton, true, true, 14, 20);
			addAnimation("inactive", [0]);
			addAnimation("normal", [0,1,2,2,1], 7);
			addAnimation("animate", [3,4,5,6,7,8], 6, false);
		}
	}
}