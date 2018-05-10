package element.view 
{
	import laya.events.Event;
	import laya.utils.Handler;
	import laya.utils.Tween;
	import ui.LoadingUI;
	
	/**
	 * ...
	 * @author Mu
	 */
	public class LoadingView extends LoadingUI 
	{
		private var tw:Number = 360;
		
		public function LoadingView() 
		{
			btn_start.visible = false;
			btn_start.once(Event.CLICK, this, starHand);
		}
		
		public function setData(val:Number):void{
			bars.width = val * tw;
			if (val >= 1){
				btn_start.visible = true;
			}
		}
		
		private function starHand():void{
			Tween.to(this,{alpha:0},120,null,Handler.create(this,function(){
				this.event("startgame");
			}))
		}
		
	}
}