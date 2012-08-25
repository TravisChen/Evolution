package
{
	import org.flixel.*;

	public class CockpitButton extends CockpitBaseControl
	{
		[Embed(source="../data/cockpit-button.png")] private var imgButton:Class;
		
		public function CockpitButton(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(imgButton, true, true, 12, 12);
			addAnimation("normal", [0,1,2,3,2,1], 7);
			addAnimation("inactive", [0]);
			addAnimation("animate", [0]);
		}
	}
}