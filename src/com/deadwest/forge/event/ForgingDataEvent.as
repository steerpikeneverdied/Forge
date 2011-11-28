package com.deadwest.forge.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author simonh
	 */
	public class ForgingDataEvent extends Event
	{
		public static const ITEM_SELECTED 			: String = "BreedingDataEvent::ITEM_SELECTED";
		
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