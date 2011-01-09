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
		static public var Contact_asteroid:String = new String("Asteroid");
		
		static public var LevelTimeLimit:Number = 60;
	}
}