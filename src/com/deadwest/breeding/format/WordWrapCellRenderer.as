package com.deadwest.breeding.format
{

	import fl.controls.listClasses.CellRenderer;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class WordWrapCellRenderer extends CellRenderer
	{
		private var tf:TextFormat;

		public function WordWrapCellRenderer()
		{
			tf = new TextFormat();
			tf.align = TextFormatAlign.LEFT;
		}

		override protected function drawLayout():void
		{
			textField.setTextFormat(tf);
			textField.wordWrap = true;
			super.drawLayout();
		}
	}
}