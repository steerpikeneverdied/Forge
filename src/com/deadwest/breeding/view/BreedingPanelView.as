package com.deadwest.breeding.view
{
	import com.deadwest.breeding.BreederPanel;
	import com.deadwest.breeding.controller.DataGridController;
	import com.deadwest.breeding.event.BreedingEvent;
	import com.deadwest.breeding.factory.BreedingTableFactory;
	import com.deadwest.breeding.model.BreedingModel;
	import com.deadwest.breeding.model.GlobalConstants;
	import com.deadwest.breeding.parser.InventoryDefinitionParser;
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
	public class BreedingPanelView extends EventDispatcher
	{
		private var breedingTable		: Sprite;
		private var breederPanel		: BreederPanel;
		private var stageClip			: MovieClip;
		private var breederDataGrid		: DataGrid;
		
		private const TABLE_WIDTH 		: int = 500;
		private const TABLE_HEIGHT 		: int = 200;
		private var buttonTime 			: int = 0;
		private var buttonTimeTarget	: int = 100;
		private var breedSpeed			: int = 5;
		private var dataGridController	: DataGridController;
		private var inventoryDataParser : InventoryDefinitionParser;
		private var model				: BreedingModel;

		
		public function BreedingPanelView(model : BreedingModel)
		{
			this.model = model;
			
			setupBreedingTable();
			setupBreedBox();
			setupBreedingListeners();
			setupBreedButton();
			setupBreedDelayBar();
			setupBreedGridData();
		}
		
		private function setupBreedingTable():void 
		{
			var margin : int = GlobalConstants.MARGIN;
			
			breederPanel = new BreederPanel();
			breederPanel.x = margin;
			breederPanel.y = margin;
			model.setBreedPanel(breederPanel);
			
			var dimensions : Point = new Point(breederPanel.dimensionPanel.width, breederPanel.dimensionPanel.height);

			breedingTable = BreedingTableFactory.create(dimensions.x + margin*2, dimensions.y + margin*2);
			breedingTable.x = (GlobalConstants.STAGE_WIDTH - TABLE_WIDTH) /2;
			breedingTable.y = (GlobalConstants.STAGE_HEIGHT - TABLE_HEIGHT) /2;
			
			stageClip = model.getStageClip();
			stageClip.addChild(breedingTable);
			breedingTable.addChild(breederPanel);
		}
		
		private function setupBreedBox():void
		{
			breederPanel.descriptionBox.editable = false;
			breederPanel.descriptionBox.textField.mouseEnabled = false;
		}
		
		private function setupBreedingListeners():void 
		{
			addEventListener(BreedingEvent.BREED_COMPLETE, onBreedComplete);
		}
		
		private function onBreedComplete(e:Event):void 
		{
			if (breederPanel.breedDataGrid.selectedItem)
			{
				trace(breederPanel.breedDataGrid.selectedItem.Name);
			}
		}
		
		private function setupBreedButton():void 
		{
			breederPanel.breedButton.label = GlobalConstants.BREED_BUTTON_NAME;
			breederPanel.breedButton.addEventListener(MouseEvent.CLICK, handleBreedButtonClicked)
		}
						
		private function handleBreedButtonClicked(e:MouseEvent):void 
		{
			breederPanel.breedButton.addEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
			breederPanel.breedButton.enabled = false;
		}
		
		private function handleButtonEnterFrame(e:Event):void 
		{
			if (buttonTime < buttonTimeTarget)
			{
				buttonTime += breedSpeed;
			} else {
				buttonTime = 0;
				breederPanel.breedButton.removeEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
				breederPanel.breedButton.enabled = true;
				dispatchEvent(new BreedingEvent(BreedingEvent.BREED_COMPLETE));
			}
			
			breederPanel.breedDelayBar.setProgress(buttonTime, buttonTimeTarget);
		}
				
		private function setupBreedDelayBar():void 
		{
			breederPanel.breedDelayBar.indeterminate = false;
			breederPanel.breedDelayBar.direction = ProgressBarDirection.RIGHT; 
			breederPanel.breedDelayBar.mode = ProgressBarMode.MANUAL;
		}
		
		private function setupBreedGridData() : void 
		{
			inventoryDataParser = new InventoryDefinitionParser(GlobalConstants.BREED_TABLE_CONTENT_PATH, model, this.createGridController);
			inventoryDataParser.init();
		}
		
		public function createGridController() : void
		{
			dataGridController = new DataGridController(model);
		}
		
		public function destroy() : void
		{
			if (breederPanel)
			{
				if (breederPanel.hasEventListener(Event.ENTER_FRAME))
				{
					breederPanel.removeEventListener(Event.ENTER_FRAME, handleButtonEnterFrame);
				}
				breederPanel.breedButton.removeEventListener(MouseEvent.CLICK, handleBreedButtonClicked)
				breederPanel.parent.removeChild(breederPanel);
				breederPanel = null;
			}
			
			if (stageClip)
			{
				if (stageClip.hasEventListener(BreedingEvent.BREED_COMPLETE))
				{
					stageClip.removeEventListener(BreedingEvent.BREED_COMPLETE, onBreedComplete);
				}
			}
			
			if (breedingTable)
			{
				breedingTable.parent.removeChild(breedingTable);
				breedingTable = null;
			}
		}
	}
}