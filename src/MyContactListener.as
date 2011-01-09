package {
	import org.flixel.*;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	
	public class MyContactListener extends b2ContactListener 
	{
		//override public function BeginContact(contact:b2Contact):void 
		//{
			// getting the fixtures that collided
			//var fixtureA:b2Fixture=contact.GetFixtureA();
			//var fixtureB:b2Fixture=contact.GetFixtureB();
			// if the fixture is a sensor, mark the parent body to be removed
			//if (fixtureB.IsSensor()) {
				//fixtureB.GetBody().SetUserData("remove");
			//}
			//if (fixtureA.IsSensor()) {
				//fixtureA.GetBody().SetUserData("remove");
			//}
		//}
		private var reverseImpulse:b2Vec2;
		private var impulseScale:Number = 0.02;
		private var combineOffset:b2Vec2 = new b2Vec2(2, 0);
		private var filter:b2FilterData;
		
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void 
		{
			// getting the fixtures that collided
			var fixtureA:b2Fixture=contact.GetFixtureA();
			var fixtureB:b2Fixture=contact.GetFixtureB();
			// variable to handle bodies y position
			//var person_position:b2Vec2;
			
			if ((fixtureA.GetBody().GetUserData() == GameplayState.Contact_person_free && fixtureB.GetBody().GetUserData() == GameplayState.Contact_hook_free) ||
				(fixtureA.GetBody().GetUserData() == GameplayState.Contact_hook_free && fixtureB.GetBody().GetUserData() == GameplayState.Contact_person_free))
			{
				//Handle hook and person hit.
				switch(fixtureA.GetBody().GetUserData())
				{
					case GameplayState.Contact_person_free:
						//person_position = fixtureA.GetBody().GetPosition();
							
						fixtureA.GetBody().SetUserData(GameplayState.Contact_person_stick);
						fixtureB.GetBody().SetUserData(GameplayState.Contact_hook_stick);
						
						//reverseImpulse = fixtureB.GetBody().GetLinearVelocity().GetNegative();
						//reverseImpulse.x *= impulseScale;
						//reverseImpulse.y *= impulseScale;						
						//fixtureA.GetBody().ApplyImpulse( reverseImpulse, fixtureA.GetBody().GetPosition());
						
						break;
					case GameplayState.Contact_hook_free:
						//person_position = fixtureB.GetBody().GetPosition();
						
						fixtureA.GetBody().SetUserData(GameplayState.Contact_hook_stick);
						fixtureB.GetBody().SetUserData(GameplayState.Contact_person_stick);
						
						//reverseImpulse = fixtureA.GetBody().GetLinearVelocity().GetNegative();
						//reverseImpulse.x *= impulseScale;
						//reverseImpulse.y *= impulseScale;
						//fixtureB.GetBody().ApplyImpulse( reverseImpulse, fixtureB.GetBody().GetPosition());

						break;
				}
			}
			if (fixtureA.GetBody().GetUserData() == GameplayState.Contact_person_flash && fixtureB.GetBody().GetUserData() == GameplayState.Contact_person_flash)
			{
				//Handle flash person to flash person hit
				fixtureA.GetBody().SetUserData(GameplayState.Contact_person_combine);
				//fixtureA.GetBody().ApplyTorque(2);
				fixtureB.GetBody().SetUserData(GameplayState.Contact_person_combine);
				//fixtureB.GetBody().ApplyTorque(2);
				//combineOffset = fixtureA.GetBody().GetPosition();
				//combineOffset.x += 5;
				//fixtureB.GetBody().SetPosition(combineOffset);
			}
			
			if (fixtureA.GetBody().GetUserData() == GameplayState.Contact_player)
				fixtureA.GetBody().SetUserData(GameplayState.Contact_player_collision);
			if (fixtureB.GetBody().GetUserData() == GameplayState.Contact_player)
				fixtureB.GetBody().SetUserData(GameplayState.Contact_player_collision);

		}
	}
}