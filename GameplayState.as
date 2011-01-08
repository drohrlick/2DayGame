package  
{
	import org.flixel.*;
	
	public class GameplayState extends FlxState
	{
		protected var _frameCounterTxt:FlxText;
		private var _frameCounter:int;
		private var _ship:Ship;
		override public function create():void
		{
			add(new FlxText(0, 0, 100, "Loveroids")); //adds a 100px wide text field at position 0,0 (upper left)

			_frameCounterTxt = new FlxText(0, 0, FlxG.width);
			_frameCounterTxt.color = 0xd8eba2;
			_frameCounterTxt.alignment = "right";
			add(_frameCounterTxt);
			
			_frameCounter = new int(0);
			
			_ship = new Ship();
			add(_ship);
		}
		
		//The main game loop function
		override public function update():void
		{		
			_ship.myUpdate();
			
			_frameCounter++;
			_frameCounterTxt.text = _frameCounter.toString();
		}
	}
}