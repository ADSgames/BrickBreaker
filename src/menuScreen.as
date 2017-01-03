package 
{
	/*
	 * Allan Legemaate
	 * Brick Breaker
	 * 22/01/16
	 * Menu
	 */
	
	// Flixel Library
	import org.flixel.*;
	
	public class menuScreen extends FlxState {
		// Load assets
		[Embed(source = "../assets/images/back.png")] 
		private var background_img:Class;
		
		[Embed(source = "../assets/images/lava.png")] 
		private var lava_img:Class;
		
		[Embed(source = "../assets/images/button_play.png")] 
		private var button_img:Class;
		
		[Embed(source = "../assets/images/button_help.png")] 
		private var button_help_img:Class;
		
		[Embed(source = "../assets/images/title.png")] 
		private var title_image:Class;
		
		// Sprites
		private var background:FlxSprite;
		private var lava:FlxSprite;
		private var button:FlxSprite;
		private var button_help:FlxSprite;
		private var title:FlxSprite;
		
		// Stuff to call on init
		override public function create():void{
			// Show mouse
			FlxG.mouse.show();
			
			// Load sprites
			// Background
			background = new FlxSprite( 0, 0, background_img);
			this.add(background);
			
			title = new FlxSprite( FlxG.width / 2, 25, title_image);
			title.x -= title.width / 2;
			this.add(title);
			
			// Lava
			lava = new FlxSprite( 0, 380, lava_img);
			this.add(lava);
			
			// Start Button
			button = new FlxSprite( FlxG.width / 2, 160, button_img);
			button.x -= button.width / 2;
			this.add(button);
			
			// Help Button
			button_help = new FlxSprite( FlxG.width / 2, 250, button_help_img);
			button_help.x -= button_help.width / 2;
			this.add(button_help);
		}
 
		// Update game
		override public function update():void{
			super.update();
 
			if ( FlxG.mouse.justPressed()) {
				if ( FlxG.mouse.x >= button.x && FlxG.mouse.x <= button.x + button.width && 
					 FlxG.mouse.y >= button.y && FlxG.mouse.y <= button.y + button.height )
					FlxG.switchState(new level1());

				else if ( FlxG.mouse.x >= button_help.x && FlxG.mouse.x <= button_help.x + button_help.width && 
					 FlxG.mouse.y >= button_help.y && FlxG.mouse.y <= button_help.y + button_help.height )
					FlxG.switchState(new helpScreen());
			}
		}
 
		// Constructor
		public function menuScreen(){
			super();
		}
	}
}