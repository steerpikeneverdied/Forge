package com.deadwest.forge.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author simonh
	 */
	public class ForgingDataEvent extends Event
	{
		public static const ITEM_CLICKED 			: String = "BreedingDataEvent::ITEM_CLICKED";
		public static const ITEM_SELECTED 			: String = "BreedingDataEvent::ITEM_SELECTED";
		public static const FORGE_SUCCESSFUL 		: String = "BreedingDataEvent::FORGE_SUCCESSFUL";
		
		public var data		: Object;
		public var name 	: String;
		
		public function ForgingDataEvent(type : String, data : Object)
		{
			super(type);
			this.data = data;
			this.name = type;
		}
		
		public override function clone() : Event 
		{
			return new ForgingDataEvent(this.name, this.data);
		}
		
	}

}