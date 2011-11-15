package com.deadwest.forge.factory 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class ForgingTableFactory 
	{
		static private var stageTarget	: DisplayObject;
		
		public static function create(width : Number, height : Number) : Sprite
		{
			return (generateTable(width, height));
		}
		
		static private function generateTable(width:Number, height:Number) : Sprite
		{
			var table : Sprite = new Sprite();
			table.graphics.beginFill(0xdd8888)
			table.graphics.drawRoundRect(0, 0, width, height, 5)
			table.graphics.endFill();
			
			return table;
		}
	}
}