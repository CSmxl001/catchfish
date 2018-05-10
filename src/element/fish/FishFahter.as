package element.fish 
{
	import data.FishVo;
	import element.view.HpSlider;
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.ui.Label;
	import laya.utils.Pool;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author MXL
	 */
	public class FishFahter extends Sprite 
	{
		public static var FISH_DEAD:String = "fish_dead";//鱼死亡
		public static var FISH_DEAD_SELF:String = "fish_dead_self";//自身死亡
		
		public var dirStr:String = "";//游向
		
		private var _fishVo:FishVo;//数据
		public function get fishVo():FishVo{
			return _fishVo;
		}
		public function set fishVo(vo:FishVo):void{
			_fishVo = vo;
		}
		
		public var animationBody:Animation;//动画主体
		
		//id
		private var _id:Number;
		public function get id():Number {
			return _id;
		}
		public function set id(val:Number):void {
			_id = val;
			
			animationBody.play(0, true, fishVo.leveAn);
			//animationBody.x = -(animationBody.getBounds().width) / 2;
			//animationBody.y = -(animationBody.getBounds().height) / 2;
			selfWidth = animationBody.getBounds().width;
			selfHeight = animationBody.getBounds().height;
			animationBody.pivot(selfWidth / 2, selfHeight / 2);
			animationBody.pos(0, 0);
			
			hpSlider.slider.width = selfWidth;
			hpSlider.slider.height = 5;
			hpSlider.size(selfWidth, 5);
			hpSlider.pos(-hpSlider.width / 2, -(selfHeight-fishVo.hitValue)/2);
			
			//血量
			var maxHp:Number = Math.floor(fishVo.blood_min + Math.random() * (fishVo.blood_Max - fishVo.blood_min));//血量
			hpSlider.max = maxHp;
			hp = maxHp;
			
			//this.graphics.drawRect(animationBody.x, animationBody.y+fishVo.hitValue, selfWidth, selfHeight - fishVo.hitValue*2, "#ff0000");
		}
		
		//血量
		private var _hp:Number;
		public function get hp():Number{
			return _hp;
		}
		public function set hp(val:Number):void{
			_hp = val;
			
			hpSlider.showSelf(_hp);
			
			if (_hp <= 0){
				fishDead();
			}
		}
		
		public var selfWidth:Number = 0;//内容宽高
		public var selfHeight:Number = 0;
		public var dead:Boolean = false;
		public var label:Label;
		public var hpSlider:HpSlider;
		public var isInOrder:Boolean = false;//是否位于队列中
		/**
		 * 构造函数
		 */
		public function FishFahter() 
		{
			initData();
			initView();
			initEvent();
		}
		
		/**
		 * 初始化数据
		 */
		protected function initData():void {
			
		}
		
		/**
		 * 初始化界面
		 */
		protected function initView():void {
			if (!animationBody) {
				animationBody = new Animation();
				animationBody.interval = 100;
				this.addChild(animationBody);
			}
			
			hpSlider = new HpSlider();
			this.addChild(hpSlider);
		}
		
		/**
		 * 初始化事件
		 */
		protected function initEvent():void {
			
		}
		
		/**
		 * 初始化
		 * @param	dir  出现位置在屏幕两侧 left right
		 * @param	spos 起始坐标，不设置则随机
		 */
		public function init(dir:String="right",spos:Point=null,order:Boolean = false):void{
			dead = false;
			isInOrder = order;
			hp = hpSlider.max;
			dirStr = dir;
			this.animationBody.rotation = (dir == "right")?0:180;
			
			var times:Number;
			if (!spos) {
				//打乱出现次序
				times= Math.random() * 1000;
				resetPos();
			}else {
				times = 1000;
				this.pos(spos.x, spos.y);
			}
			
			Laya.timer.once(times, this, function(){
				Laya.timer.frameLoop(1, this, loopHand);
			});
		}
		
		/**
		 * 循环函数
		 */
		private function loopHand():void{
			if (Global.instance().ISPAUSE) return;
			moveOver();
		}
		
		/**
		 * 移动结束
		 */
		private function moveOver():void{
			if (dirStr == "right"){
				this.x += this.fishVo.speed*Global.instance().lvlAddValue;
				if (this.x >= Global.instance().totalWidth + selfWidth) {
					if (isInOrder) {
						selfDed();
					}else {
						resetPos();
					}
				}
			}else if(dirStr=="left"){
				this.x -= this.fishVo.speed*Global.instance().lvlAddValue;
				if (this.x <= - selfWidth*2){
					if (isInOrder) {
						selfDed();
					}else {
						resetPos();
					}
				}
			}
		}
		
		/**
		 * 重置初始位置
		 */
		private function resetPos():void{
			var startx:Number;
			var starty:Number = 50+(Global.instance().totalHeight-150) * Math.random();
			
			if (dirStr == "right"){
				startx = -selfWidth - Math.random() * 200;
			}else if(dirStr=="left"){
				startx = Global.instance().totalWidth +selfWidth+ Math.random() * 200;
			}
			
			this.pos(startx, starty);
		}
		
		/**
		 * 鱼死亡
		 */
		private function fishDead():void{
			dead = true;
			animationBody.play(0, false, fishVo.deadAn);
			animationBody.once(Event.COMPLETE, this, deadCom);
			Laya.timer.clear(this, loopHand);
		}
		
		/**
		 * 死亡动画播放完成
		 */
		private function deadCom():void{
			this.removeSelf();
			this.event(FISH_DEAD, [this]);
			Pool.recover(fishVo.fishInfo, this);
		}
		
		/**
		 * 自身死亡，不是被击中死亡
		 */
		private function selfDed():void {
			this.removeSelf();
			this.event(FISH_DEAD_SELF, [this]);
			Pool.recover(fishVo.fishInfo, this);
			Laya.timer.clear(this, loopHand);
		}
		
		/**
		 * 获取碰撞矩形
		 * @return
		 */
		public function getHitRectangle():Rectangle{
			var global:Point = this.localToGlobal(new Point(-selfWidth/2, -selfHeight/2+fishVo.hitValue), true);
			var rec:Rectangle = new Rectangle(global.x, global.y, selfWidth, selfHeight - fishVo.hitValue*2);
			return rec;
		}
	}
}