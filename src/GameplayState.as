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
		[Embed(source = "music/Gameplay1.mp3")] static public var SndMainMusic:Class;
		[Embed(source = "sfx/laser_shot2.mp3")] static public var SndShoot:Class;		
		[Embed(source = "sfx/laser_grab.mp3")] static public var SndCombine:Class;		
		[Embed(source = "sfx/Hookup.mp3")] static public var SndHookup:Class;		
		[Embed(source = "sfx/BrokenHeart.mp3")] static public var SndBrokenHeart:Class;		
		[Embed(source = "sfx/EngineRev.mp3")] static public var SndEngine:Class;		
		[Embed(source = "sfx/Collision.mp3")] static public var SndShipCollision:Class;		
		
		static public var ShipMask:uint = 0x0002;
		static public var HookMask:uint = 0x0004;
		static public var PersonMask:uint = 0x0008;
		static public var WallMask:uint = 0x0010;
		
		static public var Contact_person_free:String = new String("Person_Free");			//person free roaming
		static public var Contact_person_stick:String = new String("Person_Sticking");		//person just stuck by hook
		static public var Contact_person_flash:String = new String("Person_Flashing");		//person flashing and ready to combine
		static public var Contact_person_combine:String = new String("Person_Combined");	//person combined with another
		static public var Contact_person_kill:String = new String("Person_Killed");			//remove person once combined.
		static public var Contact_person_oldAge:String = new String("Person_OldAge");		//remove person when they remain single and end flicker
		static public var Contact_hook_free:String = new String("Hook_Free");
		static public var Contact_hook_stick:String = new String("Hook_Sticking");
		static public var Contact_player:String = new String("Player");
		static public var Contact_player_collision:String = new String("Player_Collision");		
		static public var Contact_boundary:String = new String("Boundary");		
		
		private var _timer:Number = 60;
		private var _timerText:FlxText;
		private var _ratio:Number = 30;
		
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
		private var _numPeopleDied:int = 0;
		private var _numPeopleDiedLonely:int = 0;
		protected var _array_people:Array;
		
		protected var _line:Line;
		
		private var _backgroundColor:Number = 0x99FFDDEE;
		
		override public function create():void
		{	
			FlxG.playMusic(SndMainMusic);
			
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
			
			_timerText = new FlxText(Loveroids.resX / 2 - 25, 20,50, String(_timer));
			_timerText.size = 20;
			_timerText.alignment = "center";
			add(_timerText);
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
			
			var grouping:Box2DGrouping = new Box2DGrouping(_world);
			
			for (i = 0; i < 15; i++)
			{
				grouping.addPerson(new Box2DPeople( i, FlxU.random() * Loveroids.resX, FlxU.random() * Loveroids.resY, 8, 8, _world));
			}
			add(grouping);
			
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
					
					if (worldbody.GetUserData()== GameplayState.Contact_person_combine) 
					{
						// ... just remove it!!
						_world.DestroyBody(worldbody);
						worldbody.SetUserData(GameplayState.Contact_person_kill);
						_numPeopleDied++;
						FlxG.play(GameplayState.SndHookup);
						
						//make body fly back toward ship pos.
						//_ship._personHolder1 = worldbody.GetPosition();
						//var offset:b2Vec2 = _ship._obj.GetPosition() - worldbody.GetPosition();
						//worldbody.SetPosition(_ship._obj.GetPosition());
					}
					if (worldbody.GetUserData() == GameplayState.Contact_person_oldAge)
					{
						_world.DestroyBody(worldbody);
						worldbody.SetUserData(GameplayState.Contact_person_kill);
						_numPeopleDied++;
						_numPeopleDiedLonely++;
						FlxG.play(GameplayState.SndBrokenHeart);
					}
				}
			}
			
			if (_numPeopleDied == _numPeople)
			{
				if(_numPeopleDiedLonely == 0)
					FlxG.state = new HappyEndMenuState();
				else
					FlxG.state = new GameOverMenuState();				
			}
			
			super.update();	
									

		}
		
		private function UpdateTimer():void
		{
			_timer -= FlxG.elapsed;
 	
			_timerText.text = "" + FlxU.floor(_timer);
			
			if(_timer <= 0)
				FlxG.state = new GameOverMenuState();
		}
	}
}