package  
{
	import org.flixel.*;
	
	public class StartMenuState extends FlxState
	{
		override public function create():void
		{
			add(new FlxText(0, 0, 100, "StartMenu for Loveroids")); //adds a 100px wide text field at position 0,0 (upper left)
		}
		
		//The main game loop function
		override public function update():void
		{
		}
	}
}