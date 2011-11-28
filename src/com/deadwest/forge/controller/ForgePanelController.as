package com.deadwest.forge.controller 
{
	import com.deadwest.forge.event.ForgingDataEvent;
	import com.deadwest.forge.ForgePanel;
	import com.deadwest.forge.model.ForgingModel;
	import com.deadwest.forge.model.InventoryItem;
	import com.deadwest.forge.view.ForgingPanelView;
	/**
	 * ...
	 * @author simonh
	 */
	public class ForgePanelController 
	{
		private var view:ForgingPanelView;
		private var model:ForgingModel;
		private var forgePanel:ForgePanel;
		
		public function ForgePanelController(view : ForgingPanelView, model : ForgingModel)
		{
			this.view = view;
			this.model = model;
			
			forgePanel = model.getForgePanel();
			
			addPanelListeners();
		}
		
		private function addPanelListeners() : void 
		{
			forgePanel.addEventListener(ForgingDataEvent.ITEM_SELECTED, onItemSelected);
		}
		
		private function onItemSelected(event : ForgingDataEvent):void 
		{
			var item : InventoryItem = event.data as InventoryItem;
		}
		
	}

}