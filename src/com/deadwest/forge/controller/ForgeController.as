package com.deadwest.forge.controller 
{
	import com.deadwest.forge.model.ForgingModel;
	import com.deadwest.forge.view.ForgingPanelView;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import mx.core.*;
	/**
	 * ...
	 * @author ...
	 */
	public class ForgeController 
	{
		private var forgingModel		: ForgingModel;
		private var stageClip 			: MovieClip;
		private var view				: ForgingPanelView;

		
		public function ForgeController(baseClip : MovieClip) 
		{
			this.stageClip = baseClip;
			
			createForgingModel();
			createForgingPanelView();
		}
		
		private function createForgingModel() : void 
		{
			forgingModel = new ForgingModel();
			forgingModel.setStageClip(stageClip);
		}
				
		private function createForgingPanelView() : void
		{
			this.view = new ForgingPanelView(forgingModel);
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