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
		override public function BeginContact(contact:b2Contact):void 
		{
			// getting the fixtures that collided
			var fixtureA:b2Fixture=contact.GetFixtureA();
			var fixtureB:b2Fixture=contact.GetFixtureB();
			// if the fixture is a sensor, mark the parent body to be removed
			if (fixtureB.IsSensor()) {
				fixtureB.GetBody().SetUserData("remove");
			}
			if (fixtureA.IsSensor()) {
				fixtureA.GetBody().SetUserData("remove");
			}
		}
	}
}