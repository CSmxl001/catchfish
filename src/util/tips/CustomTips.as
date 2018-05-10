package util.tips 
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.TimeLine;
	import laya.utils.Tween;
	
	/**自定义tips 两个tips 冒泡tip
	 * ...
	 * @author MXL
	 */
	public class CustomTips extends Sprite 
	{
		private static var _instance:CustomTips = null;
		public static function instance():CustomTips {
			if (_instance == null) {
				_instance = new CustomTips();
			}
			return _instance;
		}
		
		private var firstTip:Sprite;
		private var secondTip:Sprite;
		///当前是否开始侦听自毁事件
		private var opeDelSelf:Boolean = false;
		///不操作时，对象存在的时间次
		private var exitTime:Number = 40;
		///记录循环的次数
		private var currTime:Number = 0;
		
		private var tempW:Number = -1;
		
		/**
		 * 添加tip
		 * @param	container  容器
		 * @param	content    内容
		 * @param	logoflag   图标
		 * @param	isCenter   是否横向居中
		 * @param	posy    纵向位置
		 * @param	posx    横向位置  
		 * @param	antime    动画运动时间 
		 * @param	isAllExist  是否不自动消失
		 * @param	etime  存在多久自动销毁 20*etime 毫秒
		 * @param	logotype  logo类型 = 对错号   1 表情
		 * @param	bond  粗体
		 * @param	size  字号
		 * @param	font  字体
		 */
		public function AddTip(container:Sprite, content: String = "333434", logoflag:String = "right", isCenter:Boolean = true,
								posy:Number = 150, posx:Number = 100, antime:Number = 300, isAllExist:Boolean = false, etime:Number = 40,logotype:Number=0,
								bond: Boolean = true, size: Number = 24, font: String = "方正卡通简体"):void {
			exitTime = etime;
									
			if (!container.contains(this)) {
				container.addChild(this);
			}
			
			if (!firstTip) {
				firstTip = CreateLogoTip(content, logoflag,logotype,bond,size,font);
				an_in(firstTip,antime);
				add(this, firstTip);
				if (tempW == -1) {
					tempW = firstTip.width;
				}
			}else if (!secondTip) {
				an_out(firstTip,antime);
				secondTip = CreateLogoTip(content, logoflag,logotype,bond,size,font);
				add(this,secondTip);
				an_in_1(secondTip,antime);
				secondTip.x = firstTip.x;
			}
			
			if (isCenter) {
				centers(container, posy);
			}else {
				this.pos(posx, posy);
			}
			
			///实时检测自毁事件
			currTime = 0;
			if (!opeDelSelf && !isAllExist) {
				opeDelSelf = true;
				Laya.timer.loop(20,this,loopHand)
			}
		}
		
		/**
		 * 清除自己
		 */
		private function disposSelf():void {
			tempW = -1;
			currTime = 0;
			this.removeSelf();
			Laya.timer.clearAll(this);
		}
		
		/**
		 * 居中
		 * @param	container
		 * @param	posy
		 */
		private function centers(container:Sprite,posy:Number):void {
			this.pos((container.width - tempW) / 2, posy);
		}
		
		/**
		 * 检测自毁时间
		 */
		private function loopHand():void {
			currTime++; 
			if (currTime >= exitTime) {
				del();
			}
		}
		
		private function del():void{
			opeDelSelf = false;
			Laya.timer.clearAll(this);
			an_dl(firstTip);
			an_dl(secondTip);
			currTime = 0;
		}
		
		/**
		 * 消除自身
		 */
		public function disposeSelf():void{
			del();
		}
		
		
		/**
		 * 出 动画
		 * @param	target
		 * @param	anTime
		 */
		private function an_out(target:Sprite, anTime:Number = 400):void {
			target.alpha = 1;
			var timeLine:TimeLine = new TimeLine();
			timeLine.addLabel("aa",0).to(target, { y: -target.height/2 }, anTime, Ease.cubicOut)
				     .addLabel("bb",0).to(target, { alpha:0 }, anTime, Ease.cubicOut);
			timeLine.play(0);
			timeLine.on(Event.COMPLETE,this,function(){
				timeLine.destroy();
				target.removeSelf();
				target = null;
			})
		}
		
		/**
		 * 自毁动画
		 * @param	target
		 * @param	anTime
		 */
		private function an_dl(target:Sprite, anTime:Number = 400):void {
			if (!target) return;
			Tween.to(target,{alpha:0},anTime,Ease.cubicOut,new Handler(this,function(){
				target.removeSelf();
				if (target === firstTip) {
					target = null;
					firstTip = null;
				}
				
				if (firstTip == null && secondTip == null) {
					disposSelf();
				}
			}))
		}
		
		/**
		 * firstTip动画
		 * @param	target
		 * @param	anTime
		 */
		private function an_in(target:Sprite, anTime:Number = 400):void {
			target.alpha = 0;
			Tween.to(target, { alpha:1 }, anTime, Ease.cubicIn);
		}
		
		/**
		 * secondTip 入 动画
		 * @param	target
		 * @param	anTime
		 */
		private function an_in_1(target:Sprite, anTime:Number = 400):void {
			target.scaleY = 0;
			var self = this;
			Tween.to(target, {scaleY:1}, anTime, Ease.cubicIn,new Handler(this,function(){
				self.firstTip = self.secondTip;
				self.secondTip = null;
			}));
		}
		
		/**
		 * 添加子对象，自判断
		 * @param	father
		 * @param	sun
		 */
		private function add(father:Sprite, sun:Sprite):void {
			if (sun && !father.contains(sun)) {
				father.addChild(sun);
				sun.pos(sun.width / 2, sun.height / 2);
			}
		}
		/**
		 * 创建tip内容
		 * @param	content
		 * @param	logoflag
		 * @param	logotype
		 * @param	bond
		 * @param	size
		 * @param	font
		 * @return
		 */
		private function CreateLogoTip(content: String, logoflag:String = "right",logotype:Number=0,bond: Boolean = false,size: Number = 22, font: String = "微软雅黑"):Sprite {
			var tipContainer:Sprite = new Sprite();
			
			var infoContaienr:Sprite = new Sprite();
			var logoImg:Image = new Image();
			var bgImg:Image = new Image();
			bgImg.sizeGrid = "33,26,28,30";
			var label:Label = new Label();
			
			label.text = content;
			label.font = font;
			label.fontSize = size;
			label.height = 50;
			
			if (logoflag == "right") {
				logoImg.skin = TipsData.logoRightArr[logotype];
				bgImg.skin = TipsData.tipRightArr[logotype];	
				label.color = TipsData.rightColorArr[logotype];
			}else if (logoflag == "wrong") {
				logoImg.skin = TipsData.logoWrongArr[logotype];
				bgImg.skin = TipsData.tipWrongArr[logotype];	
				label.color = TipsData.wrongColorArr[logotype];
			}else if (logoflag == "warn") {
				logoImg.skin = TipsData.logoWarnArr[logotype];
				bgImg.skin = TipsData.tipWarnArr[logotype];	
				label.color = TipsData.warnColorArr[logotype];
			}
			
			bgImg.size(label.width + 200, 50);
			infoContaienr.width = bgImg.width;
			label.pos((bgImg.width - label.textField.textWidth) / 2, (bgImg.height - label.textField.textHeight) / 2);
			
			tipContainer.addChild(infoContaienr);
			infoContaienr.addChild(bgImg);
			infoContaienr.addChild(label);
			infoContaienr.pos(logoImg.width-1, 0);
			tipContainer.addChild(logoImg);
			tipContainer.size(logoImg.width + bgImg.width, logoImg.height);
			
			tipContainer.pivot(tipContainer.width / 2, tipContainer.height / 2);
			
			return tipContainer;
		}
		
	}

}