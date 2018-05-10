package element.cannon 
{
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.media.SoundManager;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Timer;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author MXL
	 */
	public class CannonFather extends Sprite 
	{
		public static var MIN_TYPE:Number = 1;//最小类型
		public static var MAX_TYPE:Number = 7;//最大类型
		
		//类型1-7
		private var _type:Number = 0;
		public function get type():Number {
			return _type;
		}
		public function set type(val:Number):void {
			_type = val;
			animationBody.play(0, false, "cannon_normal_" + _type);
			animationBody.pivot( (animationBody.getBounds().width / 2), animationBody.getBounds().height - xiuVal);

			selfWidth = animationBody.getBounds().width;
			selfHeight = animationBody.getBounds().height;//中心点修正
			
			SoundManager.playSound("res/sound/crit.mp3");
		}
		
		public var animationBody:Animation;//动画容器
		public var shootTime:Number = 0;//记录上次发射时间
		public var shootInterval:Number = 250;//发射间隔 ms
		
		public var selfWidth:Number = 0;//内容宽高
		public var selfHeight:Number = 0;
		
		public var xiuVal:Number = 25;//中心点修正值
		public var effectBody:Animation;
		
		private var time:Timer;
		
		
		//是否增强中
		private var strongIng:Boolean = false;
		//增强时间
		private var _strongTime:Number = 0;
		public function get strongTime():Number{
			return _strongTime;
		}
		public function set strongTime(val:Number):void{
			_strongTime = val;
			_strongTime = Math.max(0, _strongTime);
			trace(_strongTime);
			if (_strongTime == 0){
				strongIng = false;
				time.clear(this, loop);
				showflash(false);
				Global.instance().shootInterTime = 1;
				Global.instance().shootPower 
			}else if (!strongIng){
				time.clear(this, loop);
				time.loop(1000, this, loop);
				strongIng = true;
				showflash(true);
				Global.instance().shootInterTime = 0.5;
				Global.instance().shootPower = 2;
			}
		}
		
		public var strongScale:Number = 1;
		
		public function CannonFather() 
		{
			initData();
			initView();
			initEvent();
		}
		
		protected function initData():void {
			time = new Timer();
		}
		
		private function loop():void{
			strongTime--;
		}
		
		protected function initView():void {
			if (!animationBody) {
				animationBody = new Animation();
				this.addChild(animationBody);
			}
			
			if (!effectBody){
				effectBody = new Animation();
				this.addChild(effectBody);
			}
			
		}
		
		protected function initEvent():void {
			
		}
		
		public function shootAn():void {
			animationBody.play(0, false, "cannon_shoot_" + type);
		}
		
		public function rotateAn(rotate:Number):void {
			this.rotation = rotate;
			//var tween:Tween = new Tween();
			//tween.to(this, { rotation:rotate }, 100, Ease.cubicOut, Handler.create(this, function() { 
				//tween.clear();
			//} ));
		}
		
		/**
		 * 特效
		 * @param	boo
		 */
		public function showflash(boo:Boolean):void{
			if (boo){
				strongScale = 1.3;
				effectBody.play(0, true, CannonManager.EFFECT_FLASH);
				effectBody.pos( -effectBody.getBounds().width / 2 - 10, -effectBody.getBounds().height / 2 - 20);
				Tween.to(this, {scaleX:strongScale, scaleY:strongScale}, 200, Ease.backOut);
			}else{
				strongScale = 1;
				effectBody.clear();
				Tween.to(this, {scaleX:strongScale, scaleY:strongScale}, 200, Ease.backIn);
			}
		}
		
	}
}