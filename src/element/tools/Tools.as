package element.tools 
{
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	/**道具
	 * ...
	 * @author Mu
	 */
	public class Tools extends Sprite 
	{
		//死亡动画播放完成
		public static var DEAD_OVER:String = "dead_over";
		//死亡
		public static var DEADED:String = "deaded";
		//自毁
		public static var DEAD_SELF:String = "dead_self";
		
		private var deadSelfTime:Number = 10000;
		
		public var deaded:Boolean = false;
		
		private var anBody:Animation;
		public var normalAn:String;
		public var deadAn:String;
		//类型
		private var _type:Number;
		public function get type():Number{
			return _type;
		}
		public function set type(val:Boolean):void{
			_type = val;
			
			anBody.play(0, true, normalAn);
			anBody.pos( -anBody.getBounds().width / 2, -anBody.getBounds().height / 2);
			
			selfWidth = anBody.getBounds().width;
			selfHeight = anBody.getBounds().height;
			
			//this.graphics.drawRect( -selfWidth / 2+xval, -selfHeight / 2+yval, selfWidth-wval, selfHeight-hval,"#ff0000");
		}
		
		public var selfWidth:Number;
		public var selfHeight:Number;
		
		///获取碰撞矩形区域修正值
		public var xval:Number = 0;
		public var yval:Number = 0;
		public var wval:Number = 0;
		public var hval:Number = 0;
		
		public function Tools() 
		{
			anBody = new Animation();
			//anBody.interval = 100;
			this.addChild(anBody);
			
		}
		
		/**
		 * 初始化
		 */
		public function init():void{
			deaded = false;
			this.scale(0, 0);
			Tween.to(this, {scaleX:2, scaleY:2}, 150, Ease.backOut,Handler.create(this,function(){
				Tween.to(this, {scaleX:1, scaleY:1}, 150, Ease.backIn);
			}));
			deadSelfH();
		}
		
		/**
		 * 开始自毁
		 */
		private function deadSelfH():void{
			Laya.timer.once(deadSelfTime, this,dh);
		}
		
		private function dh():void{	
			deaded = true;
			deadSelfS();
		}
		
		/**
		 * 自毁操作
		 */
		private function deadSelfS():void{
			Tween.to(this, {scaleX:0, scaleY:0}, 200, Ease.backIn,Handler.create(this,function(){
				this.event(DEAD_SELF, [this]);
			}));
		}
		
		/**
		 * 死亡
		 */
		public function disposeS():void{
			Global.instance().ISPAUSE = true;
			deaded = true;
			anBody.play(0, false, deadAn);
			Laya.timer.clear(this, dh);
			anBody.once(Event.COMPLETE, this, deadAnCom);
			this.event(DEADED, [this]);
		}
		/**
		 * 死亡动画播放完
		 */
		private function deadAnCom():void{
			this.removeSelf();
			this.event(DEAD_OVER, [this]);
		}
		
		/**
		 * 获取碰撞矩形
		 * @return
		 */
		public function getHitRectangle():Rectangle{
			var global:Point = this.localToGlobal(new Point(-selfWidth/2,-selfHeight/2), true);
			var rec:Rectangle = new Rectangle(global.x+xval, global.y+yval, selfWidth-wval, selfHeight-hval);
			return rec;
		}
		
	}
}