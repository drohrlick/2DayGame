package {
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
		private var impulseScale:Number = 0.05;
		
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void 
		{
			// getting the fixtures that collided
			var fixtureA:b2Fixture=contact.GetFixtureA();
			var fixtureB:b2Fixture=contact.GetFixtureB();
			// variable to handle bodies y position
			//var person_position:b2Vec2;
			
			if ((fixtureA.GetBody().GetUserData() == GameplayState.Contact_person_free && fixtureB.GetBody().GetUserData() == GameplayState.Contact_hook_free) ||
				(fixtureA.GetBody().GetUserData()== GameplayState.Contact_hook_free && fixtureB.GetBody().GetUserData() == GameplayState.Contact_person_free))
				{
					switch(fixtureA.GetBody().GetUserData())
					{
						case GameplayState.Contact_person_free:
							//person_position = fixtureA.GetBody().GetPosition();
							
							fixtureA.GetBody().SetUserData(GameplayState.Contact_person_stick);
							fixtureB.GetBody().SetUserData(GameplayState.Contact_hook_stick);
							
							reverseImpulse = fixtureB.GetBody().GetLinearVelocity().GetNegative();
							reverseImpulse.x *= impulseScale;
							reverseImpulse.y *= impulseScale;
							fixtureA.GetBody().ApplyImpulse( reverseImpulse, fixtureA.GetBody().GetPosition());
							break;
						case GameplayState.Contact_hook_free:
							//person_position = fixtureB.GetBody().GetPosition();
						
							fixtureA.GetBody().SetUserData(GameplayState.Contact_hook_stick);
							fixtureB.GetBody().SetUserData(GameplayState.Contact_person_stick);
							
							reverseImpulse = fixtureA.GetBody().GetLinearVelocity().GetNegative();
							reverseImpulse.x *= impulseScale;
							reverseImpulse.y *= impulseScale;
							fixtureB.GetBody().ApplyImpulse( reverseImpulse, fixtureB.GetBody().GetPosition());

							break;
					}
				}
			// checking if the collision bodies are the ones marked as "middle" and "player"
			//if ((fixtureA.GetBody().GetUserData() == "middle" && fixtureB.GetBody().GetUserData() == "player") || 
				//(fixtureA.GetBody().GetUserData() == "player" && fixtureB.GetBody().GetUserData() == "middle")) 
			//{
				// determining if the fixtureA represents the platform ("middle") or the player
				//switch (fixtureA.GetBody().GetUserData()) 
				//{
					//case "middle" :
						// determining y positions
						//player_y_position=fixtureB.GetBody().GetPosition().y*30;
						//platform_y_position=fixtureA.GetBody().GetPosition().y*30;
						//break;
					//case "player" :
						// determining y positions
						//player_y_position=fixtureA.GetBody().GetPosition().y*30;
						//platform_y_position=fixtureB.GetBody().GetPosition().y*30;
						//break;
				//}
				// checking distance between bodies
				//var distance = player_y_position-platform_y_position;
				// if the distance is greater than player radius + half of the platform height...
				//if (distance>-14.5) {
					// don't manage the contact
					//contact.SetEnabled(false);
				//}
			//}
		}
	}
}