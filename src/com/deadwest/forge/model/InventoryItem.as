package com.deadwest.forge.model 
{
	/**
	 * @author simonh
	 */
	public class InventoryItem 
	{
		private var name 			: String;
		private var id 				: uint;
		private var rarity 			: uint;
		private var family 			: String;
		private var description 	: String;
		private var combination 	: Array;
		private var comboquantity 	: Array;
		
		public function getName() : String 
		{
			return name;
		}
		
		public function setName(name : String) : void 
		{
			this.name = name;
		}
		
		public function getId() : uint 
		{
			return id;
		}
		
		public function setId(id : uint) : void 
		{
			this.id = id;
		}
		
		public function getRarity():uint 
		{
			return rarity;
		}
		
		public function setRarity(rarity : uint) : void 
		{
			this.rarity = rarity;
		}
		
		public function getFamily() : String 
		{
			return family;
		}
		
		public function setFamily(value : String) : void 
		{
			this.family = value;
		}
		
		public function getDescription() : String 
		{
			return description;
		}
		
		public function setDescription(description : String) : void 
		{
			this.description = description;
		}
		
		public function getCombination() : Array 
		{
			return combination;
		}
		
		public function setCombination(combination : String) : void 
		{
			this.combination = combination.split(",");
		}
		
		public function getComboquantity() : Array 
		{
			return comboquantity;
		}
		
		public function setComboquantity(comboquantity : String) : void 
		{
			this.comboquantity = comboquantity.split(",");
		}
	}
}