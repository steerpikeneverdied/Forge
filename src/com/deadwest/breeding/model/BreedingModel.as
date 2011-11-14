package com.deadwest.breeding.model 
{
	import com.deadwest.breeding.BreederPanel;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class BreedingModel 
	{
		private var stageClip 		: MovieClip;
		private var itemList 		: Vector.<InventoryItem>;
		private var breederPanel 	: BreederPanel;
		
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
		
		public function setBreedPanel(breederPanel : BreederPanel) : void 
		{
			this.breederPanel = breederPanel;
		}
		
		public function getBreedPanel() : BreederPanel
		{
			return breederPanel;
		}
	}
}