package {
	/*
	 * Allan Legemaate
	 * Brick Breaker
	 * 25/01/16
	 * 1 Shot Loader
	 */
	
	// Flixel Library
	import org.flixel.*;
	
	public class firstLoader extends FlxState {
		// Stuff to call on init
		override public function create():void {
			// Create screen
			FlxG.switchState(new menuScreen());
		}
		
		// Constructor
		public function firstLoader(){
			super();
		}
	}
}