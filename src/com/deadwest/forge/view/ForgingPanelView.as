package com.deadwest.forge.view
{
	import com.deadwest.forge.ForgePanel;
	import com.deadwest.forge.controller.DataGridController;
	import com.deadwest.forge.event.ForgingEvent;
	import com.deadwest.forge.factory.ForgingTableFactory;
	import com.deadwest.forge.model.ForgingModel;
	import com.deadwest.forge.model.GlobalConstants;
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

		
		public function ForgingPanelView(model : ForgingModel)
		{
			this.model = model;
			
			setupForgingTable();
			setupForgeBox();
			setupForgingListeners();
			setupForgeButton();
			setupForgeDelayBar();
			setupForgeGridData();
		}
		
		private function setupForgingTable():void 
		{
			var margin : int = GlobalConstants.MARGIN;
			
			forgePanel = new BreederPanel();
			forgePanel.x = margin;
			forgePanel.y = margin;
			model.setForgePanel(forgePanel);
			
			var dimensions : Point = new Point(forgePanel.dimensionPanel.width, forgePanel.dimensionPanel.height);

			forgingTable = BreedingTableFactory.create(dimensions.x + margin*2, dimensions.y + margin*2);
			forgingTable.x = (GlobalConstants.STAGE_WIDTH - TABLE_WIDTH) /2;
			forgingTable.y = (GlobalConstants.STAGE_HEIGHT - TABLE_HEIGHT) /2;
			
			stageClip = model.getStageClip();
			stageClip.addChild(forgingTable);
			forgingTable.addChild(forgePanel);
		}
		
		private function setupForgeBox():void
		{
			forgePanel.descriptionBox.editable = false;
			forgePanel.descriptionBox.textField.mouseEnabled = false;
		}
		
		private function setupForgingListeners():void 
		{
			addEventListener(ForgingEvent.FORGE_COMPLETE, onForgeComplete);
		}
		
		private function onForgeComplete(e:Event):void 
		{
			if (forgePanel.breedDataGrid.selectedItem)
			{
				trace(forgePanel.breedDataGrid.selectedItem.Name);
			}
		}
		
		private function setupForgeButton():void 
		{
			forgePanel.forgeButton.label = GlobalConstants.FORGE_BUTTON_NAME;
			forgePanel.forgeButton.addEventListener(MouseEvent.CLICK, handleForgeButtonClicked);
		}
						
		private function handleForgeButtonClicked(e:MouseEvent):void 
		{
			forgePanel.forgeButton.addEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
			forgePanel.forgeButton.enabled = false;
		}
		
		private function handleButtonEnterFrame(e:Event):void 
		{
			if (buttonTime < buttonTimeTarget)
			{
				buttonTime += breedSpeed;
			} else {
				buttonTime = 0;
				forgePanel.forgeButton.removeEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
				forgePanel.forgeButton.enabled = true;
				dispatchEvent(new ForgingEvent(ForgingEvent.FORGE_COMPLETE));
			}
			
			forgePanel.forgeDelayBar.setProgress(buttonTime, buttonTimeTarget);
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
		
		public function destroy() : void
		{
			if (forgePanel)
			{
				if (forgePanel.hasEventListener(Event.ENTER_FRAME))
				{
					forgePanel.removeEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
				}
				forgePanel.forgeButton.removeEventListener(MouseEvent.CLICK, handleForgeButtonClicked)
				forgePanel.parent.removeChild(forgePanel);
				forgePanel = null;
			}
			
			if (stageClip)
			{
				if (stageClip.hasEventListener(ForgingEvent.FORGE_COMPLETE))
				{
					stageClip.removeEventListener(ForgingEvent.FORGE_COMPLETE, onBreedComplete);
				}
			}
			
			if (forgingTable)
			{
				forgingTable.parent.removeChild(forgingTable);
				forgingTable = null;
			}
		}
	}
}