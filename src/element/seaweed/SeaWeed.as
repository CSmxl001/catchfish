package element.seaweed 
{
	import laya.display.Animation;
	import laya.display.Sprite;
	/**
	 * ...
	 * @author MXL
	 */
	public class SeaWeed extends Sprite
	{
		public var animationBody:Animation;//动画主体
		public function SeaWeed() 
		{
			if (!animationBody) {
				animationBody = new Animation();
				animationBody.interval = 100;
				this.addChild(animationBody);
			}
		}
		
	}

}