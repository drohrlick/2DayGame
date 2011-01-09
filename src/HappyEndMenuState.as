package  
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	public class HappyEndMenuState extends FlxState
	{
		[Embed(source = "sfx/menu_in.mp3")] private var SndMenuIn:Class;		

		private var _backgroundColor:Number = 0xff783629;
		
		private var _timer:Number = 3;
		private var _displayTip:Boolean = false;
		
		override public function create():void
		{			
			//A couple of simple text fields
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-100,FlxG.width,"Yay you won!");
			t.size = 48;
			t.alignment = "center";
			add(t);
			
			FlxState.bgColor = _backgroundColor;
			
			FlxG.mouse.show();		
		}
		
		//The main game loop function
		override public function update():void
		{
			super.update();	
			
			_timer -= FlxG.elapsed;
			
			if (_timer < 0)
			{	
				if (!_displayTip)
				{
					_displayTip = true;
					var t:FlxText;
					t = new FlxText(0,FlxG.height/2+100,FlxG.width,"click to skip");
					t.alignment = "center";
					add(t);
				}
				
				//Switch to play state if the mouse is pressed
				if (FlxG.mouse.justPressed())
				{
					FlxG.play(SndMenuIn);
					FlxG.fade.start(0xff000000, 1, SceneTransition);
				}
			}
		}
		
		private function SceneTransition():void
		{
			FlxG.state = new StartMenuState();
		}
	}
}