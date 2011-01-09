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
			/*// getting the fixtures that collided
			var fixtureA:b2Fixture=contact.GetFixtureA();
			var fixtureB:b2Fixture=contact.GetFixtureB();
			// variable to handle bodies y position
			//var person_position:b2Vec2;
			
			if ((fixtureA.GetBody().GetUserData() == GameLogic.Contact_person_free && fixtureB.GetBody().GetUserData() == GameLogic.Contact_hook_free) ||
				(fixtureA.GetBody().GetUserData() == GameLogic.Contact_hook_free && fixtureB.GetBody().GetUserData() == GameLogic.Contact_person_free))
			{
				//Handle hook and person hit.
				switch(fixtureA.GetBody().GetUserData())
				{
					case GameLogic.Contact_person_free:
						//person_position = fixtureA.GetBody().GetPosition();
							
						fixtureA.GetBody().SetUserData(GameLogic.Contact_person_stick);
						fixtureB.GetBody().SetUserData(GameLogic.Contact_hook_stick);
						
						//reverseImpulse = fixtureB.GetBody().GetLinearVelocity().GetNegative();
						//reverseImpulse.x *= impulseScale;
						//reverseImpulse.y *= impulseScale;						
						//fixtureA.GetBody().ApplyImpulse( reverseImpulse, fixtureA.GetBody().GetPosition());
						
						break;
					case GameLogic.Contact_hook_free:
						//person_position = fixtureB.GetBody().GetPosition();
						
						fixtureA.GetBody().SetUserData(GameLogic.Contact_hook_stick);
						fixtureB.GetBody().SetUserData(GameLogic.Contact_person_stick);
						
						//reverseImpulse = fixtureA.GetBody().GetLinearVelocity().GetNegative();
						//reverseImpulse.x *= impulseScale;
						//reverseImpulse.y *= impulseScale;
						//fixtureB.GetBody().ApplyImpulse( reverseImpulse, fixtureB.GetBody().GetPosition());

						break;
				}
			}
			if (fixtureA.GetBody().GetUserData() == GameLogic.Contact_person_flash && fixtureB.GetBody().GetUserData() == GameLogic.Contact_person_flash)
			{
				//Handle flash person to flash person hit
				fixtureA.GetBody().SetUserData(GameLogic.Contact_person_combine);
				//fixtureA.GetBody().ApplyTorque(2);
				fixtureB.GetBody().SetUserData(GameLogic.Contact_person_combine);
				//fixtureB.GetBody().ApplyTorque(2);
				//combineOffset = fixtureA.GetBody().GetPosition();
				//combineOffset.x += 5;
				//fixtureB.GetBody().SetPosition(combineOffset);
			}
			
			if (fixtureA.GetBody().GetUserData() == GameLogic.Contact_player)
				fixtureA.GetBody().SetUserData(GameLogic.Contact_player_collision);
			if (fixtureB.GetBody().GetUserData() == GameLogic.Contact_player)
				fixtureB.GetBody().SetUserData(GameLogic.Contact_player_collision);*/
				
			/*if ( contact.GetFixtureA().GetUserData() == null )
				trace("a");
			else if( contact.GetFixtureB().GetUserData() == null ) 
				trace("b");*/
				
			
			// getting the fixtures that collided
			var dataA:ObjectUserData = contact.GetFixtureA().GetBody().GetUserData() as ObjectUserData;
			var dataB:ObjectUserData = contact.GetFixtureB().GetBody().GetUserData() as ObjectUserData;
			
			if ( dataA == null || dataB == null ) return;
			
			
			if ((dataA.state == GameLogic.State_People_Free && dataB.state == GameLogic.State_Hook_Free ) ||
				(dataA.state == GameLogic.State_Hook_Free && dataB.state == GameLogic.State_People_Free))
			{
				//Handle hook and person hit.
				switch(dataA.state)
				{
					case GameLogic.State_People_Free:		
						dataA.state = GameLogic.State_People_Stick;
						dataB.state = GameLogic.State_Hook_Stick;
						break;
						
					case GameLogic.State_Hook_Free:				
						dataA.state = GameLogic.State_Hook_Stick;
						dataB.state = GameLogic.State_People_Stick;
						break;
				}
			}
			
			else if (dataA.state == GameLogic.State_People_Flash && dataB.state == GameLogic.State_People_Flash)
			{
				dataB.state = dataA.state = GameLogic.State_People_Combine;
			}
			/*
			if (fixtureA.GetBody().GetUserData() == GameLogic.Contact_player)
				fixtureA.GetBody().SetUserData(GameLogic.Contact_player_collision);
				
			if (fixtureB.GetBody().GetUserData() == GameLogic.Contact_player)
				fixtureB.GetBody().SetUserData(GameLogic.Contact_player_collision);*/

		}
	}
}