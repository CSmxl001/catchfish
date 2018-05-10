package element.view 
{
	import laya.display.Sprite;
	import laya.ui.HSlider;
	import laya.ui.ProgressBar;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author Mu
	 */
	public class HpSlider extends Sprite 
	{
		public var slider:ProgressBar;
		public var max:Number;
		public var tween:Tween;
		public function HpSlider() 
		{
			initView();
		}
		
		private function initView():void{
			slider = new ProgressBar("fish/img/progress_1.png");
			this.addChild(slider);
			slider.sizeGrid = "3,2,2,3";
			slider.width = 150;
			slider.height = 10;
			this.size(150, 10);
			this.alpha = 0;
			
			tween = new Tween();
		}
		
		/**
		 * 设置数据
		 * @param	hp
		 */
		public function setData(hp:Number):void{
			slider.value = (hp / max);
		}
		
		/**
		 * 血条
		 * @param	hp
		 * @param	delay
		 */
		public function showSelf(hp:Number,delay:Number = 1500):void{
			setData(hp);
			
			this.alpha = 1;
			tween.clear();
			Laya.timer.once(delay,this,function(){
				tween.to(this, {alpha:0}, 200,null);
			})
		}
		
		
	}
}