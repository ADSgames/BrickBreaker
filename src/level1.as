package{
	/*
	 * Allan Legemaate
	 * The main level
	 * 22/01/16
	 * Brick Breaker
	 */
	
	// Flixel libray
	import mx.core.FlexSprite;
	import org.flixel.*;
	
	// Level 1
	public class level1 extends FlxState {
		/********************
		 * Load all images
		 *******************/
		[Embed(source = "../assets/images/back.png")] 
		private var background_img:Class;
		
		// Lava stuff
		[Embed(source = "../assets/images/lava_bubble.png")] 
		private var lava_bubble:Class;
	
		[Embed(source = "../assets/images/lava.png")] 
		private var lava_img:Class;
		
		// Bricks
		[Embed(source = "../assets/images/bricks/blue_1.png")] 
		private var brick_blue_1_img:Class;
		
		[Embed(source = "../assets/images/bricks/brown_1.png")] 
		private var brick_brown_1_img:Class;
		
		[Embed(source = "../assets/images/bricks/red_1.png")] 
		private var brick_red_1_img:Class;
		
		[Embed(source = "../assets/images/bricks/yellow_1.png")] 
		private var brick_yellow_1_img:Class;
		
		[Embed(source = "../assets/images/bricks/white_1.png")] 
		private var brick_white_1:Class;
		
		[Embed(source = "../assets/images/bricks/particles_blue.png")] 
		private var particles_blue:Class;
		
		[Embed(source = "../assets/images/bricks/particles_brown.png")] 
		private var particles_brown:Class;
		
		[Embed(source = "../assets/images/bricks/particles_red.png")] 
		private var particles_red:Class;
		
		[Embed(source = "../assets/images/bricks/particles_yellow.png")] 
		private var particles_yellow:Class;
		
		[Embed(source = "../assets/images/bricks/particles_question.png")] 
		private var particles_question:Class;
		
		
		[Embed(source = "../assets/images/info_bar.png")] 
		private var info_bar_1_image:Class;
		
		[Embed(source = "../assets/images/info_bar.png")] 
		private var info_bar_2_image:Class;
		
		// Groups
		private var bricks:FlxGroup;
		private var brick_emitters:FlxGroup;
		private var balls:FlxGroup;
		private var powerups:FlxGroup;
		
		// Debug text
		private var debugText:FlxText;
		
		/**********
		 * Sounds
		 *********/
		[Embed(source = "../assets/sounds/dirt.mp3")] 
		private var sfx_dirt:Class;
		
		[Embed(source = "../assets/sounds/explode.mp3")] 
		private var sfx_explode:Class;
		
		[Embed(source = "../assets/sounds/lava.mp3")] 
		private var sfx_lava:Class;
		
		[Embed(source = "../assets/sounds/bigger.mp3")] 
		private var sfx_bigger:Class;
		
		[Embed(source = "../assets/sounds/smaller.mp3")] 
		private var sfx_smaller:Class;
		
		[Embed(source = "../assets/sounds/speed_up.mp3")] 
		private var sfx_speed_up:Class;
		
		[Embed(source = "../assets/sounds/slow_down.mp3")] 
		private var sfx_slow_down:Class;
		
		[Embed(source = "../assets/sounds/multiball.mp3")] 
		private var sfx_multiball:Class;
		
		[Embed(source = "../assets/sounds/break.mp3")] 
		private var sfx_break:Class;
		
		[Embed(source = "../assets/sounds/music.mp3")] 
		private var main_music:Class;
	
		/*************
		 * Variables
		 ************/
		//text variables
		private var lives_text:FlxText;
		private var level_text:FlxText;
		
		//game state variables
		private var lives:Number;
		private var level:Number;
		
		private var level_width:Number;
		private var level_height:Number;
		
		// For lava
		private var emitter:FlxEmitter;
		
		/*************
		 * Sprites
		 ************/
		private var background:FlxSprite;
		private var info_bar_1:FlxSprite;
		private var info_bar_2:FlxSprite;
		private var lava:FlxSprite;
		private var main_bar:bar;
		
		/**************
		 * Constructor
		 *************/
		function level1() {
			super();
		}
		
		/**************************
		 * Convert int to string
		 **************************/
		public function intToString( number:int):String {
			return number.toString();
		}
		
		/*****************
		 * Change level
		 *****************/
		public function changeLevel():void {
			// Erase if any
			for ( var i:int = 0; i < bricks.length; i++) {
				this.remove( bricks.members[i]);
			}
			bricks.clear();
			
			// Remove extraballs
			for ( i = 0; i < balls.length; i++) {
				this.remove( balls.members[i]);
			}
			balls.clear();
			
			// Remove particles
			for ( i = 0; i < brick_emitters.length; i++) {
				this.remove( brick_emitters.members[i]);
			}
			brick_emitters.clear();
			
			// Remove powerups
			for ( i = 0; i < powerups.length; i++) {
				this.remove( powerups.members[i]);
			}
			powerups.clear();
			
			// Size to 0
			main_bar.setSize(0);
			
			var newBall:ball = new ball( false, main_bar.x + main_bar.width / 2, main_bar.y - 30);
			newBall.restart();
			this.add( newBall);
			balls.add( newBall);
			
			// Intensify!
			if( level <= 10){
				balls.members[0].setLevel( level);
				
				if( level < 9)
					level_height = level + 1;
				
				emitter.setXSpeed( -10 - (level * 5),  10 + (level * 5));
				emitter.setYSpeed( -20, -20 - (level * 10));
				emitter.start( false, 10, 0.01, 0);
			}
			
			// MAKE BRICKS!
			makeBricks( level_width, level_height);
		}
		
		/**************************
		 * Gen a random number
		 **************************/
		public function randomNumber( newMin:int, newMax:int):int {
			var range:int = newMax - newMin;
			var number:int = Math.floor(Math.random() * range) + newMin;
			return number;
		}
		
		/*****************
		 * Make blocks
		 ****************/
		public function makeBricks( newWidth:int, newHeight:int):void {
			// Create asked amount
			for ( var i:int = 0; i < newWidth; i++) {
				for ( var t:int = 0; t < newHeight; t++) {
					var brickType:int = randomNumber( 0, ((level - 1)%5) + 1);
					var brickTypeSpecial:int = randomNumber( 0, 10);
					
					var newBrick:FlxSprite;
					
					if( brickTypeSpecial != 1){
						switch (brickType) {
							case 0:
								newBrick = new FlxSprite( 0, 0, brick_blue_1_img);
								break;
							case 1:
								newBrick = new FlxSprite( 0, 0, brick_brown_1_img);
								break;
							case 2:
								newBrick = new FlxSprite( 0, 0, brick_red_1_img);
								break;
							case 3:
								newBrick = new FlxSprite( 0, 0, brick_yellow_1_img);
								break;
							default:
								break;
						}
					}
					else {
						newBrick = new FlxSprite( 0, 0, brick_white_1);	
						brickType = 10;
					}
						
					if ( brickType < 4 || brickTypeSpecial == 1) {
						newBrick.x = 16 + (i * 65);
						newBrick.y = 60 + (t * 24);
						newBrick.ID = brickType;
						newBrick.immovable = true;
						this.add(newBrick);
						bricks.add(newBrick);
					}
				}
			}
		}
		
		/******************
		 * Make explosion!
		 *****************/
		public function makeExplosion( newX:int, newY:int, newWidth:int, newHeight:int, newRotation:int, newSpeedX:int, newSpeedY:int, newGravity:int, imageType:Class):void {
			// Config emitter
			var brick_emitter:FlxEmitter = new FlxEmitter( 0, 0, 20); //x and y of the emitter
			brick_emitter.x = newX;
			brick_emitter.y = newY;
			brick_emitter.width = newWidth;
			brick_emitter.height = newHeight;
			brick_emitter.minRotation = -newRotation;
			brick_emitter.maxRotation = newRotation;
			brick_emitter.setXSpeed( -newSpeedX, newSpeedX);
			brick_emitter.gravity = newGravity;
			brick_emitter.setYSpeed( -newSpeedY, newSpeedY);
			
			// Add emitter to screen
			add(brick_emitter);
			brick_emitters.add( brick_emitter);
			
			// Make some particles
			for ( var i:int = 0; i < 20; i++ ) {
				var newParticle:FlxParticle = new FlxParticle();
				newParticle.loadGraphic( imageType, false, false, 20, 20);
				newParticle.exists = false;
				newParticle.addAnimation( "particle-explode", [0,1,2,3], 2, true);
				newParticle.play( "particle-explode");
				brick_emitter.add( newParticle);
			}
			// Start
			brick_emitter.start( true, 1.5, 0, 10);
		}
		
		/*****************
		 * Setup Game
		 ****************/
		override public function create():void {
			super.create();
			
			// Debug mode!
			//FlxG.debug = true; 
			
			/*******************
			 * Groups (arrays)
			 *******************/
			// Add the barriers to our group
			bricks = new FlxGroup();
			brick_emitters = new FlxGroup();
			balls = new FlxGroup();
			powerups = new FlxGroup();
			
			/**************
			 * Sprites
			 *************/
			// Background
			background = new FlxSprite( 0, 0, background_img);
			this.add(background);
			
			info_bar_1 = new FlxSprite( 10, 10, info_bar_1_image);
			this.add(info_bar_1);
			
			info_bar_2 = new FlxSprite( 448, 10, info_bar_2_image);
			this.add(info_bar_2);
			
			// Lava
			lava = new FlxSprite( 0, 380, lava_img);
			this.add(lava);
			
			// Bar
			main_bar = new bar( FlxG.width / 2, 330);
			this.add( main_bar);
			
			// Ball
			var newBall:ball = new ball( false);
			this.add( newBall);
			balls.add( newBall);
			
			// Params for bricks
			level_width = 8;
			level_height = 2;
			
			/**************
			 * Variables
			 *************/
			lives = 3;
			level = 1;
			
			level_text = new FlxText( 15, 15, 100, intToString(level));
			level_text.setFormat ( null, 12, 0x00000000, "left");
			this.add(level_text);
			
			lives_text = new FlxText( 453, 15, 100, intToString(lives));
			lives_text.setFormat ( null, 12, 0x00000000, "left");
			this.add(lives_text);
			
			// Play song
			FlxG.play( main_music, 1, true);
			FlxG.play( sfx_lava, 1, true);
			
			
			/******************
			 * Lava Particles
			 ******************/
			emitter = new FlxEmitter( 0, FlxG.height - 15, 200); //x and y of the emitter

			// Make some particles
			for ( var i:int = 0; i < 200; i++ ) {
				var newParticle:FlxParticle = new FlxParticle();
				newParticle.loadGraphic( lava_bubble, false, false, 8, 8);
				newParticle.exists = false;
				newParticle.addAnimation( "bubble-shrink", [0, 1, 2, 3], 2, true);
				newParticle.play( "bubble-shrink");
				emitter.add( newParticle);
			}
			
			// Add emitter to screen
			add(emitter);
			
			// Config emitter
			emitter.minRotation = 0;
			emitter.maxRotation = 0;
			emitter.width = FlxG.width;
			emitter.gravity = 120;
			emitter.setXSpeed( -10 - (level * 5),  10 + (level * 5));
			emitter.setYSpeed( -20, -20 - (level * 10));
			emitter.start( false, 10, 0.01, 0);
			
			// Text
			debugText = new FlxText( 0, 0, 40, "");
			add(debugText);
			
			// Hide mouse
			FlxG.mouse.hide();
			
			// Next level!
			changeLevel();
		}
		
		/***************
		 * Update Game
		 **************/
		override public function update():void {
			// Debug the timer
			// debugText.text = intToString(main_bar.bar_size);
			
			// Always call this at the start of the function
			super.update();
			
			/***********************
			 * Delete old emitters
			 ***********************/
			if ( brick_emitters.length > 10) {
				this.remove( brick_emitters.members[0]);
				brick_emitters.remove( brick_emitters.members[0], true);
			}
			
			// Lose game! (YOUUU LOSSEEEE *dannyvoice*(tm))
			if ( lives <= 0) {
				FlxG.switchState(new menuScreen());
			}
			
			// Debug stuff
			/*if ( FlxG.keys.justPressed("Q")) {
				level ++;
				changeLevel();
			}
			else if ( FlxG.keys.justPressed("W")) {
				// Ball
				var ballAmount:int = balls.length;
				for ( var k:int = 0; k < ballAmount; k++) {
					var newBall:ball = new ball( true, balls.members[k].x + balls.members[k].width, balls.members[k].y + balls.members[k].height, balls.members[k].velocity.x, balls.members[k].velocity.y);
					this.add( newBall);
					balls.add( newBall);
				}	
			}*/
			
			// Idle pos
			balls.members[0].setIdlePos( main_bar.x + main_bar.width / 2, main_bar.y - 30);
			
			// Ball hit lava (die)
			FlxG.overlap( balls, lava, collide_lava);
			
			// Ball hit brick
			if ( FlxG.collide( balls, bricks, collide_brick)) {
				FlxG.play( sfx_break, 1, false);
			}
			
			// Ball hit bar
			FlxG.overlap( balls, main_bar, collide_bar);
			
			// Powerup hit bar
			FlxG.overlap( powerups, main_bar, collide_powerup);
			
			// Powerup hit lava
			FlxG.overlap( powerups, lava, collide_powerup_lava);
			
			/***************
			 * Next Level!
			 ***************/
			if ( bricks.length <= 0){
				level += 1;
				changeLevel();
			}
			
			// Display lives
			lives_text.text = "LIVES:" + intToString( lives);
			
			// Display current level
			level_text.text = "LEVEL:" + intToString( level);
		}
		
		// Collide brick actions
		private function collide_brick( newBall:FlxSprite, newBrick:FlxSprite):void {
			// Some blocks get passed right through
			/*if ( newBrick.ID != 1){
				if ( !ball_has_bounced_x && (( newBall.velocity.x < 0 && newBall.x + newBall.width/2 > newBrick.x + newBrick.width) || 
											 ( newBall.velocity.x > 0 && newBall.x + newBall.width/2 < newBrick.x))) {
					if( !ball_has_bounced_x){
						newBall.velocity.x *= -1;
						ball_has_bounced_x = true;
					}
				}
				else if ( !ball_has_bounced_y && (( newBall.velocity.y < 0 && newBall.y + newBall.height/2 > newBrick.y + newBrick.height) || 
											 ( newBall.velocity.y > 0 && newBall.y + newBall.height/2 < newBrick.y))) {
					if( !ball_has_bounced_y){
						newBall.velocity.y *= -1;
						ball_has_bounced_y = true;
					}
				}
			}*/
			
			// Do unique stuff
			if ( newBrick.ID == 0) {
				makeExplosion( newBrick.x, newBrick.y, newBrick.width, newBrick.height, 180, 500, 500, 10, particles_blue);
			}
			else if ( newBrick.ID == 1) {
				FlxG.play( sfx_dirt, 0.8, false);
				makeExplosion( newBrick.x, newBrick.y, newBrick.width, newBrick.height, 180, 20, 20, 0, particles_brown);
			}
			else if ( newBrick.ID == 2) {
				makeExplosion( newBrick.x, newBrick.y, newBrick.width, newBrick.height, 0, 100, 0, 1000, particles_red);
				
				var newAddBrick:FlxSprite = new FlxSprite( 0, 0, brick_blue_1_img);
				newAddBrick.x = newBrick.x;
				newAddBrick.y = newBrick.y;
				newAddBrick.ID = 0;
				newAddBrick.immovable = true;
				this.add(newAddBrick);
				bricks.add(newAddBrick);
			}
			else if ( newBrick.ID == 3){
				FlxG.play( sfx_explode, 0.8, false);
				makeExplosion( newBrick.x, newBrick.y, newBrick.width, newBrick.height, 180, 500, 500, 10, particles_yellow);
			}
			else if ( newBrick.ID == 10) {
				makeExplosion( newBrick.x, newBrick.y, newBrick.width, newBrick.height, 180, 20, 20, 0, particles_question);
				var newPowerup:powerup = new powerup( newBrick.x + newBrick.width / 2, newBrick.y + newBrick.height / 2, randomNumber( 0, 5));
				newPowerup.x -= newPowerup.width / 2;
				newPowerup.y -= newPowerup.height / 2;
				powerups.add( newPowerup);
				this.add( newPowerup);
			}
			
			// Remove the bricks
			bricks.remove( newBrick, true);
			this.remove( newBrick);
		}
		
		// Collide bar actions
		private function collide_bar( newBall:ball, newBar:bar):void {
			newBall.hit_bar( main_bar.x, main_bar.y, main_bar.width);
		}
		
		// Collide lava actions
		private function collide_lava( newBall:ball, newLava:FlxSprite):void {
			if( balls.length <= 1){
				lives -= 1;
				newBall.setActive(false);
			}
			// Remove the ball
			else {
				balls.remove( newBall, true);
				this.remove( newBall);
			}
			
			// Size to 0
			main_bar.setSize(0);
		}
		
		// Collide powerup actions
		private function collide_powerup( newPowerup:powerup, newBar:bar):void {
			var powerupID:Number = newPowerup.getType();
			
			if ( powerupID == 0) {
				balls.members[0].setMaxVelocity( -150);
				FlxG.play( sfx_slow_down, 0.9, false);
			}
			else if ( powerupID == 1) {
				balls.members[0].setMaxVelocity( 150);
				FlxG.play( sfx_speed_up, 0.9, false);
			}
			else if ( powerupID == 2) {
				// Ball
				var ballAmount:int = balls.length;
				for ( var k:int = 0; k < ballAmount; k++) {
					var newBall:ball = new ball( true, balls.members[k].x + balls.members[k].width, balls.members[k].y + balls.members[k].height, balls.members[k].velocity.x, balls.members[k].velocity.y);
					this.add( newBall);
					balls.add( newBall);
				}
				FlxG.play( sfx_multiball, 0.9, false);
			}
			else if ( powerupID == 3) {
				main_bar.setSize( 1);
				FlxG.play( sfx_bigger, 0.9, false);
			}
			else if ( powerupID == 4) {
				main_bar.setSize( -1);
				FlxG.play( sfx_smaller, 0.9, false);
			}
			
			// Del powerup
			powerups.remove( newPowerup, true);
			this.remove( newPowerup);
		}
		
		// Collide powerup lava actions
		private function collide_powerup_lava( newPowerup:powerup, newLava:FlxSprite):void {
			// Del powerup
			powerups.remove( newPowerup, true);
			this.remove( newPowerup);
		}
	}
}