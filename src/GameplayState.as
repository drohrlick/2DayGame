package  
{
	import flash.text.engine.BreakOpportunity;
	import org.flixel.*;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	public class GameplayState extends FlxState
	{
		static public var ShipMask:uint = 0x0002;
		static public var HookMask:uint = 0x0004;
		static public var PersonMask:uint = 0x0008;
		static public var WallMask:uint = 0x0010;
		
		static public var Contact_person_free:String = new String("Person_Free");			//person free roaming
		static public var Contact_person_stick:String = new String("Person_Sticking");		//person just stuck by hook
		static public var Contact_person_flash:String = new String("Person_Flashing");		//person flashing and ready to combine
		static public var Contact_person_combine:String = new String("Person_Combined");	//person combined with another
		static public var Contact_person_kill:String = new String("Person_Killed");			//remove person once combined.
		static public var Contact_hook_free:String = new String("Hook_Free");
		static public var Contact_hook_stick:String = new String("Hook_Sticking");
		static public var Contact_player:String = new String("Player");
		static public var Contact_boundary:String = new String("Boundary");		
		
		private var ratio:Number = 30;
		
		protected var _frameCounterTxt:FlxText;
		protected var _frameCounter:int;
		protected var _world:b2World;
		protected var _contactListener:MyContactListener;
		
		protected var _ceiling:Box2DBoundary;
		protected var _floor:Box2DBoundary;
		protected var _wallLeft:Box2DBoundary;
		protected var _wallRight:Box2DBoundary;

		protected var _ship:Box2DShip;
		
		private var _numPeople:int = 10;
		private var _numPeopleLoved:int = 0;
		protected var _array_people:Array;
		
		protected var _line:Line;
		
		private var _backgroundColor:Number = 0xDDDDDDDD;
		
		override public function create():void
		{	
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
			_frameCounterTxt = new FlxText(0, 0, FlxG.width);
			_frameCounterTxt.color = 0xd8eba2;
			_frameCounterTxt.alignment = "right";
			add(_frameCounterTxt);
			
			_frameCounter = new int(0);
			
			add(new FlxText(0, 0, 100, "Loveroids")); //adds a 100px wide text field at position 0,0 (upper left)

		}
		
		private function CreateGameObjects():void
		{
			var i:int;

			SetupWorld();		
			/*
			_array_asteroids = new Array();
			for (i = 0; i < _numAsteroids; i++)
			{
				_array_asteroids[i] = new Box2DAsteroid(FlxU.random()*Loveroids.resX, FlxU.random()*Loveroids.resY, 32, 32, _world);
				_array_asteroids[i].createBody();
				_array_asteroids[i].loadGraphic(_array_asteroids[i].Img, false, false, 32, 32);
				add(_array_asteroids[i]);
			}
			*/
			
			_array_people = new Array()
			for (i = 0; i < _numPeople; i++)
			{
				_array_people[i] = new Box2DPeople( i, FlxU.random() * Loveroids.resX, FlxU.random() * Loveroids.resY, 8, 8, _world);
				add(_array_people[i]);
			}
			
			_ship = new Box2DShip(0, Loveroids.resX / 2 - 16, Loveroids.resY / 2 - 16, 32, 32, _world);
			_ship.loadGraphic(_ship.Img, false, false, 32, 32);
			add(_ship._chain1);
			//add(_ship._chain2);
			add(_ship);
			add(_ship._hook1);
			//add(_ship._hook2);
		}
		
				//The main game loop function
		override public function update():void
		{		
			//_ship.myUpdate();
			
			_world.Step(FlxG.elapsed, 10, 10);
			//_world.ClearForces();
			// scanning through all bodies
			for (var worldbody:b2Body = _world.GetBodyList(); worldbody; worldbody = worldbody.GetNext()) 
			{
				if (worldbody.GetUserData() != null)
				{
					if (worldbody.GetUserData()== GameplayState.Contact_person_combine) 
					{
						// ... just remove it!!
						_world.DestroyBody(worldbody);
						worldbody.SetUserData(GameplayState.Contact_person_kill);
						_numPeopleLoved++;
					
						//make body fly back toward ship pos.
						//_ship._personHolder1 = worldbody.GetPosition();
						//var offset:b2Vec2 = _ship._obj.GetPosition() - worldbody.GetPosition();
						//worldbody.SetPosition(_ship._obj.GetPosition());
					}
				}
			}
			
			if (_numPeopleLoved == _numPeople)
				FlxG.state = new EndMenuState();
			
			super.update();	
									

		}
	}
}