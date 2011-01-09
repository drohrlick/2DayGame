package  
{
	import org.flixel.*;
	
	public class StartMenuState extends FlxState
	{
		private var _backgroundColor:Number = 0xff783629;
		
		override public function create():void
		{
			//A couple of simple text fields
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"Loveroids");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(0,FlxG.height-20,FlxG.width,"click to play");
			t.alignment = "center";
			add(t);
			
			FlxState.bgColor = _backgroundColor;
			
			FlxG.mouse.show();		
		}
		
		//The main game loop function
		override public function update():void
		{
			//Switch to play state if the mouse is pressed
			if(FlxG.mouse.justPressed())
				FlxG.state = new GameplayState();
		}
	}
}