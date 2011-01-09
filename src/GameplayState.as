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
		
		protected var _frameCounterTxt:FlxText;
		protected var _frameCounter:int;
		protected var _ship:Box2DShip;
		protected var _world:b2World;
		
		protected var _array_asteroids:Array;
		
		protected var _line:Line;
		
		private var _numAsteroids:int = 20;
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

			_array_asteroids = new Array();
			for (i = 0; i < _numAsteroids; i++)
			{
				_array_asteroids[i] = new Box2DAsteroid(FlxU.random()*Loveroids.resX, FlxU.random()*Loveroids.resY, 32, 32, _world);
				_array_asteroids[i].createBody();
				_array_asteroids[i].loadGraphic(_array_asteroids[i].Img, false, false, 32, 32);
				add(_array_asteroids[i]);
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