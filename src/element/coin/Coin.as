package element.coin 
{
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author MXL
	 */
	public class Coin extends Sprite 
	{
		public static var MOVE_END:String = "move_end";//移动结束
	
		//类型 金币 银币
		private var _type:String = "";
		public function get type():String{
			return _type;
		}
		public function set type(ts:String):void{
			_type = ts;
			animationBody.play(0, true, type);
			animationBody.pos(-animationBody.getBounds().width / 2, -animationBody.getBounds().height / 2);
			this.size(animationBody.getBounds().width, animationBody.getBounds().height);
		}
		
		public var animationBody:Animation;//动画
		
		public function Coin() 
		{
			initView();
		}
		
		protected function initView():void {
			if (!animationBody) {
				animationBody = new Animation();
				this.addChild(animationBody);
			}
		}
		/**
		 * 移动到指定位置
		 * @param	xx
		 * @param	yy
		 * @param	delay
		 */
		public function moveToPos(xx:Number, yy:Number, delay:Number):void{
			var _this = this;
			Laya.timer.once(delay,this,function(){
				Tween.to(_this,{x:xx,y:yy},200,Ease.linearIn,new Handler(_this,function(){
					_this.event(MOVE_END, [_this]);
				}));
			})
		}
		
	}
}