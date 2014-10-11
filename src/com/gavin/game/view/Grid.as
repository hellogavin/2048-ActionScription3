package com.gavin.game.view
{
	import com.gavin.game.manager.GameManager;
	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.utils.setTimeout;

	/**
	 * ...
	 * @author Gavin
	 */
	public class Grid extends Sprite
	{
		public function Grid()
		{
			super();
			resetGame();
			var gridWidth:int = Cell.cellSize * gridNum + SPACE * (gridNum - 1);
			var gridHeight:int = Cell.cellSize * gridNum + SPACE * (gridNum - 1);

			for (var i:int = 1; i < gridNum; i++)
			{
				this.graphics.beginFill(0xFFFFFF);
				this.graphics.lineStyle(SPACE, 0xFFFFFF);
				var pointX:int = Cell.cellSize * i + SPACE * (i - 1) + SPACE * 0.5;
				this.graphics.moveTo(0, pointX);
				this.graphics.lineTo(gridWidth, pointX);
			}
			for (i = 1; i < gridNum; i++)
			{
				this.graphics.beginFill(0xFFFFFF);
				this.graphics.lineStyle(SPACE, 0xFFFFFF);
				var pointY:int = Cell.cellSize * i + SPACE * (i - 1) + SPACE * 0.5;
				this.graphics.moveTo(pointY, 0);
				this.graphics.lineTo(pointY, gridHeight);
			}
		}

		public function resetGame():void
		{
			_GridData = new Vector.<Cell>();
			for (var i:int = 0; i < gridNum; i++)
			{
				for (var j:int = 0; j < gridNum; j++)
				{
					var cell:Cell = new Cell();
					cell.posX = j;
					cell.posY = i;
					cell.x = cell.posX * (cell.width + SPACE);
					cell.y = cell.posY * (cell.height + SPACE);
					cell.value = 0;
					_GridData.push(cell);
					this.addChild(cell);
				}
			}
		}

		private static var _Instance:Grid;

		private var _GridData:Vector.<Cell>;

		public static var gridNum:int = 4;
		private const SPACE:int = 5;

		public var tweening:Boolean;

		public function createRandomCell():void
		{
			var freePosition:Vector.<Cell> = getFreePosition();
			if (freePosition.length == 0)
				return;
			var randomNum:int = int(Math.random() * freePosition.length)
			var cell:Cell = freePosition.splice(randomNum, 1)[0];
			cell.x = cell.posX * (cell.width + SPACE);
			cell.y = cell.posY * (cell.height + SPACE);
			cell.value = Math.random() >= 0.5 ? 2 : 4;
			if (cell.value == 2 && freePosition.length > 0)
			{
				cell = freePosition[int(Math.random() * freePosition.length)];
				cell.x = cell.posX * (cell.width + SPACE);
				cell.y = cell.posY * (cell.height + SPACE);
				cell.value = 2;
			}
		}

		private function getFreePosition():Vector.<Cell>
		{
			var freePosition:Vector.<Cell> = new Vector.<Cell>();
			for each (var cell:Cell in _GridData)
			{
				cell.isStacked = false;
				if (cell.value == 0)
					freePosition.push(cell);
			}
			return freePosition;
		}

		public function upProcess(cell:Cell):void
		{
			var $y:int = cell.posY;
			var $x:int = cell.posX;
			$y--;
			while (getCell($x, $y) != null && getCell($x, $y).value == 0)
			{
				$y--;
				GameManager.getInstance().moves++;
			}
			$y++;
			if (cell.posY != $y)
			{
				getCell($x, $y).value = cell.value;
				cell.value = 0;
			}

			var prevCell:Cell = getCell($x, $y - 1);
			if (prevCell != null && prevCell.value == getCell($x, $y).value && !prevCell.isStacked)
			{
				prevCell.stack();
				getCell($x, $y).value = 0;
			}
		}

		public function downProcess(cell:Cell):void
		{
			var $y:int = cell.posY;
			var $x:int = cell.posX;
			$y++;
			while (getCell($x, $y) != null && getCell($x, $y).value == 0)
			{
				$y++;
				GameManager.getInstance().moves++;
			}
			$y--;
			if (cell.posY != $y)
			{
				getCell($x, $y).value = cell.value;
				cell.value = 0;
			}

			var nextCell:Cell = getCell($x, $y + 1);
			if (nextCell != null && nextCell.value == getCell($x, $y).value && !nextCell.isStacked)
			{
				nextCell.stack();
				getCell($x, $y).value = 0;
			}
		}

		public function leftProcess(cell:Cell):void
		{
			var $y:int = cell.posY;
			var $x:int = cell.posX;
			$x--;
			while (getCell($x, $y) != null && getCell($x, $y).value == 0)
			{
				$x--;
				GameManager.getInstance().moves++;
			}
			$x++;
			if (cell.posX != $x)
			{
				getCell($x, $y).value = cell.value;
				cell.value = 0;
			}

			var prevCell:Cell = getCell($x - 1, $y);
			if (prevCell != null && prevCell.value == getCell($x, $y).value && !prevCell.isStacked)
			{
				prevCell.stack();
				getCell($x, $y).value = 0;
			}
		}

		public function rightProcess(cell:Cell):void
		{
			var $y:int = cell.posY;
			var $x:int = cell.posX;
			$x++;
			while (getCell($x, $y) != null && getCell($x, $y).value == 0)
			{
				$x++;
				GameManager.getInstance().moves++;
			}
			$x--;
			if (cell.posX != $x)
			{
				getCell($x, $y).value = cell.value;
				cell.value = 0;
			}

			var nextCell:Cell = getCell($x + 1, $y);
			if (nextCell != null && nextCell.value == getCell($x, $y).value && !nextCell.isStacked)
			{
				nextCell.stack();
				getCell($x, $y).value = 0;
			}
		}

		public function getCell($x:int, $y:int):Cell
		{
			if ($x >= gridNum || $x < 0 || $y >= gridNum || $y < 0)
				return null
			return _GridData[$y * gridNum + $x];
		}

/*		private function getNextVerticalCell($x:int, $y:int):Cell
		{
			for (var i:int = $y + 1; i < gridNum; i++)
			{
				var cell:Cell = getCell($x, i);
				if (cell.value != 0)
					return cell;
				if (i == gridNum - 1)
					return cell;
			}
			return null;
		}

		private function getPrevVerticalCell($x:int, $y:int):Cell
		{
			for (var i:int = $y - 1; i >= 0; i--)
			{
				var cell:Cell = getCell($x, i);
				if (cell.value != 0)
					return cell;
				if (i == 0)
					return cell;
			}
			return null;
		}

		private function getPrevHorizontalCell($x:int, $y:int):Cell
		{
			for (var i:int = $x - 1; i >= 0; i--)
			{
				var cell:Cell = getCell(i, $y);
				if (cell.value > 0)
					return cell;
				if (i == 0)
					return cell;
			}
			return null;
		}

		private function getNextHorizontalCell($x:int, $y:int):Cell
		{
			for (var i:int = $x + 1; i < gridNum; i++)
			{
				var cell:Cell = getCell(i, $y);
				if (cell.value != 0)
					return cell;
				if (i == gridNum - 1)
					return cell;
			}
			return null;
		}*/

		public static function getInstance():Grid
		{
			if (_Instance == null)
				_Instance = new Grid();
			return _Instance;
		}
	}

}
