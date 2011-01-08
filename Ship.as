package  
{
	import org.flixel.*;
	
	public class Ship extends FlxSprite
	{
		[Embed(source = "ship.png")] private var Img:Class;	//Graphic of the player's ship		
		
		public function Ship() 
		{
			maxThrust = 100;
			drag = new FlxPoint(0,0);
			
			super(FlxG.width / 2 - 8, FlxG.height / 2 - 8, Img);
		}
		
//		public override function pdate():void
		public function myUpdate():void
		{	
			//trace("update");
			
			thrust = 0;
			if (FlxG.keys.W)
				thrust -= 100;
			if (FlxG.keys.S)
				thrust += 100;
				
			angularVelocity = 0;
			if (FlxG.keys.A)
				angularVelocity -= 200;
			if (FlxG.keys.D)
				angularVelocity += 200;
			
			if (FlxG.mouse.justPressed())
			{
			
			}
			
			super.update();
		}
	}

}