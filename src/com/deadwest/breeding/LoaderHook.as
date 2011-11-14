package com.deadwest.breeding
{
	import com.deadwest.breeding.controller.BreedingController;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon Hill
	 */
	[Frame(factoryClass="com.deadwest.breeding.Preloader")]
	public class LoaderHook extends Sprite 
	{
		private var breedingController	: BreedingController;
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
			
			breedingController = new BreedingController(baseClip);
		}
		
		public function destroy() : void
		{
			removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

	}

}