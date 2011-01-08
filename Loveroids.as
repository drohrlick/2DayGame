package  
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
//	[SWF(width="1280", height="1024", backgroundColor="#000000")] //Set the size and color of the Flash file
	[SWF(width="1024", height="768", backgroundColor="#000000")] //Set the size and color of the Flash file
 
	public class Loveroids extends FlxGame
	{
		public function Loveroids()
		{
			super(512, 384, GameplayState, 2); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
//			super(320, 240, StartMenuState, 2);
		}
	}

}