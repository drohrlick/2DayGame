package  
{
	import org.flixel.*;
	
	public class GameplayState extends FlxState
	{
		protected var _frameCounterTxt:FlxText;
		protected var _frameCounter:int;
		protected var _ship:Ship;
		protected var _asteroids:FlxGroup;
		override public function create():void
		{
			var i:int;
			
			add(new FlxText(0, 0, 100, "Loveroids")); //adds a 100px wide text field at position 0,0 (upper left)

			_frameCounterTxt = new FlxText(0, 0, FlxG.width);
			_frameCounterTxt.color = 0xd8eba2;
			_frameCounterTxt.alignment = "right";
			add(_frameCounterTxt);
			
			_frameCounter = new int(0);
			
			_ship = new Ship();
			add(_ship);

			add(_ship.Hook1);
			add(_ship.Hook2);
			
			add(_ship.Hook1.Line);
			add(_ship.Hook2.Line);
						
			_asteroids = new FlxGroup();
			add(_asteroids);
			Asteroid.group = _asteroids;
			
			for (i = 0; i < 32; i++)
			{
				_asteroids.add(new Asteroid(FlxU.random() * Loveroids.resX, FlxU.random() * Loveroids.resY))			
			}
			
			FlxState.bgColor = 0x8800FF00;
		}
		
		//The main game loop function
		override public function update():void
		{		
			_ship.myUpdate();

			for (var i:int = 0; i < _asteroids.members.length; i++)
				_asteroids.members[i].myUpdate();
			
				
				
			//_frameCounter++;
			//_frameCounterTxt.text = _frameCounter.toString();
		}
	}
}