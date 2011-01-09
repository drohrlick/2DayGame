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
		static public var RockMask:uint = 0x0008;
		static public var WallMask:uint = 0x0010;
		
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

		
		private var _numAsteroids:int = 40;
		protected var _array_asteroids:Array;
		
		private var _numPeople:int = 20;
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
			_ceiling = new Box2DBoundary( -30, -30, FlxG.width + 60, 30, _world ); 
			_floor = new Box2DBoundary( -30, FlxG.height, FlxG.width + 60, 30, _world );
			_wallLeft = new Box2DBoundary( -30, 0, 30, FlxG.height, _world );
			_wallRight = new Box2DBoundary( FlxG.width, 0, 30, FlxG.height, _world );
			
			_ceiling.createBody();
			_floor.createBody();
			_wallLeft.createBody();
			_wallRight.createBody();
			
			add(_ceiling);
			add(_floor);
			add(_wallLeft);
			add(_wallRight);
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
				_array_people[i] = new Box2DPeople( FlxU.random() * Loveroids.resX, FlxU.random() * Loveroids.resY, 8, 8, _world);
				add(_array_people[i]);
			}
			
			_ship = new Box2DShip(Loveroids.resX / 2 - 16, Loveroids.resY / 2 - 16, 32, 32, _world);
			_ship.createBody();
			_ship.loadGraphic(_ship.Img, false, false,32,32);
			add(_ship);
			add(_ship._hook1);
		}
		
				//The main game loop function
		override public function update():void
		{		
			//_ship.myUpdate();
			
			_world.Step(FlxG.elapsed, 10, 10);
			super.update();	
									
			//_frameCounter++;
			//_frameCounterTxt.text = _frameCounter.toString();
		}
	}
}