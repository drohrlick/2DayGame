package  
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	public class GameplayState_Level2 extends FlxState
	{	
		private var _timer:Number = GameLogic.LevelTimeLimit;
		private var _timerText:FlxText;
		private var _ratio:Number = 30;
	
		protected var _world:b2World;
		protected var _contactListener:MyContactListener;
		
		protected var _ceiling:Box2DBoundary;
		protected var _floor:Box2DBoundary;
		protected var _wallLeft:Box2DBoundary;
		protected var _wallRight:Box2DBoundary;

		protected var _ship:Box2DShip;
		
		private var _numPeopleDied:int = 0;
		private var _numPeopleDiedLonely:int = 0;
		private var _numPeople:int = 10;
		protected var _array_people:Array;
		
		private var _numAsteroids:int = 10;
		protected var _array_asteroids:Array;
		
		protected var _line:Line;
		
		private var _backgroundColor:Number = 0x99FFDDEE;
		
		override public function create():void
		{	
			FlxG.playMusic(GameLogic.SndMainMusic);
			
			CreateText();
			CreateGameObjects();

			//background color
			FlxState.bgColor = _backgroundColor;
		}
		
		private function SetupWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(0, 0);
			_world = new b2World(gravity, true);
			
			//create a contact listener for collions in this world
			_contactListener = new MyContactListener();
			_world.SetContactListener(_contactListener);
			
			// create the bounding walls
			_ceiling = new Box2DBoundary(0, -30, -30, FlxG.width + 60, 30, _world ); 
			_floor = new Box2DBoundary(0, -30, FlxG.height, FlxG.width + 60, 30, _world );
			_wallLeft = new Box2DBoundary(0, -30, 0, 30, FlxG.height, _world );
			_wallRight = new Box2DBoundary(0, FlxG.width, 0, 30, FlxG.height, _world );
			
			//add(_ceiling);
			//add(_floor);
			//add(_wallLeft);
			//add(_wallRight);
		}
		
		private function CreateText():void
		{	
			_timerText = new FlxText(Loveroids.resX / 2 - 25, 20,50, String(_timer));
			_timerText.size = 20;
			_timerText.alignment = "center";
			add(_timerText);
		}
		
		private function CreateGameObjects():void
		{
			var i:int;

			SetupWorld();		
			
			_array_people = new Array()
			for (i = 0; i < _numPeople; i++)
			{
				_array_people[i] = new Box2DPeople( i, FlxU.random() * Loveroids.resX, FlxU.random() * Loveroids.resY, 8, 8, _world);
				_array_people[i].createBodyGameplay(i);
				add(_array_people[i]);
			}
			
			_array_asteroids = new Array()
			for (i = 0; i < _numAsteroids; i++)
			{
				_array_asteroids[i] = new Box2DAsteroid( i, FlxU.random() * Loveroids.resX, FlxU.random() * Loveroids.resY, 32, 32, _world);
				add(_array_asteroids[i]);
			}
			
			var grouping:Box2DGrouping = new Box2DGrouping(_world);
			for (i = 0; i < 15; i++)
			{
				var person:Box2DPeople = new Box2DPeople( _numPeople + i, FlxU.random() * Loveroids.resX, FlxU.random() * Loveroids.resY, 8, 8, _world)
				person.createBodyGameplay(_numPeople + i);
				grouping.addPerson(person);
			}
			add(grouping);

			_ship = new Box2DShip(0, Loveroids.resX / 2 - 16, Loveroids.resY / 2 - 16, 32, 32, _world);
			add(_ship._chain1);
			//add(_ship._chain2);
			add(_ship);
			add(_ship._hook1);
			//add(_ship._hook2);
		}
		
				//The main game loop function
		override public function update():void
		{		
			UpdateTimer();
			
			_world.Step(FlxG.elapsed, 10, 10);
			//_world.ClearForces();
			// scanning through all bodies
			for (var worldbody:b2Body = _world.GetBodyList(); worldbody; worldbody = worldbody.GetNext()) 
			{
				if (worldbody.GetUserData() != null)
				{
					/////////////////////////////////////////////////
					//If we want person to remain at hook position
					/////////////////////////////////////////////////
					//if (worldbody.GetUserData() == GameplayState.Contact_person_stick)
					//{
					//	worldbody.SetPosition(_ship._hook1._obj.GetPosition());
					//}
					
					if (worldbody.GetUserData()== GameLogic.Contact_person_combine) 
					{
						// ... just remove it!!
						_world.DestroyBody(worldbody);
						worldbody.SetUserData(GameLogic.Contact_person_kill);
						_numPeopleDied++;
						FlxG.play(GameLogic.SndHookup);
						
						//make body fly back toward ship pos.
						//_ship._personHolder1 = worldbody.GetPosition();
						//var offset:b2Vec2 = _ship._obj.GetPosition() - worldbody.GetPosition();
						//worldbody.SetPosition(_ship._obj.GetPosition());
					}
					if (worldbody.GetUserData() == GameLogic.Contact_person_oldAge)
					{
						_world.DestroyBody(worldbody);
						worldbody.SetUserData(GameLogic.Contact_person_kill);
						_numPeopleDied++;
						_numPeopleDiedLonely++;
						FlxG.play(GameLogic.SndBrokenHeart);
					}
				}
			}
			
			if (_numPeopleDied == _numPeople)
			{
				//if(_numPeopleDiedLonely == 0)
					FlxG.fade.start(0xff000000, 1, HappyTransition);
				//else
				//	FlxG.fade.start(0xff000000, 1, SadTransition);
			}
			
			super.update();	
		}
		
		private function UpdateTimer():void
		{
			_timer -= FlxG.elapsed;
 	
			_timerText.text = "" + FlxU.floor(_timer);
			
			if (_timer <= 0)
				FlxG.fade.start(0xff000000, 1, SadTransition);
		}
		
		private function HappyTransition():void
		{
			FlxG.state = new HappyEndMenuState();						
		}
		
		private function SadTransition():void 
		{
			FlxG.state = new GameOverMenuState();			
		}
	}
}