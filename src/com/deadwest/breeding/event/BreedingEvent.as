package com.deadwest.breeding.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author simonh
	 */
	public class BreedingEvent extends Event
	{
		public static const BREED_COMPLETE 			: String = "BreedingEvent::BREED_COMPLETE";
		public static const INGREDIENT_1_SELECTED 	: String = "BreedingEvent::INGREDIENT_1_SELECTED";
		public static const INGREDIENT_2_SELECTED 	: String = "BreedingEvent::INGREDIENT_2_SELECTED";
		
		public var name : String;
		
		public function BreedingEvent(type : String)
		{
			super(type);
		}
		
	}

}