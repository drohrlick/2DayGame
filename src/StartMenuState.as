package  
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	public class StartMenuState extends FlxState
	{
		[Embed(source = "music/Menu.mp3")] private var SndMainMusic:Class;
		[Embed(source = "sfx/menu_in.mp3")] private var SndMenuIn:Class;		
		
		private var _backgroundColor:Number = 0xff783629;
		
		protected var _world:b2World;
		
		private var _numPeople:int = 100;
		protected var _array_people:Array;
		private var _resetPos:b2Vec2 = new b2Vec2(100, 100);
		
		override public function create():void
		{			
			FlxG.playMusic(SndMainMusic);
			
			//A couple of simple text fields
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-100,FlxG.width,"Loveroids");
			t.size = 60;
			t.alignment = "center";
			add(t);
			t = new FlxText(0,FlxG.height/2+100,FlxG.width,"click to play");
			t.alignment = "center";
			add(t);

			CreateGameObjects();
			
			//make some people go in front and others  not.
			t = new FlxText(0,FlxG.height/2-99,FlxG.width,"Loveroids");
			t.size = 60;
			t.alignment = "center";
			add(t);

			
			FlxState.bgColor = _backgroundColor;
			
			FlxG.mouse.show();		
		}
		
		private function CreateGameObjects():void
		{
			var i:int;
			SetupWorld();	
			
			_array_people = new Array()
			for (i = 0; i < _numPeople; i++)
			{
				_array_people[i] = new Box2DPeople( i,
													FlxU.random() * Loveroids.resX, 
													(FlxU.random() * Loveroids.resY) - Loveroids.resY, 8, 8, _world);
				add(_array_people[i]);
			}
		}
		
		private function SetupWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(0, 0.1);
			_world = new b2World(gravity, true);
		}
		
				//The main game loop function
		override public function update():void
		{
			_world.Step(FlxG.elapsed, 10, 10);
			super.update();	
			
			for (var i:int = 0; i < _numPeople; i++)
			{
				if (_array_people[i].y > Loveroids.resY)
				{
				}				
			}
			
			//Switch to play state if the mouse is pressed
			if (FlxG.mouse.justPressed())
			{
				FlxG.play(SndMenuIn);
				FlxG.state = new GameplayState();
			}
		}
	}
}