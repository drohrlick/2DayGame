package  
{
	import org.flixel.FlxSprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Line extends FlxSprite
	{
		protected var bmp:Bitmap;
        protected var p:Point;

        public function Line() {
            p = new Point(0, 0);
            //var s:Shape = new Shape();
            //s.graphics.lineStyle(1, 0xFF00FF);
            //s.graphics.moveTo(0, 0);
            //s.graphics.lineTo(20, 20);
            //bmp = new Bitmap(FlxG.createBitmap(40, 40, 0xFFFFFF)); 
            //bmp.bitmapData.draw(s);
        }

        //public override function render():void {
            //FlxG.buffer.copyPixels(
                    //bmp.bitmapData,
                    //bmp.bitmapData.rect,
                    //p, null, null, true);
        //}
		
	}

}