package  
{
	import org.flixel.*;
	
	public class Hook extends FlxSprite
	{
		public var Line:FlxSprite;
		public var Sprite:FlxSprite;
		public var Index:int;
		public function Hook(id:int = 0) 
		{
			Index = id;
			Sprite = new FlxSprite(0, 0);
			Sprite.createGraphic(8, 2, 0xffffffff);
			
			Line = new FlxSprite(0, 0);
		}	
		
		public function myUpdate():void
		{
			super.update();
		}
	}

}