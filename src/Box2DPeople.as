package
{
    import org.flixel.*;
 
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
 
    public class Box2DPeople extends FlxSprite
    {
		[Embed(source = "sprites/peopleM16deaths.png")] public var ImgM:Class;	
		[Embed(source = "sprites/peopleW16deaths.png")] public var ImgW:Class;	
        
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
		public var _sex:Boolean;
		
		private var _maxVelocity:int = 2;
		private var _flashLimit:int = 20;
		private var _deathFrames:int = 0;
		private var _deathFrameLimit:int = 30;
		
		public var _group:Box2DGrouping = null;
		
        public function Box2DPeople(id:int, X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void
        {
            super(X,Y);
 			
            width = Width;
            height = Height;
            _world = w
		}
 
        public function createBodyGameplay(id:int):void
        {            
			if (FlxU.random() < 0.5 )
			{
				loadGraphic(ImgM, false, false, 16, 16 );
				_sex = true;
			}
			else
			{
				loadGraphic(ImgW, false, false, 16, 16 );
				_sex = false;
			}
				
			addAnimation( "normal", [0], 0 );
			addAnimation( "lovely", [0, 1, 2, 3, 4], 5);
			addAnimation( "smoke",  [5, 6, 7, 8, 9], 5);
			addAnimation( "love",   [10, 11, 12, 13, 14], 5);
			
            var boxShape:b2PolygonShape = new b2PolygonShape();
            boxShape.SetAsBox((width/2) / ratio, (height/2) /ratio);
 
            _fixDef = new b2FixtureDef();
            _fixDef.density = _density;
            _fixDef.restitution = _restitution;
            _fixDef.friction = _friction;                        
            _fixDef.shape = boxShape;
			_fixDef.filter.categoryBits = GameLogic.PersonMask;
			_fixDef.filter.maskBits = GameLogic.HookMask | GameLogic.ShipMask | GameLogic.PersonMask | GameLogic.WallMask;
			
            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;
 
            _obj = _world.CreateBody(_bodyDef);
            _obj.CreateFixture(_fixDef);
			_obj.SetAngle(FlxU.random() * 360);
			_obj.SetAngularVelocity(FlxU.random() * 8 - 4);
			_obj.SetUserData( new ObjectUserData(GameLogic.Type_People, GameLogic.State_People_Free) );
			(_obj.GetUserData() as ObjectUserData).event_data1 = id;
			
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
		
		public function createBodyTutorial(id:int):void
        {            
			if (FlxU.random() < 0.5 )
				loadGraphic(ImgM, false, false, 16, 16 );
			else
				loadGraphic(ImgW, false, false, 16, 16 );
				
			addAnimation( "normal", [0], 0 );
			addAnimation( "lovely", [0, 1, 2, 3, 4], 5);
			
            var boxShape:b2PolygonShape = new b2PolygonShape();
            boxShape.SetAsBox((width/2) / ratio, (height/2) /ratio);
 
            _fixDef = new b2FixtureDef();
            _fixDef.density = _density;
            _fixDef.restitution = _restitution;
            _fixDef.friction = _friction;                        
            _fixDef.shape = boxShape;
			_fixDef.filter.categoryBits = GameLogic.PersonMask;
			_fixDef.filter.maskBits = GameLogic.HookMask | GameLogic.ShipMask | GameLogic.PersonMask | GameLogic.WallMask;
			
            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;
 
            _obj = _world.CreateBody(_bodyDef);
            _obj.CreateFixture(_fixDef);
			_obj.SetAngle(0);
			_obj.SetAngularVelocity(0);
			//_obj.SetUserData(GameLogic.Contact_person_free);
			_obj.SetUserData( new ObjectUserData(GameLogic.Type_People, GameLogic.State_People_Free));
			(_obj.GetUserData() as ObjectUserData).event_data1 = id;
			_obj.SetLinearVelocity(new b2Vec2(0, 0));
        }
		
		public function updateTutorial():void
		{
			//if (_obj.GetUserData() == GameLogic.Contact_person_stick)
			if( (_obj.GetUserData() as ObjectUserData).state == GameLogic.State_People_Stick)
			{
				flicker(30);
				//_obj.SetUserData(GameLogic.Contact_person_flash);
				(_obj.GetUserData() as ObjectUserData).state = GameLogic.State_People_Stick;
				play( "lovely" );
			}	
			
			super.update();
		}
		
		override public function update():void
        {
			var data:ObjectUserData = (_obj.GetUserData() as ObjectUserData);
			
			if(  data.state == GameLogic.State_People_Stick )
			{
				flicker(_flashLimit);
				 data.state = GameLogic.Contact_person_flash;
				play( "lovely" );
			}	
			else if ( data.state == GameLogic.State_People_Flash && !flickering())	
			{
				 data.state = GameLogic.State_People_Smoke;
				play("smoke");
			}			
			else if ( data.state == GameLogic.State_People_Smoke)
			{
				_deathFrames++;
				if (_deathFrames >= _deathFrameLimit)
				{	
					//person dies of old age
					 data.state = GameLogic.State_People_DieLonely;
					play( "smoke" );
					_deathFrames = 0;
				}
			}
			else if ( data.state == GameLogic.State_People_Combine)
			{
				data.state = GameLogic.State_People_Love;
				play("love");
			}
			else if ( data.state == GameLogic.State_People_Love)
			{
				_deathFrames++;
				if (_deathFrames >= _deathFrameLimit)
				{
					play( "love" );
					//person dies happy
					 data.state = GameLogic.State_People_DieLove;
					_deathFrames = 0;
				}
			}
			else if( data.state == GameLogic.State_People_Kill )
			{
				kill();
				play( "love" );
			}
			
			x = (_obj.GetPosition().x * ratio) - width/2 ;
			y = (_obj.GetPosition().y * ratio) - height/2;
			angle = _obj.GetAngle() * (180 / Math.PI);
			
			super.update();
        }
		
		override public function kill():void
		{
			FlxG.play(GameLogic.SndHookup);
			this.visible = false;
			this.destroy();
			super.kill();
		}
    }
}
 