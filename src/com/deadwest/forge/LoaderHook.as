package com.deadwest.forge
{
	import com.deadwest.forge.controller.ForgeController;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon Hill
	 */
	[Frame(factoryClass="com.deadwest.forge.Preloader")]
	public class LoaderHook extends Sprite 
	{
		private var breedingController	: ForgeController;
		private var baseClip			: MovieClip;

		public function LoaderHook() : void
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function handleEnterFrame(e:Event) : void 
		{
		}

		private function init(e:Event = null) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			baseClip = new MovieClip();
			
			stage.addChild(baseClip);
			
			breedingController = new ForgeController(baseClip);
		}
		
		public function destroy() : void
		{
			removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

	}

}