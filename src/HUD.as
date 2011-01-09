package  
{
	import org.flixel.FlxText;
	
	public class HUD 
	{
		public var TimerText:FlxText;
		public var DiedHappyText:FlxText;
		public var DiedLonelyText:FlxText;
		public var GoalText:FlxText;
		
		public function HUD() 
		{
			TimerText = new FlxText(Loveroids.resX / 2 - 25, 20,50, "");
			TimerText.size = 20;
			TimerText.alignment = "center";
			
			GoalText = new FlxText(Loveroids.resX - 150, 20, 100, "Goal: ");
			GoalText.size = 8;
			GoalText.color = 0x00000000;
			GoalText.alignment = "left";
			
			DiedHappyText = new FlxText(Loveroids.resX - 150, 30, 100, "Died Happy: ");
			DiedHappyText.size = 8;
			DiedHappyText.color = 0x00000000;
			DiedHappyText.alignment = "left";
			
			DiedLonelyText = new FlxText(Loveroids.resX - 150, 40, 100, "Died Lonely: ");
			DiedLonelyText.size = 8;
			DiedLonelyText.color = 0x00000000;
			DiedLonelyText.alignment = "left";
		}
		
	}

}