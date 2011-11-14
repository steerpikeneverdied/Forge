package com.deadwest.breeding.controller 
{
	import com.deadwest.breeding.model.BreedingModel;
	import com.deadwest.breeding.view.BreedingPanelView;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import mx.core.*;
	/**
	 * ...
	 * @author ...
	 */
	public class BreedingController 
	{
		private var breedingModel		: BreedingModel;
		private var stageClip 			: MovieClip;
		private var view				: BreedingPanelView;

		
		public function BreedingController(baseClip : MovieClip) 
		{
			this.stageClip = baseClip;
			
			createBreedingModel();
			createBreedingPanelView();
		}
		
		private function createBreedingModel() : void 
		{
			breedingModel = new BreedingModel();
			breedingModel.setStageClip(stageClip);
		}
				
		private function createBreedingPanelView() : void
		{
			this.view = new BreedingPanelView(breedingModel);
		}
		
		private function destroy() : void
		{
			if (view)
			{
				view.destroy();
				view = null;
			}
		}
	}
}