package
{
	import com.gavin.game.manager.GameManager;
	import com.gavin.game.view.Grid;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * ...
	 * @author Gavin
	 */
	[SWF(width = 335, height = 335)]
	public class Main extends Sprite
	{

		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initView();
			addEvent();
		}

		private function initView():void
		{
			this.graphics.beginFill(0x999999);
			this.graphics.drawRect(0, 0, 1000, 10000);
			this.graphics.endFill();
			this.addChild(Grid.getInstance());
			Grid.getInstance().createRandomCell();
		}

		private function addEvent():void
		{
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		private function removeEvent():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		private function keyUp(event:KeyboardEvent):void
		{
			if (Grid.getInstance().tweening)
				return;
			GameManager.getInstance().moves = 0;
			switch (event.keyCode)
			{
				case Keyboard.UP:
					GameManager.getInstance().upProcess();
					break;
				case Keyboard.LEFT:
					GameManager.getInstance().leftProcess();
					break;
				case Keyboard.RIGHT:
					GameManager.getInstance().rightProcess();
					break;
				case Keyboard.DOWN:
					GameManager.getInstance().downProcess();
					break;
				case Keyboard.R:
					Grid.getInstance().resetGame();
					Grid.getInstance().createRandomCell();
					break;
			}
			if (GameManager.getInstance().moves > 0)
				Grid.getInstance().createRandomCell();
			
		}
	}

}
