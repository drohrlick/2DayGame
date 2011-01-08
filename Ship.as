package  
{
	import org.flixel.*;
	
	public class Ship extends FlxSprite
	{
		[Embed(source = "ship2.png")] private var ImgShip:Class;	//Graphic of the player's ship		
		
		public function Ship() 
		{
			maxThrust = 100;
			super(FlxG.width / 2 - 8, FlxG.height / 2 - 8, ImgShip);
		}
		
		public function myUpdate():void
		{
			super.update();
			
			if (FlxG.keys.W)
				angularVelocity -= 60;
			if (FlxG.keys.A)
				angularVelocity += 60;
			if (FlxG.keys.S)
				thrust += maxThrust*2;
			if (FlxG.keys.D)
				thrust += maxThrust * -2;
			

		}
	}

}