package element.view 
{
	import laya.events.Event;
	import laya.utils.Tween;
	import ui.GameInfoUI;
	
	/**
	 * ...
	 * @author Mu
	 */
	public class ScoreView extends GameInfoUI 
	{
		private var _totalScore:Number = 0;
		public function get totalScore():Number{
			return _totalScore;
		}
		public function set totalScore(val:Number):void{
			_totalScore = val;
			_totalScore = Math.max(0, _totalScore);
			score.text = _totalScore;
			if (_totalScore <= 0){
				addPower.visible = true;
			}
		}
		
		public function ScoreView() 
		{
			addPower.visible = false;
			addPower.on(Event.CLICK, this, addPowerHand);
		}
		
		private function addPowerHand():void{
			addPower.visible = false;
			totalScore = Global.instance().totalSocre;
		}
		
	}
}