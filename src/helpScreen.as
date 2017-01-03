package 
{
	/*
	 * Allan Legemaate
	 * Brick Breaker
	 * 22/01/16
	 * Help Screen
	 */
	
	// Flixel Library
	import org.flixel.*;
	
	public class helpScreen extends FlxState {
		// Load assets
		[Embed(source = "../assets/images/back.png")] 
		private var background_img:Class;
		
		[Embed(source = "../assets/images/help.png")] 
		private var foreground_img:Class;
		
		[Embed(source = "../assets/images/lava.png")] 
		private var lava_img:Class;
		
		[Embed(source = "../assets/images/button_back.png")] 
		private var button_img:Class;
		
		// Sprites
		private var background:FlxSprite;
		private var foreground:FlxSprite;
		private var lava:FlxSprite;
		private var button:FlxSprite;
		
		// Stuff to call on init
		override public function create():void{
			// Show mouse
			FlxG.mouse.show();
			
			// Load sprites
			// Background
			background = new FlxSprite( 0, 0, background_img);
			this.add(background);
			
			// Foreground
			foreground = new FlxSprite( 0, 0, foreground_img);
			this.add(foreground);
			
			// Lava
			lava = new FlxSprite( 0, 380, lava_img);
			this.add(lava);
			
			// Start Button
			button = new FlxSprite( 10, FlxG.height - 10, button_img);
			button.y -= button.height;
			this.add(button);
		}
 
		// Update game
		override public function update():void{
			super.update();
 
			if ( FlxG.mouse.justPressed()) {
				if ( FlxG.mouse.x >= button.x && FlxG.mouse.x <= button.x + button.width && 
					 FlxG.mouse.y >= button.y && FlxG.mouse.y <= button.y + button.height )
					FlxG.switchState(new menuScreen());
			}
		}
 
		// Constructor
		public function helpScreen(){
			super();
		}
	}
}