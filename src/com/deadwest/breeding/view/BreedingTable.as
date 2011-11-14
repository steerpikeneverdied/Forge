package com.deadwest.breeding.view 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class BreedingTable 
	{
		private var table 		: Sprite;
		private var tableWidth	: Number;
		private var tableHeight	: Number;
		
		public function BreedingTable(tableWidth : Number, tableHeight : Number) : Sprite
		{
			this.tableWidth = tableWidth;
			this.tableHeight = tableHeight;
			
			return drawTable();
		}
		
		private function drawTable() : Sprite
		{
			table = new Sprite();
			table.graphics.beginFill(0xdd8888)
			table.graphics.drawRoundRect(0, 0, tableWidth, tableHeight, 5)
			table.graphics.endFill();
			
			return table;
		}
	}
}