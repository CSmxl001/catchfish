package element.view 
{
	import ui.InfoLogUI;
	
	/**
	 * ...
	 * @author Mu
	 */
	public class InfoLog extends InfoLogUI 
	{
		
		public function InfoLog() 
		{
			btn_close.name = CLOSE;
		}
		
		override public function close(type:String = null):void 
		{
			super.close(type);
			//Global.instance().ISPAUSE = false;
		}
		
		override protected function _open(modal:Boolean, closeOther:Boolean):void 
		{
			super._open(modal, closeOther);
			
			//Global.instance().ISPAUSE = true;
		}
	}

}