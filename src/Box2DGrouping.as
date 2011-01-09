package
{
    import org.flixel.*;
 
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
 
    public class Box2DGrouping extends FlxGroup
    {	
        private var ratio:Number = 30;

		
        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
        public var _obj:b2Body;
		
		public var _fixture:b2Fixture;
		public var _fixtureCreated:Boolean = false;
 
        private var _radius:Number;
        private var _world:b2World;
 
        //Physics params default value
        public var _friction:Number = 0.8;
        public var _restitution:Number = 0.3;
        
 
        //Default angle
        public var _angle:Number = 0;
        //Default body type
        public var _type:uint = b2Body.b2_dynamicBody;

		public var _segmentLengthPerPerson:Number = 10;	// arms length in pixels
		public var _densityPerPerson:Number = 0.7;
		public var _peopleAdded:Boolean = false;
		
        public function Box2DGrouping(w:b2World):void
        {
            super();
            _world = w
			
			members = new Array();
			createBody();
		}
		
		override public function update():void
        {
			// cont update if theres nothing to draw
			if ( members.length > 0 )
			{
				recalcFixtureDef();
				
				var person:Box2DPeople;
				
				x = (_obj.GetPosition().x * ratio); // - _radius ;
				y = (_obj.GetPosition().y * ratio); // - _radius;
				angle = _obj.GetAngle() * (180 / Math.PI);

				if( members.length > 2 ) {
					var i:uint;
					var theta:Number = (Math.PI * 2) / members.length;
					
					var newTheta:Number;
					var newX:Number;
					var newY:Number
					
					// calc new positions for each 
					for ( i = 0; i < members.length; i++ )
					{
						newTheta = _obj.GetAngle() + (theta * i);
						newX = x + _radius * Math.cos( newTheta );
						newY = y + _radius * Math.sin( newTheta );
						
						person = members[i] as Box2DPeople;
						person._obj.SetPositionAndAngle( new b2Vec2(newX / 30, newY / 30), newTheta );
					}
				}
				
				else if ( members.length == 1 ) {
					person = members[0] as Box2DPeople;
					person._obj.SetPositionAndAngle( _obj.GetPosition(), _obj.GetAngle());
				}
				
				else if ( members.length == 2 ) {
					newTheta = (Math.PI / 2) + _obj.GetAngle();
					newX = x + 5 * Math.cos( newTheta );
					newY = y + 5 * Math.sin( newTheta );
					
					person = members[0] as Box2DPeople;
					person._obj.SetPositionAndAngle( new b2Vec2(newX / 30, newY / 30), _obj.GetAngle());
					
					newX = 2 * x - newX;
					newY = 2 * y - newY;
					person = members[1] as Box2DPeople;
					person._obj.SetPositionAndAngle( new b2Vec2(newX / 30, newY / 30), _obj.GetAngle());
				}
			}
            super.update();
        }
 
		public function createBody():void
        {
			// these values get update as people enter the group
            _fixDef = new b2FixtureDef();
            _fixDef.friction = _friction;
            _fixDef.restitution = _restitution;
            //_fixDef.density = _density;
            //_fixDef.shape = new b2CircleShape(_radius / ratio);
			
			_fixDef.filter.categoryBits = GameplayState.PersonMask;
			_fixDef.filter.maskBits = GameplayState.HookMask | GameplayState.ShipMask | GameplayState.PersonMask | GameplayState.WallMask;
 
            _bodyDef = new b2BodyDef();
            //_bodyDef.position.Set((x + (_radius)) / ratio, (y + (_radius/2)) / ratio);
            //_bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;
 
            _obj = _world.CreateBody(_bodyDef);
			_obj.SetActive(false);
			_obj.SetUserData( new ObjectUserData(GameLogic.Type_Grouping) );
			
			 //_obj.CreateFixture(_fixDef);
			 trace( true );
        }
		
		public function addPerson( person:Box2DPeople ):void
		{
			trace( members.length);
			// if first set angle and position to the added person
			if ( members.length <= 0 )
			{
				_obj.SetPositionAndAngle(person._obj.GetPosition(), person._obj.GetAngle());
			}
			
			person.play( "lovely" );
			person._obj.SetActive(false); // disable persons physics
			add(person);
			_peopleAdded = true;
		}
		
		
		private function recalcFixtureDef():void 
		{
			if ( !_peopleAdded ) return;
			
			_obj.SetActive(false);
			if ( _fixtureCreated )
				_obj.DestroyFixture( _fixture );
			_fixDef.density = _densityPerPerson * members.length;
			
			if ( members.length > 2 )
			{
				_radius = (_segmentLengthPerPerson * 0.5) / Math.sin( Math.PI / members.length );
				
			}
			else {
				_radius = _segmentLengthPerPerson * members.length * 0.6;
			}
			
			_fixDef.shape = new b2CircleShape(_radius / ratio);
			_fixture = _obj.CreateFixture( _fixDef );
			_fixtureCreated = true;
			_obj.SetActive( true );
			_peopleAdded = false;
			
			//trace(_radius);
		}
		
		// returns disabled person
		public function removePerson():Box2DPeople
		{
			var person:Box2DPeople = members.pop() as Box2DPeople;
			_peopleAdded = true;
			return person;
		}
    }
}
 