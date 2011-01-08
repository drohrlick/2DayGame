package  
{
	import org.flixel.*;
	
	public class Asteroid extends FlxSprite
	{
		static public var group:FlxGroup;
		[Embed(source = "sprites/asteroid.png")] private var Img:Class;	
		
		public var Hooked:Boolean = false;

		public function Asteroid(x:int = 0, y:int = 0) 
		{
			super(x, y, Img);
			
			//Set the asteroids a-rotatin' at a random speed (looks neat)
			angularVelocity = FlxU.random()*120 - 60;
			angle = FlxU.random() * 360;
			
			if(FlxU.random() < 0.5)		
				velocity.x = FlxU.random() * 10;
			else
				velocity.x = FlxU.random() * -10;
						
			if (FlxU.random() < 0.5)
				velocity.y = FlxU.random() * 10;
			else
				velocity.y = FlxU.random() * -10;
		}
		
		public function myUpdate():void
		{
			//angle -= 100;
			
			super.update();
		}
	}

}