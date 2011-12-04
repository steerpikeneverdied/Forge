package com.deadwest.forge.controller 
{
	import com.deadwest.forge.event.ForgingDataEvent;
	import com.deadwest.forge.event.ForgingEvent;
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
		private var view		: ForgingPanelView;
		private var model		: ForgingModel;
		private var forgePanel	: ForgePanel;
		private var itemArray	: Array = [];
		private var itemCombination: Array;
		private var itemMadeID:Number;
		private var createdItem:InventoryItem;
		private var itemCombinationList:Array;
		
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
			forgePanel.addEventListener(ForgingEvent.FORGE_COMPLETE, onForgeComplete);
		}
		
		private function onItemSelected(event : ForgingDataEvent) : void 
		{
			var eventDataArray : Array = event.data as Array;
			var item : InventoryItem = eventDataArray[0] as InventoryItem;
			var ingredientNumber : uint = eventDataArray[1];
			itemCombinationList = createItemIngredientArray();
			itemArray[ingredientNumber - 1] = item;
		}
		
		private function onForgeComplete(event : ForgingEvent) : void
		{
			var itemID1 : int = (itemArray[0] as InventoryItem).getId();
			var itemID2 : int = (itemArray[1] as InventoryItem).getId();
			
			itemCombination = new Array(itemID1, itemID2);
			itemCombination.sort();
			if (canCreateItem(itemCombination))
			{
				forgePanel.dispatchEvent(new ForgingDataEvent(ForgingDataEvent.FORGE_SUCCESSFUL, createdItem));
			}
		}
		
		private function canCreateItem(itemCombination:Array) : Boolean 
		{
			for (var i : int = itemCombinationList.length; i > 1; i--)
			{
				if ((itemCombinationList[i-1][0] == itemCombination[0]) && (itemCombinationList[i-1][1] == itemCombination[1]))
				{
					var itemList : Vector.<InventoryItem>= model.getItemList();
					itemMadeID = i - 1;
					for each(var item : InventoryItem in itemList)
					{
						if (item.getId() == itemMadeID)
						{
							createdItem = item;
							return true;
						}
					}
				}
			}
			
			return false;
		}
		
		private function createItemIngredientArray() : Array 
		{
			var itemList : Vector.<InventoryItem>= model.getItemList();
			var comboList : Array = new Array();
			
			for each(var item : InventoryItem in itemList)
			{
				var itemCombination : Array = new Array(uint(item.getCombination()[0]), uint(item.getCombination()[1]));
				comboList[item.getId()] = itemCombination;
			}
			
			return comboList;
		}
		
		public function destroy() : void
		{
			if (forgePanel)
			{
				forgePanel.removeEventListener(ForgingDataEvent.ITEM_SELECTED, onItemSelected);
				forgePanel.removeEventListener(ForgingEvent.FORGE_COMPLETE, onForgeComplete);
			}
		}
	}

}