package com.deadwest.breeding.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author simonh
	 */
	public class BreedingEvent extends Event
	{
		public static const BREED_COMPLETE : String = "BreedingEvent::BREED_COMPLETE";
		
		public var name : String;
		
		public function BreedingEvent(type : String)
		{
			super(type);
		}
		
	}

}