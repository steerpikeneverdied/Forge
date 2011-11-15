package com.deadwest.forge.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author simonh
	 */
	public class ForgingEvent extends Event
	{
		public static const FORGE_COMPLETE 			: String = "BreedingEvent::FORGE_COMPLETE";
		public static const INGREDIENT_1_SELECTED 	: String = "BreedingEvent::INGREDIENT_1_SELECTED";
		public static const INGREDIENT_2_SELECTED 	: String = "BreedingEvent::INGREDIENT_2_SELECTED";
		
		public var name : String;
		
		public function ForgingEvent(type : String)
		{
			super(type);
		}
		
	}

}