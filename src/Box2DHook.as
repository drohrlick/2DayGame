package
{
    import org.flixel.*;
 
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
 
    public class Box2DHook extends FlxSprite
    {
		[Embed(source = "sprites/hook.png")] public var Img:Class;	

        private var ratio:Number = 30;
 
        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
        public var _obj:b2Body;
 
        private var _world:b2World;
 
        //Physics params default value
        public var _friction:Number = 0.8;
        public var _restitution:Number = 0.3;
        public var _density:Number = 0.7;
		
		public var _posX:Number;
		public var _posY:Number;
		
        //Default angle
        public var _angle:Number = 0;
        //Default body type
        public var _type:uint = b2Body.b2_dynamicBody;
		
		private var _thrust:b2Vec2; 
		private var _maxVelocity:int = 2;
		
		public var AttactchedToShip:Boolean = true;
 
        public function Box2DHook(X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void
        {
            super(X, Y);
						
            width = Width;
            height = Height;
            _world = w
			
			_thrust = new b2Vec2(0, 0);
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
 			_fixDef.filter.categoryBits = GameplayState.HookMask;
			_fixDef.filter.maskBits = GameplayState.RockMask;

            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;
 
            _obj = _world.CreateBody(_bodyDef);
            _obj.CreateFixture(_fixDef);
        }
 
        override public function update():void
        {
			if (AttactchedToShip)
			{
				x = (_posX * ratio) - width/2 ;
				y = (_posY * ratio) - height/2;
			}
			else 
			{
				x = (_obj.GetPosition().x * ratio) - width/2 ;
				y = (_obj.GetPosition().y * ratio) - height / 2;
			}

            angle = _angle * (180 / Math.PI);
            
			super.update();
        }
		
		public function UpdateHook(pos:b2Vec2, angle:Number):void
		{
			_posX = pos.x;
			_posY = pos.y;
			_angle = angle;
		}
 
		public function Shoot():void
		{
			_obj.SetPosition(new b2Vec2(_posX, _posY));

			_thrust.x = 0; _thrust.y = 0;
			_obj.ApplyImpulse(_thrust, _obj.GetPosition());
			
			_angle = _obj.GetAngle();
			_thrust.x = (Math.cos(_angle) * 0.05) - (Math.sin(_angle) * 0) + 0;
			_thrust.y = (Math.sin(_angle) * 0.05) - (Math.cos(_angle) * 0) + 0;		
						
			AttactchedToShip = false;
			
			_obj.ApplyImpulse(_thrust, _obj.GetPosition());	

		}
    }
}
 