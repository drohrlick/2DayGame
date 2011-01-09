package
{
    import org.flixel.*;
 
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
 
    public class Box2DChain extends FlxGroup
    {
		[Embed(source = "sprites/links.png")] public var ImgLinks:Class;

        private var ratio:Number = 30;
 
        private var _world:b2World;
		
		public var _posOrigin:b2Vec2;
		public var _posDestiny:b2Vec2;
	
		public var _visible:Boolean = false;
		
		// chain variables
		private var _maxNumLinks:uint = 50;
		private var _numLinksActive:uint = 0;
 
        public function Box2DChain(w:b2World):void
        {
            super();
            _world = w
			
			createLinks();
			SetInvisible( true );
		}
		
		public function createLinks():void {
			var i:int;
			var s:FlxSprite;
			
			members = new Array();
			for ( i = 0; i < _maxNumLinks; i++ )
			{
				s = new FlxSprite();
				s.loadGraphic( ImgLinks, true, false, 6, 6 );
				add(s);
				s.visible = false;
				s.exists = false;
				s.active = false;
			}
		}
		
		public function SetPositions( origin:b2Vec2, destiny:b2Vec2 ):void
		{
			_posOrigin = origin;
			_posDestiny = destiny;
		}
 
		public function SetVisible():void
		{
			_visible = true;
			UpdateLinks();
		}
		
		/*override public function update():void
		{
			//UpdateLinks();
			super.update();
		}*/
		
		public function SetInvisible( force:Boolean = false ):void 
		{
			// _visible is only set false here
			if ( !_visible && !force ) return;
			
			
			_visible = false;
			var s:FlxSprite;
			var i:int;
			
			for ( i = 0; i < _numLinksActive && i < _maxNumLinks; i++ )
			{
				s = members[i] as FlxSprite;
				s.visible = false;
				s.exists = false;
				s.active = false;
			}
			
			_numLinksActive = 0;
		}
		
		public function UpdateLinks():void 
		{
			if ( !_visible ) return;
			
			// get the distance between the two positions
			var run:Number =_posOrigin.x - _posDestiny.x;
			var rise:Number = _posOrigin.y - _posDestiny.y;
			var dist:Number = Math.sqrt( (run * run) + (rise * rise) );
			
			if ( dist <= 0 ) return;
			
			var s:FlxSprite;
			var distIncrement:Number = 10 / dist;
			var runIncrement:Number = distIncrement * run;
			var riseIncrement:Number = distIncrement * rise;
			distIncrement = 10;
			//trace(distIncrement);
			
			var i:int = 0;
			for ( i = 0; i < _maxNumLinks; i++ )
			{
				if ( dist <= 0 )
					break;
					
				s = members[i] as FlxSprite;

				if ( !s.visible ) {
					s.visible = true;
					s.exists = true;
					s.active = true;
				}
				
				s.x = _posDestiny.x + (runIncrement * (i + 1)) - 3;
				s.y = _posDestiny.y + (riseIncrement * (i + 1)) - 3;
				dist -= distIncrement;
			}
			
			var oldI:uint = i;
			
			// disable any remaing active links
			if ( i < _numLinksActive )
			{
				for ( i; i < _numLinksActive && i < _maxNumLinks; i++ )
				{
					s = members[i] as FlxSprite;
					s.visible = false;
					s.exists = false;
					s.active = false;
				}
			}
			
			_numLinksActive = oldI;
		}
    }
}
 