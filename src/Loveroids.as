package  
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="1024", height="768", backgroundColor="#000000")] //Set the size and color of the Flash file
//	[SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file
 
	public class Loveroids extends FlxGame
	{
		//static public var resX:int = 320;
		//static public var resY:int = 240;
		
		static public var resX:int = 512;
		static public var resY:int = 384;
		
		public function Loveroids()
		{
			super(resX, resY, StartMenuState, 2); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
		}
	}

}