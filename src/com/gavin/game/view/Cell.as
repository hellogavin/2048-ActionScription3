package com.gavin.game.view
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * ...
	 * @author Gavin
	 */
	public class Cell extends Sprite
	{

		public function Cell()
		{
			init();
		}

		private var _Text:TextField;
		public var posX:int;
		public var posY:int;
		private var _Value:int;
		private var _isStacked:Boolean;

		public static var cellSize:int = 80;

		private function init():void
		{
			this.graphics.beginFill(0);
			this.graphics.drawRect(0, 0, cellSize, cellSize);
			this.graphics.endFill();
			_Text = new TextField();
			_Text.width = cellSize;
			_Text.selectable = false;
			_Text.defaultTextFormat = new TextFormat("宋体", 20, 0xFFFFFF, true);
			_Text.autoSize = TextFieldAutoSize.CENTER;
			this.addChild(_Text);
		}

		public function get value():int
		{
			return _Value;
		}

		public function set value(val:int):void
		{
			_Value = val;
			_Text.text = val + '';
			_Text.y = (cellSize - _Text.textHeight) * 0.5;
			this.visible = val > 0;
		}

		public function stack():void
		{
			value *= 2;
			_isStacked = true;
		}

		public function get isStacked():Boolean
		{
			return _isStacked;
		}

		public function set isStacked(bool:Boolean):void
		{
			_isStacked = bool;
		}
	}

}
