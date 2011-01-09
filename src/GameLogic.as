package  
{
	public class GameLogic 
	{
		[Embed(source = "music/Gameplay1.mp3")] static public var SndMainMusic:Class;
		[Embed(source = "sfx/laser_shot2.mp3")] static public var SndShoot:Class;		
		[Embed(source = "sfx/laser_grab.mp3")] static public var SndGrab:Class;		
		[Embed(source = "sfx/Hookup.mp3")] static public var SndHookup:Class;		
		[Embed(source = "sfx/BrokenHeart.mp3")] static public var SndBrokenHeart:Class;		
		[Embed(source = "sfx/EngineRev.mp3")] static public var SndEngine:Class;		
		[Embed(source = "sfx/Collision.mp3")] static public var SndShipCollision:Class;		
		
		static public var ShipMask:uint = 0x0002;
		static public var HookMask:uint = 0x0004;
		static public var PersonMask:uint = 0x0008;
		static public var WallMask:uint = 0x0010;
		static public var RockMask:uint = 0x0012;
		
/*
		static public var Contact_person_free:String = new String("Person_Free");				//person free roaming
		static public var Contact_person_stick:String = new String("Person_Sticking");			//person just stuck by hook
		static public var Contact_person_flash:String = new String("Person_Flashing");			//person flashing and ready to combine
		static public var Contact_person_combine:String = new String("Person_Combined");		//person combined with another
		static public var Contact_person_smoke:String = new String("Person_Smoke");				//person died with smoke.
		static public var Contact_person_love:String = new String("Person_Love");				//person died with love.
		static public var Contact_person_lonelyDeath:String = new String("Person_lonelyDeath");	//person died after smoking
		static public var Contact_person_loveDeath:String = new String("Person_loveDeath");		//person dieg after hearts.
		static public var Contact_person_kill:String = new String("Person_Killed");				//remove person.
		static public var Contact_hook_free:String = new String("Hook_Free");
		static public var Contact_hook_stick:String = new String("Hook_Sticking");
		static public var Contact_player:String = new String("Player");
		static public var Contact_player_collision:String = new String("Player_Collision");		
		static public var Contact_boundary:String = new String("Boundary");		
		static public var Contact_asteroid:String = new String("Asteroid"); */
		
		
		static public var Contact_person_free:uint = 1;			//person free roaming
		static public var Contact_person_stick:uint = 2;		//person just stuck by hook
		static public var Contact_person_flash:uint = 3;		//person flashing and ready to combine
		static public var Contact_person_combine:uint = 4;		//person combined with another
		static public var Contact_person_kill:uint = 5;			//remove person once combined.
		static public var Contact_person_oldAge:uint = 6;		//remove person when they remain single and end flicker
		static public var Contact_person_grouped:uint = 7;		//person is appart of a group
		static public var Contact_hook_free:uint = 8;
		static public var Contact_hook_stick:uint = 9;
		static public var Contact_player:uint = 10;
		static public var Contact_player_collision:uint = 11;		
		static public var Contact_boundary:uint = 12;		
		static public var Contact_asteroid:uint = 13;
		
		static public var Type_None:uint = 0;
		static public var Type_Asteroid:uint = 1;
		static public var Type_Boundary:uint = 2;
		//static public var Type_Chain:uint = 3;
		static public var Type_Grouping:uint = 4;
		static public var Type_Hook:uint = 5;
		static public var Type_People:uint = 6;
		static public var Type_Ship:uint = 7;
		
		static public var State_None:uint = 0;
		
		static public var State_People_Free:uint = 1;
		static public var State_People_Stick:uint = 2;
		static public var State_People_Flash:uint = 3;
		static public var State_People_Combine:uint = 4;
		static public var State_People_Kill:uint = 5;
		static public var State_People_DieLonely:uint = 6;
		static public var State_People_Grouped:uint = 7;
		static public var State_People_DieLove:uint = 10;
		static public var State_People_Smoke:uint = 11;
		static public var State_People_Love:uint = 12;
		
		static public var State_Hook_Free:uint = 8;
		static public var State_Hook_Stick:uint = 9;
		
		static public var Event_None:uint = 0;
		static public var Event_People_MeetAnother:uint = 1;
		static public var Event_Ship_Collision:uint = 2;
		
		
		static public var LevelTimeLimit:Number = 60;
	}
	
}