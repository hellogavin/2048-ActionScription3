package com.gavin.game.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gavin
	 */
	public class GameControlEvents extends Event 
	{
		
		public function GameControlEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
		public static const ACTIVATE_GAME_KEYBOARD:String = "activateGameKeyBoard";
		public static const INACTIVATE_GAME_KEYBOARD:String = "inactivateGameKeyBoard";
		
	}

}