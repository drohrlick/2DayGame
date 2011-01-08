package  
{
	import org.flixel.*;
	
	public class Ship extends FlxSprite
	{
		[Embed(source = "sprites/shipA.png")] private var Img:Class;	//Graphic of the player's ship		
		
		public var Hook1_index:int;
		public var Hook2_index:int;
		public var Hook1:Hook;
		public var Hook2:Hook;
		
		public function Ship() 
		{
			maxThrust = 100;
			drag = new FlxPoint(0, 0);
			
			Hook1 = new Hook();
			Hook2 = new Hook();
			
			super(FlxG.width / 2 - 8, FlxG.height / 2 - 8, Img);
		}
		
//		public override function update():void
		public function myUpdate():void
		{	
			//trace("update");
			Hook1.myUpdate();
			//Hook1.Sprite.x = this.x - 5;
			//Hook1.Sprite.y = this.y;
			//
			Hook2.update();
			//Hook2.Sprite.x = this.x + 5;
			//Hook2.Sprite.y = this.y;

			
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
				Hook1.reset(x + (width - Hook1.width) / 2, y + (height - Hook1.height) / 2);
				Hook1.angle = angle;
				Hook1.velocity = FlxU.rotatePoint(150,0,0,0,Hook1.angle);
				Hook1.velocity.x += velocity.x;
				Hook1.velocity.y += velocity.y;
			}
			else
			{
				//Hook1.x = x + 5;
				//Hook1.y = y;
				//Hook1.angle = angle;
				
				Hook2.x = x -5;
				Hook2.y = y;
				Hook2.angle = angle;
			}			
			Hook1.Line.drawLine(x, y, Hook1.x, Hook1.y, 0x00000000, 1);
			
			super.update();
		}
	}

}