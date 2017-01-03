package 
{
	/*
	 * Allan Legemaate
	 * Brick Breaker
	 * 25/01/16
	 * Ball!
	 */
	
	// Flixel library
	import org.flixel.*;
	
	public class ball extends FlxSprite 
	{
		// Images
		[Embed(source = "../assets/images/ball.png")] 
		private var ball_img:Class;
		
		// Sounds
		[Embed(source = "../assets/sounds/bounce.mp3")] 
		private var sfx_bounce:Class;
		
		// Max vel
		private static var ball_max_velocity:Number;
		private static var ball_velocity_ratio:Number;
		private static var ball_velocity_ratio_old:Number;
		private var ball_has_bounced_x:Boolean;
		private var ball_has_bounced_y:Boolean;
		private var ball_active:Boolean;
		
		private static var idle_x:int;
		private static var idle_y:int;
		
		// Create Ball
		public function ball( newActive:Boolean = true, newX:int = 0, newY:int = 0, newVelocityX:int = 0, newVelocityY:int = 0):void {
			// Make flx sprite
			super(  newX, newY, ball_img);
			
			this.ball_active = newActive;
			this.velocity.x = newVelocityX;
			this.velocity.y = newVelocityY;
			this.elasticity = 1;
			ball_velocity_ratio_old = 0;
			ball_velocity_ratio = 0;
		}
		
		
		// Update Ball
		override public function update():void {
			super.update();
			
			/*********
			 * Start
			 ********/
			if ( !ball_active) {
				this.x = idle_x;
				this.y = idle_y;
				
				if ( FlxG.mouse.justPressed()) {
					this.velocity.y = ball_max_velocity;
					this.velocity.x = 0;
					ball_active = true;
				}
			}
			// Catch stopped balls
			else if ( this.velocity.y == 0) {
				this.velocity.y = -ball_max_velocity;
				this.velocity.x = 0;
			}
			
			/***************
			 * Bounce Ball
			 ***************/
			ball_has_bounced_x = false;
			ball_has_bounced_y = false;
			
			/************
			 * Hit Edges
			 ************/
			if ( this.x <= 0) {
				if( this.velocity.x < 0)
					this.velocity.x *= -1;
				FlxG.play( sfx_bounce, 0.8, false);
			}
			if ( this.x + this.width > FlxG.width) {
				if( this.velocity.x > 0)
					this.velocity.x *= -1;
				FlxG.play( sfx_bounce, 0.8, false);
			}
			if ( this.y <= 0) {
				if( this.velocity.y < 0)
					this.velocity.y *= -1;
				FlxG.play( sfx_bounce, 0.8, false);
			}
			if ( this.y + this.height > FlxG.height) {
				if( this.velocity.y > 0)
					this.velocity.y *= -1;
				FlxG.play( sfx_bounce, 0.8, false);
			}
			
			// Max velocity check
			if ( ball_velocity_ratio_old != ball_velocity_ratio) {
				this.velocity.x *= ball_velocity_ratio;
				this.velocity.y *= ball_velocity_ratio;	
				ball_velocity_ratio_old = ball_velocity_ratio;
			}
		}
		
		// Hit bar
		public function hit_bar( barX:Number, barY:Number, barWidth:Number):void {
			this.velocity.x += ( (this.x + this.width / 2) - (barX + barWidth / 2)) * 3
				
			// Keep x velocity within bounds
			if ( this.velocity.x > ball_max_velocity * 0.8)
				this.velocity.x = ball_max_velocity * 0.8;
			if ( this.velocity.x < ball_max_velocity * -0.8)
				this.velocity.x = ball_max_velocity * -0.8;
		
			// Make sure ball retains velocity
			this.velocity.y = Math.sqrt(Math.pow(ball_max_velocity, 2) - Math.pow(this.velocity.x, 2));
			
			// It needs to bounce back
			if ( this.velocity.y > 0) {
				this.velocity.y *= -1;
			}
			
			this.y = barY - ( this.width + 1);
			
			FlxG.play( sfx_bounce, 0.8, false);
		}
		
		// Restart
		public function restart():void {
			ball_active = false;
			this.velocity.x = 0;
			this.velocity.y = 0;	
		}
		
		// Set level (speed)
		public function setLevel( levelOn:int):void {
			ball_max_velocity = 250 + 50 * levelOn;
		}
		
		// Set active
		public function setActive( active:Boolean):void {
			this.velocity.x = 0;
			this.velocity.y = 0;
			this.x = idle_x;
			this.y = idle_y;
			ball_active = active;
		}
		
		// Set idle pos
		public function setIdlePos( newIdleX:int, newIdleY:int):void {
			idle_x = newIdleX - (this.width / 2);
			idle_y = newIdleY;
		}
		
		// Set max velocity
		public function setMaxVelocity( newVelocity:int):void {
			if( newVelocity + ball_max_velocity < 800 && newVelocity + ball_max_velocity > 200){
				ball_velocity_ratio = (newVelocity + ball_max_velocity) / ball_max_velocity;
				ball_max_velocity = newVelocity + ball_max_velocity;
			}
		}
	}
}