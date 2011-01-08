package  
{
	import org.flixel.*;
	
	public class Hook extends FlxSprite
	{
		public var Sprite:FlxSprite;
		public var Index:int;
		public function Hook(id:int = 0) 
		{
			Index = id;
			Sprite = new FlxSprite(0, 0);
			Sprite.createGraphic(8, 2, 0xffffffff);
		}	
		
		public function myUpdate():void
		{
			super.update();
		}
	}

}