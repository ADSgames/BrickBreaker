package 
{
	/*
	 * Allan Legemaate
	 * Brick Breaker
	 * 25/01/16
	 * Bar!
	 */
	
	// Flixel library
	import org.flixel.*;
	
	public class bar extends FlxSprite 
	{
		// Images
		[Embed(source = "../assets/images/bar/bar.png")] 
		private var bar_img:Class;
		
		[Embed(source = "../assets/images/bar/bar_big.png")] 
		private var bar_big_img:Class;
		
		[Embed(source = "../assets/images/bar/bar_small.png")] 
		private var bar_small_img:Class;
		
		// Size var (-1 = small 0 = normal 1 = big)
		private var bar_size:int;
		
		// Create Ball
		public function bar( newX:int = 0, newY:int = 0):void {
			// Make flx sprite
			super(  newX, newY, bar_img);
			
			// Position and set immovable
			this.x -= this.width / 2;
			bar_size = 0;
			this.immovable = true;
		}
		
		
		// Update Ball
		override public function update():void {
			super.update();
			
			// Move the bar
			if( FlxG.mouse.x > 0 + this.width/2 && FlxG.mouse.x < 550 - this.width/2){
				this.x = FlxG.mouse.x - this.width/2;
			}
			else if ( FlxG.mouse.x < 0 + this.width / 2) {
				this.x = 0;
			}
			else if ( FlxG.mouse.x > 550 - this.width / 2) {
				this.x = 550 - this.width;
			}
		}
		
		// Set idle pos
		public function setSize( newPower:int):void {
			if ( newPower == 0) {
				super.loadGraphic( bar_img);
				bar_size = 0;
			}
			if ( (newPower == -1 && bar_size > -1) || (newPower == 1 && bar_size < 1)) {
				bar_size += newPower;
				
				if ( bar_size == -1)
					super.loadGraphic( bar_small_img);
				else if ( bar_size == 1)
					super.loadGraphic( bar_big_img);
				else
					super.loadGraphic( bar_img);
			}
		}
	}
}