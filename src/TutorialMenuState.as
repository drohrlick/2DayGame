package  
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	public class TutorialMenuState extends FlxState
	{
		[Embed(source = "sfx/menu_in.mp3")] private var SndMenuIn:Class;		
		
		private var _backgroundColor:Number = 0xCCCCCCCC;
		
		protected var _world:b2World;
		
		private var _numPeople:int = 8;
		protected var _array_people:Array;
		
		protected var _ship:Box2DShip;
		
		private var _timer:Number = 3;
		private var _displayTip:Boolean = false;		
		
		override public function create():void
		{						
			//A couple of simple text fields
			var t:FlxText;
			t = new FlxText(50,25,200,"This is your Peace Ship:");
			t.size = 8;
			t.alignment = "left";
			add(t);
			
			t = new FlxText(50,50,200,"Use WASD keys to move. Use your mouse to shoot.");
			t.size = 8;
			t.alignment = "left";
			add(t);
			
			t = new FlxText(50,100,200,"Make these people fall in love by shooting them with your love ray.");
			t.size = 8;
			t.alignment = "left";
			add(t);
			
			t = new FlxText(50,150,200,"They will the light up and stick with anyone close to them");
			t.size = 8;
			t.alignment = "left";
			add(t);
			
			t = new FlxText(50,200,200,"However, if you don't help them find a mate in time they will die old and alone...");
			t.size = 8;
			t.alignment = "left";
			add(t);

			CreateGameObjects();
			
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
				
				if (i == 0 || i == 1)
					_array_people[i] = new Box2DPeople( i, 300 + (i * 20) + ((i % 2) * 5), 150, 8, 8, _world);
				else if (i == 3)
					_array_people[i] = new Box2DPeople( i, 325 , 200, 8, 8, _world);
				else
					_array_people[i] = new Box2DPeople( i, 250 + (i * 20) + ((i % 2) * 5), 100, 8, 8, _world);

				_array_people[i].createBodyTutorial(i);
				_array_people[i]._obj.SetUserData(GameplayState.Contact_person_stick);	
				_array_people[i].flicker(30);
				_array_people[i].play("lovely");
				add(_array_people[i]);
			}
			
			_ship = new Box2DShip(0,300, 30, 32, 32, _world);
			_ship._obj.ApplyTorque(3);
			add(_ship);
		}
		
		private function SetupWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(0, 0);
			_world = new b2World(gravity, true);
		}
		
				//The main game loop function
		override public function update():void
		{
			_world.Step(FlxG.elapsed, 10, 10);
			
			for (var i:int; i < _array_people.length; i++)
				_array_people[i].updateTutorial();
			
			super.update();	
			
			_timer -= FlxG.elapsed;
			
			if (_timer < 0)
			{	
				if (!_displayTip)
				{
					_displayTip = true;
					var t:FlxText;
					t = new FlxText(0,FlxG.height/2+150,FlxG.width,"click to play");
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
			FlxG.state = new GameplayState();
		}
	}
}