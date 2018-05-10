package element.bullet 
{
	import data.BulletVo;
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.media.SoundManager;
	import laya.utils.Pool;
	import util.MathUtils;
	
	/**子弹
	 * ...
	 * @author MXL
	 */
	public class BulletFahter extends Sprite 
	{
		public static var BOOM_COM:String = "boom_com";//爆炸结束，在做一次碰撞检测
		
		
		//类型1-7
		private var _type:Number = 0;
		public function get type():Number {
			return _type;
		}
		public function set type(val:Number):void {
			_type = val;
			this.animationBody.play(0, false, this.flyAn);
			animationBody.x = -(animationBody.getBounds().width / 2);
			animationBody.y = -animationBody.getBounds().height+100;
			selfWidth = animationBody.getBounds().width;
			selfHeight = animationBody.getBounds().height;//中心点修正
			
			this.hitRadius = dataVo.powerRadius;
			setHitPoint();
		}
		public var harm:Number;//伤害
		public var hitRadius:Number;//碰撞半径
		public var deaded:Boolean = false;//子弹是否存活
		
		public var sign:String = "";//子弹类型标识
		public var flyAn:String = "";//飞行
		public var boomAn:String = "";//爆炸
		
		public var selfWidth:Number = 0;//内容宽高
		public var selfHeight:Number = 0;
		
		public var animationBody:Animation;//动画容器
		public var dataVo:BulletVo;//当前类型子弹相关数据
		public var hitPoint:Point = new Point();//碰撞中心点（局部坐标
		public var isHitFish:Boolean = false;//是否碰到鱼
		public var isHitTool:Boolean = false;//是否碰撞到道具
		public function BulletFahter() 
		{
			initData();
			initView();
			initEvent();
		}
		
		protected function initData():void {
			
		}
		
		protected function initView():void {
			if (!animationBody) {
				animationBody = new Animation();
				this.addChild(animationBody);
			}
		}
		
		protected function initEvent():void {
			
		}
		
		public function setHitPoint():void {
			if (type == 1) {
				hitPoint.setTo(0, animationBody.y + Global.instance().bulletOneValue / 2);
			}else {
				hitPoint.setTo(0, animationBody.y + Global.instance().bulletOtherValue / 2+30);
			}
		}
		
		/**
		 * 初始
		 */
		public function init():void {
			deaded = false;
			isHitFish = false;
			isHitTool = false;
			hitRadius = dataVo.powerRadius;
			Laya.timer.frameLoop(1, this, loopHand);
		}
		
		//临时记录角度
		private var tempAngle:Number = 0;
		private function loopHand():void {
			if (Global.instance().ISPAUSE) return;
			
			tempAngle = this.rotation - 90;
			this.x += Math.cos(tempAngle * Math.PI / 180) * dataVo.speed //* Global.instance().lvlAddValue;
			this.y += Math.sin(tempAngle * Math.PI / 180) * dataVo.speed //* Global.instance().lvlAddValue;
			
			setHitPoint();
			
			//如果碰到边界
			if (hitBorder() || isHitFish||isHitTool) {
				boom();
				//this.hitRadius = dataVo.boomRadius;
				Laya.timer.clear(this, loopHand);
			}
		}
		
		/**
		 * 爆炸
		 */
		public function boom():void {
			SoundManager.playSound("res/sound/bullet_boom.mp3");
			this.animationBody.play(0, false, this.boomAn);
			this.animationBody.once(Event.COMPLETE, this, boomCom);
		}
		
		/**
		 * 爆炸动画播放完成
		 */
		private function boomCom():void {
			this.hitRadius = dataVo.boomRadius;
			this.event(BOOM_COM, [this]);
		}
		
		/**
		 * 是否碰撞到边界
		 * @return
		 */
		public function hitBorder():Boolean {
			var global:Point = this.localToGlobal(hitPoint, true);
			var local:Point = this.parent.globalToLocal(global, true);
			var val:Number = 30;
			if (local.x < val || local.x > Global.instance().totalWidth - val || local.y < val || local.y > Global.instance().totalHeight - val) {
				return true;
			}
			return false;
		}
		
		/**
		 * 获取碰撞矩形
		 * @return
		 */
		public function getHitRectangle():Rectangle{
			var global:Point = this.localToGlobal(new Point(hitPoint.x-hitRadius,hitPoint.y-hitRadius), true);
			var local:Point = this.parent.globalToLocal(global, true);
			var rec:Rectangle = new Rectangle(local.x, local.y, hitRadius*2, hitRadius*2);
			return rec;
		}
		
		public function getCenter():Point{
			var global:Point = this.localToGlobal(hitPoint,true);
			return global;
		}
		
	}
}