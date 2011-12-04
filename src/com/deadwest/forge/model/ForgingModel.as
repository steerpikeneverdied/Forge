package com.deadwest.forge.model 
{
	import com.deadwest.forge.ForgePanel;
	import com.deadwest.forge.view.ForgingPanelView;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class ForgingModel 
	{
		private var stageClip 			: MovieClip;
		private var itemList 			: Vector.<InventoryItem>;
		private var forgePanel 			: ForgePanel;
		private var forgingPanelView 	: ForgingPanelView;
		
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
		
		public function setForgePanel(forgePanel : ForgePanel) : void 
		{
			this.forgePanel = forgePanel;
		}
		
		public function getForgePanel() : ForgePanel
		{
			return forgePanel;
		}
		
		public function setForgePanelView(forgingPanelView : ForgingPanelView) : void
		{
			this.forgingPanelView = forgingPanelView;
		}
				
		public function getForgePanelView() : ForgingPanelView
		{
			return forgingPanelView;
		}
	}
}