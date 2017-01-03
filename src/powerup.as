package 
{
	/*
	 * Allan Legemaate
	 * Brick Breaker
	 * 25/01/16
	 * Powerup!
	 */
	
	// Flixel library
	import org.flixel.*;
	
	public class powerup extends FlxSprite 
	{
		// Images
		[Embed(source = "../assets/images/powerup/ball_slow.png")] 
		private var ball_slow:Class;
		
		[Embed(source = "../assets/images/powerup/ball_fast.png")] 
		private var ball_fast:Class;
		
		[Embed(source = "../assets/images/powerup/ball_multi.png")] 
		private var ball_multi:Class;
		
		[Embed(source = "../assets/images/powerup/bar_big.png")] 
		private var bar_big:Class;
		
		[Embed(source = "../assets/images/powerup/bar_small.png")] 
		private var bar_small:Class;
		
		[Embed(source = "../assets/images/powerup/error.png")] 
		private var error:Class;
		
		// Create Ball
		public function powerup( newX:int = 0, newY:int = 0, newType:int = 0):void {
			// Make flx sprite
			super(  newX, newY, ball_slow);
			
			// Size var (0 = fire 1 = multi 2 = big 3 = small)
			this.ID = newType;
			
			// Fall
			this.velocity.y = 60;
			
			// Set graphic
			if ( this.ID == 0)
				this.loadGraphic( ball_slow);
			else if ( this.ID == 1)
				this.loadGraphic( ball_fast);
			else if ( this.ID == 2)
				this.loadGraphic( ball_multi);
			else if ( this.ID == 3)
				this.loadGraphic( bar_big);
			else if ( this.ID == 4)
				this.loadGraphic( bar_small);
			else
				this.loadGraphic( error);
		}
		
		
		// Update Ball
		override public function update():void {
			super.update();
		}
		
		// Type
		public function getType():Number {
			return this.ID;
		}
	}
}