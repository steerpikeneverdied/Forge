package com.deadwest.forge.parser 
{
	import com.deadwest.forge.model.ForgingModel;
	import com.deadwest.forge.model.InventoryItem;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * @author simonh
	 */
	public class InventoryDefinitionParser 
	{
		private var xmlPath				: String;
		private var model				: ForgingModel;
		private var xmlCompleteCallback	: Function;
		
		public function InventoryDefinitionParser(xmlPath : String, model : ForgingModel, xmlCompleteCallback : Function = null)
		{
			this.xmlPath = xmlPath;
			this.model = model;
			this.xmlCompleteCallback = xmlCompleteCallback;	
		}
		
		public function init() : void
		{			
			createInventoryTemplateRequest();
		}
		
		private function createInventoryTemplateRequest() : void
		{
			var contentRequest : URLRequest = new URLRequest(xmlPath); 
			var contentLoader : URLLoader = new URLLoader;
 
			contentLoader.load(contentRequest); 
			contentLoader.addEventListener(Event.COMPLETE, contentCompleteHandler);
		}
		
		private function contentCompleteHandler(e : Event) : void 
		{
			var tableXML : XML = new XML(e.target.data);
			var tableAttributes : XMLList = tableXML.inventoryTemplate.item;
			
			parseInventoryAttributes(tableAttributes);
		}
		
		public function parseInventoryAttributes(tableAttributes : XMLList) : void
		{
			var itemVector : Vector.<InventoryItem> = new Vector.<InventoryItem>;
			
			for each (var row : XML in tableAttributes) 
			{
				var inventoryItem : InventoryItem = new InventoryItem();
				
				inventoryItem.setName			(row.@name);
				inventoryItem.setId				(row.@id);
				inventoryItem.setFamily			(row.@family);
				inventoryItem.setCombination	(row.@combination as Array);
				inventoryItem.setComboquantity	(row.@comboquantity as Array);
				inventoryItem.setRarity			(row.@rarity);
				inventoryItem.setDescription	(row.@description);
				
				itemVector.push(inventoryItem);
			}
			
			model.setItemList(itemVector);
			
			handleInventoryLoadComplete();
		}
		
		private function handleInventoryLoadComplete() : void 
		{
			if(xmlCompleteCallback !== null)
			{
				xmlCompleteCallback();
			}
		}
	}

}