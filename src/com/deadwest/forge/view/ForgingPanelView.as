package com.deadwest.forge.view
{
	import com.deadwest.forge.event.ForgingDataEvent;
	import com.deadwest.forge.ForgePanel;
	import com.deadwest.forge.controller.DataGridController;
	import com.deadwest.forge.event.ForgingEvent;
	import com.deadwest.forge.factory.ForgingTableFactory;
	import com.deadwest.forge.model.ForgingModel;
	import com.deadwest.forge.model.GlobalConstants;
	import com.deadwest.forge.model.InventoryItem;
	import com.deadwest.forge.parser.InventoryDefinitionParser;
	import fl.controls.DataGrid;
	import fl.controls.ProgressBarDirection;
	import fl.controls.ProgressBarMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class ForgingPanelView extends EventDispatcher
	{
		private var forgingTable		: Sprite;
		private var forgePanel			: ForgePanel;
		private var stageClip			: MovieClip;
		private var forgeDataGrid		: DataGrid;
		
		private const TABLE_WIDTH 		: int = 500;
		private const TABLE_HEIGHT 		: int = 200;
		private var buttonTime 			: int = 0;
		private var buttonTimeTarget	: int = 100;
		private var forgeSpeed			: int = 5;
		private var dataGridController	: DataGridController;
		private var inventoryDataParser : InventoryDefinitionParser;
		private var model				: ForgingModel;
		private var selectedItem		: InventoryItem;
		private var item1				: InventoryItem;
		private var item2				: InventoryItem;

		
		public function ForgingPanelView(model : ForgingModel)
		{
			this.model = model;
			
			model.setForgePanelView(this);
			
			setupForgingTable();
			setupTextBoxes();
			setupForgingListeners();
			setupForgeButtons();
			setupForgeDelayBar();
			setupForgeGridData();
		}
		
		private function setupForgingTable():void 
		{
			var margin : int = GlobalConstants.MARGIN;
			
			forgePanel = new ForgePanel();
			forgePanel.x = margin;
			forgePanel.y = margin;
			model.setForgePanel(forgePanel);
			
			var dimensions : Point = new Point(forgePanel.dimensionPanel.width, forgePanel.dimensionPanel.height);

			forgingTable = ForgingTableFactory.create(dimensions.x + margin*2, dimensions.y + margin*2);
			forgingTable.x = (GlobalConstants.STAGE_WIDTH - TABLE_WIDTH) /2;
			forgingTable.y = (GlobalConstants.STAGE_HEIGHT - TABLE_HEIGHT) /2;
			
			stageClip = model.getStageClip();
			stageClip.addChild(forgingTable);
			forgingTable.addChild(forgePanel);
		}
		
		private function setupTextBoxes():void
		{
			forgePanel.descriptionBox.editable = false;
			forgePanel.descriptionBox.textField.mouseEnabled = false;
			
			forgePanel.ingredient1Name.editable = false;
			forgePanel.ingredient1Name.textField.mouseEnabled = false;
			
			forgePanel.ingredient2Name.editable = false;
			forgePanel.ingredient2Name.textField.mouseEnabled = false;
		}
		
		private function setupForgingListeners() : void 
		{
			forgePanel.addEventListener(ForgingDataEvent.ITEM_CLICKED, onItemClicked);
			forgePanel.addEventListener(ForgingEvent.FORGE_COMPLETE, onForgeComplete);
			forgePanel.addEventListener(ForgingDataEvent.FORGE_SUCCESSFUL, onForgeSuccess);
		}
		
		private function onForgeComplete(e:Event) : void 
		{
			resetForgeView();
		}
		
		private function onForgeSuccess(event : ForgingDataEvent) : void
		{
			forgePanel.resultBox.text = String((event.data as InventoryItem).getName());
		}
		
		private function setupForgeButtons() : void 
		{
			forgePanel.forgeButton.label = GlobalConstants.FORGE_BUTTON_NAME;
			forgePanel.forgeButton.enabled = false;
			forgePanel.forgeButton.addEventListener(MouseEvent.CLICK, handleForgeButtonClicked);
			
			forgePanel.selectButton.label = GlobalConstants.SELECT_BUTTON_NAME;
			forgePanel.selectButton.enabled = false;
			forgePanel.selectButton.addEventListener(MouseEvent.CLICK, handleSelectButtonClicked);
			
			forgePanel.cancelButton.label = GlobalConstants.CANCEL_BUTTON_NAME;
			forgePanel.cancelButton.enabled = false;
			forgePanel.cancelButton.addEventListener(MouseEvent.CLICK, handleCancelButtonClicked);
		}
						
		private function handleForgeButtonClicked(e:MouseEvent):void 
		{
			clearItemText();
			resetButtons();
			forgePanel.forgeButton.addEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
			forgePanel.forgeButton.enabled = false;
		}
		
		private function handleButtonEnterFrame(e:Event):void 
		{
			if (buttonTime < buttonTimeTarget)
			{
				buttonTime += forgeSpeed;
			} else {
				buttonTime = 0;
				forgePanel.forgeButton.removeEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
				forgePanel.dispatchEvent(new ForgingEvent(ForgingEvent.FORGE_COMPLETE));
			}
			
			forgePanel.forgeDelayBar.setProgress(buttonTime, buttonTimeTarget);
		}
		
		private function handleSelectButtonClicked(e:MouseEvent):void 
		{
			dataGridController.dataGrid.selectedItem = null;
			forgePanel.selectButton.enabled = false;
			forgePanel.cancelButton.enabled = true;
			
			var currentItemNumber : int = 0;
			if (item1 == null)
			{
				forgePanel.ingredient1Name.text = selectedItem.getName();
				item1 = selectedItem;
				currentItemNumber = 1;
			} else {
				forgePanel.ingredient2Name.text = selectedItem.getName();
				item2 = selectedItem;
				forgePanel.forgeButton.enabled = true;
				currentItemNumber = 2;
			}
			
			forgePanel.dispatchEvent(new ForgingDataEvent(ForgingDataEvent.ITEM_SELECTED, [selectedItem, currentItemNumber]));
		}
		
		private function handleCancelButtonClicked(e:MouseEvent):void 
		{
			resetForgeView();
		}
		
		public function resetForgeView() : void
		{
			clearItemText();
			clearItemData();
			resetButtons();
		}
		
		private function clearItemText():void 
		{
			forgePanel.descriptionBox.text = "";
			forgePanel.ingredient1Name.text = "";
			forgePanel.ingredient2Name.text = "";
			forgePanel.resultBox.text = "";
		}
		
		private function clearItemData():void 
		{
			item1 = null;
			item2 = null;
			selectedItem = null;
		}
		
		private function resetButtons():void 
		{
			forgePanel.selectButton.enabled = false;
			forgePanel.cancelButton.enabled = false;
		}
				
		private function setupForgeDelayBar():void 
		{
			forgePanel.forgeDelayBar.indeterminate = false;
			forgePanel.forgeDelayBar.direction = ProgressBarDirection.RIGHT; 
			forgePanel.forgeDelayBar.mode = ProgressBarMode.MANUAL;
		}
		
		private function setupForgeGridData() : void 
		{
			inventoryDataParser = new InventoryDefinitionParser(GlobalConstants.FORGE_TABLE_CONTENT_PATH, model, this.createGridController);
			inventoryDataParser.init();
		}
		
		public function createGridController() : void
		{
			dataGridController = new DataGridController(model);
		}
		
		public function onItemClicked(event : ForgingDataEvent) : void
		{
			selectedItem = event.data as InventoryItem;
			
			if (item2 == null)
			{
				forgePanel.selectButton.enabled = true;
			}
		}
		
		public function destroy() : void
		{
			if (forgePanel)
			{
				if (forgePanel.hasEventListener(Event.ENTER_FRAME))
				{
					forgePanel.removeEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
				}
				
				if (forgePanel.forgeButton.hasEventListener(MouseEvent.CLICK))
				{
					forgePanel.forgeButton.removeEventListener(MouseEvent.CLICK, handleForgeButtonClicked)				
				}
				
				if (forgePanel.hasEventListener(ForgingDataEvent.ITEM_CLICKED))
				{
					forgePanel.removeEventListener(ForgingDataEvent.ITEM_CLICKED, onItemClicked);
				}
				
				if (forgePanel.hasEventListener(ForgingEvent.FORGE_COMPLETE))
				{
					forgePanel.removeEventListener(ForgingEvent.FORGE_COMPLETE, onForgeComplete);
				}
				
				if (forgePanel.hasEventListener(ForgingDataEvent.FORGE_SUCCESSFUL))
				{
					forgePanel.removeEventListener(ForgingDataEvent.FORGE_SUCCESSFUL, onForgeSuccess);
				}
				forgePanel.forgeButton.removeEventListener(MouseEvent.CLICK, handleForgeButtonClicked)
				forgePanel.parent.removeChild(forgePanel);
				forgePanel = null;
			}
			
			if (forgingTable)
			{
				forgingTable.parent.removeChild(forgingTable);
				forgingTable = null;
			}
		}
	}
}