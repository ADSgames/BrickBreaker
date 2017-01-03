package{
	/*
	 * Allan Legemaate
	 * Creates game
	 * 22/01/16
	 * LOADER
	 */
	
	// Flixel libray
	import org.flixel.*;

	// Just the game creator runs 1 time when game is made
	public class theGame extends FlxGame{
		public function theGame():void{
			// Create screen
			super( 550, 400, firstLoader, 1);
		}
	}
}