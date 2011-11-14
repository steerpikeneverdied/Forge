package com.deadwest.breeding.model 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class BreedingModel 
	{
		private var stageClip : MovieClip;
		private var itemList : Vector.<InventoryItem>;
		
		public function BreedingModel() 
		{
			
		}
		
		public function getStageClip():MovieClip 
		{
			return stageClip;
		}
		
		public function setStageClip(stageClip : MovieClip):void 
		{
			this.stageClip = stageClip;
		}
		
		public function getItemList() : Vector.<InventoryItem>
		{
			return itemList;
		}
		
		public function setItemList(itemList : Vector.<InventoryItem>) : void 
		{
			this.itemList = itemList;
		}
	}
}