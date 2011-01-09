package
{
    import org.flixel.*;
 
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
 
    public class Box2DAsteroid extends FlxSprite
    {
		[Embed(source = "sprites/asteroid.png")] public var Img:Class;	

        private var ratio:Number = 30;
 
        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
        public var _obj:b2Body;
 
        private var _world:b2World;
 
        //Physics params default value
        public var _friction:Number = 0.8;
        public var _restitution:Number = 0.3;
        public var _density:Number = 0.7;
 
        //Default angle
        public var _angle:Number = 0;
        //Default body type
        public var _type:uint = b2Body.b2_dynamicBody;
 
		private var _maxVelocity:int = 2;
 
        public function Box2DAsteroid(id:int, X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void
        {
            super(X,Y);
 			
            width = Width;
            height = Height;
            _world = w
			
			createBody(id);
			
			loadGraphic(Img, false, false, 32, 32);
		}
 
        public function createBody(id:int):void
        {            
            var boxShape:b2PolygonShape = new b2PolygonShape();
            boxShape.SetAsBox((width/2) / ratio, (height/2) /ratio);
 
            _fixDef = new b2FixtureDef();
            _fixDef.density = _density;
            _fixDef.restitution = _restitution;
            _fixDef.friction = _friction;                        
            _fixDef.shape = boxShape;
			_fixDef.filter.categoryBits = GameLogic.RockMask;
			_fixDef.filter.maskBits = GameLogic.HookMask | GameLogic.ShipMask | GameLogic.PersonMask | GameLogic.RockMask | GameLogic.WallMask;
 
            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;
 
            _obj = _world.CreateBody(_bodyDef);
            _obj.CreateFixture(_fixDef);
			_obj.SetAngle(FlxU.random() * 360);
			_obj.SetAngularVelocity(FlxU.random() * 8 - 4);
			_obj.SetUserData(GameLogic.Contact_asteroid);			
			var randX:int;
			var randY:int;
			
			if(FlxU.random() < 0.5)		
				randX = FlxU.random() * _maxVelocity;
			else
				randX = FlxU.random() * -_maxVelocity;
						
			if (FlxU.random() < 0.5)
				randY = FlxU.random() * _maxVelocity;
			else
				randY = FlxU.random() * -_maxVelocity;
				
			_obj.SetLinearVelocity(new b2Vec2(randX, randY));
        }
		
		override public function update():void
        {
            x = (_obj.GetPosition().x * ratio) - width/2 ;
            y = (_obj.GetPosition().y * ratio) - height/2;
            angle = _obj.GetAngle() * (180 / Math.PI);
            			
			super.update();
        }
    }
}
 