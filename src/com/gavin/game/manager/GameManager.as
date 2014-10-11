package com.gavin.game.manager
{
	import com.gavin.game.view.Cell;
	import com.gavin.game.view.Grid;

	/**
	 * ...
	 * @author Gavin
	 */
	public class GameManager
	{

		public function GameManager()
		{

		}

		public var moves:int;

		public function upProcess():void
		{
			for (var i:int = 3; i >= 0; i--)
			{
				for (var j:int = 1; j <= 3; j++)
				{
					var cell:Cell = Grid.getInstance().getCell(i, j);
					if (cell.value != 0)
						Grid.getInstance().upProcess(cell);
				}
			}
		}

		public function downProcess():void
		{
			for (var i:int = 3; i >= 0; i--)
			{
				for (var j:int = 2; j >= 0; j--)
				{
					var cell:Cell = Grid.getInstance().getCell(i, j);
					if (cell.value != 0)
						Grid.getInstance().downProcess(cell);
				}
			}
		}

		public function leftProcess():void
		{
			for (var j:int = 3; j >= 0; j--)
			{
				for (var i:int = 1; i <= 3; i++)
				{
					var cell:Cell = Grid.getInstance().getCell(i, j);
					if (cell.value != 0)
						Grid.getInstance().leftProcess(cell);
				}
			}
		}

		public function rightProcess():void
		{
			for (var j:int = 3; j >= 0; j--)
			{
				for (var i:int = 2; i >= 0; i--)
				{
					var cell:Cell = Grid.getInstance().getCell(i, j);
					if (cell.value != 0)
						Grid.getInstance().rightProcess(cell);
				}
			}
		}

		private static var _Instance:GameManager;

		public static function getInstance():GameManager
		{
			if (_Instance == null)
			{
				_Instance = new GameManager();
			}
			return _Instance;
		}
	}

}
