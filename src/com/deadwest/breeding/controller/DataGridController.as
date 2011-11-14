package com.deadwest.breeding.controller 
{
	import com.deadwest.breeding.format.WordWrapCellRenderer;
	import com.deadwest.breeding.model.GlobalConstants;
	import com.deadwest.breeding.model.InventoryItem;
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.controls.listClasses.CellRenderer;
	import fl.controls.ScrollPolicy;
	import fl.data.DataProvider;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.XMLNode;
	/**
	 * ...
	 * @author simonh
	 */
	public class DataGridController
	{
		private var dataGrid 		: DataGrid;
		private var xmlConfigPath 	: String;
		private var xmlContentPath 	: String;
		private var gridGuide		: DisplayObjectContainer;
		private var dataProvider	: DataProvider;
		
		public function DataGridController(dGrid : DataGrid) : void
		{
			dataGrid = dGrid;
			dataGrid.rowHeight = 30;
			
			xmlConfigPath = GlobalConstants.BREED_TABLE_CONFIG_PATH;
			
			requestTableSettings();
		}
		
		private function requestTableSettings() : void
		{
			var configRequest : URLRequest = new URLRequest(xmlConfigPath); 
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
		}
	}
}