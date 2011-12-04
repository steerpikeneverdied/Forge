package com.deadwest.forge.controller 
{
	import com.deadwest.forge.ForgePanel;
	import com.deadwest.forge.format.WordWrapCellRenderer;
	import com.deadwest.forge.model.ForgingModel;
	import com.deadwest.forge.model.GlobalConstants;
	import com.deadwest.forge.model.InventoryItem;
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.controls.listClasses.CellRenderer;
	import fl.controls.ScrollPolicy;
	import fl.data.DataProvider;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.XMLNode;
	/**
	 * ...
	 * @author simonh
	 */
	public class DataGridController
	{
		public var dataGrid 		: DataGrid;
		private var model			: ForgingModel;
		private var gridGuide		: DisplayObjectContainer;
		private var dataProvider	: DataProvider;
		private var itemList		: Vector.<InventoryItem>;
		private var mainPanel		: ForgePanel;
		
		public function DataGridController(model : ForgingModel) : void
		{
			this.model = model;
			this.mainPanel = model.getForgePanel();
			this.dataGrid = mainPanel.forgeDataGrid;
			
			dataGrid.rowHeight = 30;
			dataGrid.addEventListener(MouseEvent.CLICK, handleMouseClick);
			dataProvider = new DataProvider();
			
			requestTableSettings();
		}
		
		private function handleMouseClick(e:MouseEvent):void 
		{
			if(dataGrid.isItemSelected !== null)
			{
				displaySelectedItem();
			}
		}
		
		private function displaySelectedItem():void 
		{
			for each(var item : InventoryItem in model.getItemList())
			{
				if (item.getName() == dataGrid.selectedItem.Name)
				{
					mainPanel.descriptionBox.text = item.getDescription();
					mainPanel.dispatchEvent(new ForgingDataEvent(ForgingDataEvent.ITEM_CLICKED, item));
				}
			}
		}
		
		private function requestTableSettings() : void
		{
			var configRequest : URLRequest = new URLRequest(GlobalConstants.FORGE_TABLE_CONFIG_PATH); 
			var configLoader : URLLoader = new URLLoader;
 
			configLoader.load(configRequest); 
			configLoader.addEventListener(Event.COMPLETE, configCompleteHandler);
		}
		
		private function configCompleteHandler(e:Event):void 
		{
			var tableXML : XML = new XML(e.target.data);
			var tableAttributes : XMLList = tableXML.columns.column;
			
			for each (var column : XML in tableAttributes) 
			{
				var nameCol : DataGridColumn = new DataGridColumn(column.@name);
				
				nameCol.headerText = column.@name;
				nameCol.setWidth(int(column.@width));
				nameCol.cellRenderer = WordWrapCellRenderer;
				dataGrid.addColumn(nameCol);
			}
			
			onColumnsConfigured();
		}
		
		private function onColumnsConfigured():void 
		{
			itemList = model.getItemList();
			
			for each(var item : InventoryItem in itemList)
			{
				dataProvider.addItem( {
					"Name" 			: item.getName(),
					"Rarity" 		: item.getRarity(),
					"Description" 	: item.getDescription()
				});
			}
			
			dataGrid.dataProvider = dataProvider;
		}
	}
}