package com.gavin.game 
{
	/**
	 * ...
	 * @author Gavin
	 */
	public class GameController 
	{
		
		public function GameController() 
		{
			
		}
		
		private var _Instance:GameController;
		public static function getInstance():GameController
		{
			if (_Instane == null)
				_Instance = new GameController();
			return _Instance;
		}
		
	}

}