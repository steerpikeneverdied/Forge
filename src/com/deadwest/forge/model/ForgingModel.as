package com.deadwest.forge.model 
{
	import com.deadwest.forge.ForgePanel;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class ForgingModel 
	{
		private var stageClip 		: MovieClip;
		private var itemList 		: Vector.<InventoryItem>;
		private var forgePanel 	: ForgePanel;
		
		public function ForgingModel() 
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
		
		public function setForgePanel(ForgePanel : ForgePanel) : void 
		{
			this.breederPanel = breederPanel;
		}
		
		public function getForgePanel() : ForgePanel
		{
			return forgePanel;
		}
	}
}