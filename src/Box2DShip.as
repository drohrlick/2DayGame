package
{
    import org.flixel.*;
 
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
 
    public class Box2DShip extends FlxSprite
    {
		[Embed(source = "sprites/shipA_8frames90.png")] public var Img:Class;	

        private var ratio:Number = 30;
 
        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
        public var _obj:b2Body;
		public var _hook1:Box2DHook;
		public var _chain1:Box2DChain;
 
        private var _world:b2World;
 
        //Physics params default value

        public var _friction:Number = 0.2;
        public var _restitution:Number = 0.3;
        public var _density:Number = 0.7;
 
        //Default angle
        public var _angle:Number = 0;
        //Default body type
        public var _type:uint = b2Body.b2_dynamicBody;
 
		private var _maxRotVelocity:int = 5;
		private var _maxThrust:Number = 0.5;
		private var _thrust:b2Vec2;
		private var _rotation:int;
 
        public function Box2DShip(X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void
        {
            super(X, Y);

            width = Width;
            height = Height;
            _world = w
			
			_thrust = new b2Vec2(0, 0);
			_rotation = 0;
			
			_hook1 = new Box2DHook(0, 0, 8, 2, _world);
			_hook1.createBody();
			_hook1.loadGraphic(_hook1.ImgHook, false, false, 8, 2);
			
			_chain1 = new Box2DChain( _world );
			
		}
 
		        public function createBody():void
        {            
            var boxShape:b2PolygonShape = new b2PolygonShape();
            boxShape.SetAsBox((width/2) / ratio, (height/2) /ratio);
 
            _fixDef = new b2FixtureDef();
            _fixDef.density = _density;
            _fixDef.restitution = _restitution;
            _fixDef.friction = _friction;                        
            _fixDef.shape = boxShape;
			_fixDef.filter.categoryBits = GameplayState.ShipMask;
			_fixDef.filter.maskBits = GameplayState.RockMask | GameplayState.WallMask;
 
            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;
 
            _obj = _world.CreateBody(_bodyDef);
            _obj.CreateFixture(_fixDef);	
			_obj.SetUserData(GameplayState.Contact_player);
        }
		
        override public function update():void
        {

            x = (_obj.GetPosition().x * ratio) - width/2 ;
            y = (_obj.GetPosition().y * ratio) - height/2;

			//Handle input transforms
			HandleTransforms();
						
			//handle rotations from input
			HandleRotations();
						
			//update hook
			UpdateHook();
			
			if (!_hook1.AttachedToShip) 
			{
				_chain1.SetPositions( new b2Vec2(x + 16, y + 16), new b2Vec2(_hook1.x, _hook1.y) );
				//_chain1.UpdateLinks();
				_chain1.SetVisible();
			}
			else _chain1.SetInvisible();
            
			super.update();
        }
		
		private function HandleTransforms():void
		{
			var _pos:b2Vec2;

			_thrust.SetZero();
			
			if (FlxG.keys.W)
			{
				_angle = _obj.GetAngle();
				_pos = _obj.GetPosition();
				_thrust.x = (Math.cos(_angle) * _maxThrust) - (Math.sin(_angle) * 0) + 0;
				_thrust.y = (Math.sin(_angle) * _maxThrust) - (Math.cos(_angle) * 0) + 0;
			}
			if (FlxG.keys.S)
			{
				_angle = _obj.GetAngle();
				_pos = _obj.GetPosition();
				_thrust.x = (Math.cos(_angle) * -_maxThrust) - (Math.sin(_angle) * 0) + 0;
				_thrust.y = (Math.sin(_angle) * -_maxThrust) - (Math.cos(_angle) * 0) + 0;		
			}
			//p'x = cos(theta) * (px-ox) - sin(theta) * (py-oy) + ox
			//p'y = sin(theta) * (px-ox) + cos(theta) * (py-oy) + oy
			
			_obj.ApplyImpulse(_thrust, _obj.GetPosition());			
			_obj.ApplyFrictionToVelocity(_friction);
		}
		
		private function HandleRotations():void
		{
			var _angle:Number;

			_rotation = 0;
			if (FlxG.keys.A)
				_rotation = -_maxRotVelocity;
			if (FlxG.keys.D)
				_rotation = _maxRotVelocity;
			_obj.SetAngularVelocity(_rotation);
			
            angle = _obj.GetAngle() * (180 / Math.PI);
			
			if (angle < 0)
			{
				angle += 360;
				_obj.SetAngle( angle / 180 * Math.PI );
			}
			if (angle >= 360)
				angle %= 360;
							
			frame = (angle + 22.5) / 45;
						
			//update hook
			//UpdateHook();
            
			//super.update();
        }
		
		private function UpdateHook():void
		{	
			if (_hook1.AttachedToShip)
			{	
				var _pos:b2Vec2 = _obj.GetPosition();
				_angle = _obj.GetAngle();
				_hook1.UpdateAttachedHook(_pos, _angle);
			}
			
			if (FlxG.mouse.justPressed())
				_hook1.Shoot(x + 16, y + 16);
		}
    }
}