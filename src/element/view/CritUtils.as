package element.view 
{
	import laya.display.Sprite;
	import laya.ui.Image;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	/**暴击
	 * ...
	 * @author Mu
	 */
	public class CritUtils extends Sprite 
	{
		private var img:Image;
		public function CritUtils(val:Number) 
		{
			img = new Image("fish/img/bj000"+(val-1)+".png");
			img.pivot(img.width / 2, img.height / 2);
			this.addChild(img);
			
			show();
		}
		
		private function show():void{
			this.scale(0, 0);
			this.alpha = 0;
			Tween.to(this, {scaleX:1.5, scaleY:1.5,alpha:1}, 150, Ease.cubicOut,Handler.create(this,function(){
				Tween.to(this, {scaleX:1, scaleY:1}, 150, Ease.backOut,Handler.create(this,function(){
					Laya.timer.once(800, this, timeHand);
				}));
			}));
		}
		
		private function timeHand():void{
			Tween.to(this, {scaleX:0, scaleY:0,alpha:0}, 200, Ease.bounceOut,Handler.create(this,function(){
				this.removeSelf();
			}));
		}
		
	}

}