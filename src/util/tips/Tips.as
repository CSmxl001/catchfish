package util.tips 
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.resource.Texture;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.ui.View;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author Mu
	 */
	public class Tips 
	{
		/**单个tip
		 * @param	contaienr  主容器
		 * @param	content  内容
		 * @param	showbg  是否显示背景
		 * @param	iscenter  是否居中
		 * @param	xx  x坐标
		 * @param	yy  y坐标
		 * @param	time  动画时间
		 * @param	color 字体颜色
		 * @param	size  字号
		 * @param	font  字体
		 * @param	bond  文字加粗
		 * @param	bgcolor  背景颜色
		 * @param	bgbordercolor  背景边框颜色
		 */
		public static function createTips(contaienr: Node, content: String, showbg: Boolean = true, iscenter: Boolean = true, color: String = "#ffffff", alpha:Number = 0.8, posy:Number = 100, bond: Boolean = false, bgcolor:String = "#000000", bgbordercolor:String = "#000000", size: Number = 20, font: String = "华文细黑", xx: Number = 0, yy: Number = 0, time: Number = 0.5,delayTime:Number=1): void {
			var bgs: Sprite = new Sprite();
			contaienr.addChild(bgs);
			
			var label = new Label();
			label = new Label();
			label.align = "center";
			label.fontSize = size;
			label.color = color;
			label.text = content;
			label.bold = bond;
			label.font = font;
			bgs.addChild(label);
			
			var lw:Number = Math.floor(label.textField.textWidth);
			var lh:Number = Math.floor(label.textField.textHeight);
			
			var g = bgs.graphics;
			g.drawRect(0, 0, lw + 20, lh + 10, bgcolor, bgbordercolor, 1);
			bgs.size(lw + 20, lh + 10);

			bgs.alpha = alpha;
			
			label.x = (bgs.width - lw) / 2;
			label.y = (bgs.height - lh) / 2;
			
			if (iscenter) {
				bgs.x = (1024 - bgs.width) / 2;
				bgs.y = posy;
			} else {
				bgs.x = xx;
				bgs.y = yy;
			}

			bgs.visible = showbg;

			Laya.timer.once(delayTime*1000, null, function() {
				Tween.to(bgs, { y: bgs.y - 20, alpha: 0 }, time * 1000, Ease.cubicIn, Handler.create(null, function(e:*=null){
					contaienr.removeChild(bgs);
				}));
			} );
			
		}
		
		/**
		 * 带有logo的tips
		 * @param	contaienr 当前tip的容器
		 * @param	content   文字描述
		 * @param	logoflag  logo图片
		 * @param	iscenter  是否居中
		 * @param	posy      容器中的y位置
		 * @param	bond      字体是否加粗
		 * @param	delayTime  停留时间
		 * @param	time       缓动时间
		 * @param	size       字号
		 * @param	font       字体
		 * @param	xx
		 * @param	yy
		 */
		public static function createLogoTips(contaienr: Node, content: String, logoflag:String = "right", iscenter: Boolean = true,posy:Number = 100, bond: Boolean = false,delayTime:Number = 1,time: Number = 0.5, size: Number = 22, font: String = "微软雅黑",xx: Number = 0, yy: Number = 0):void {
			var tipContainer:Sprite = new Sprite();
			contaienr.addChild(tipContainer);
			
			var infoContaienr:Sprite = new Sprite();
			var logoImg:Image = new Image();
			var bgImg:Image = new Image();
			bgImg.sizeGrid = "12,13,13,13";
			var label:Label = new Label();
			
			label.text = content;
			label.font = font;
			label.fontSize = size;
			label.height = 30;
			
			if (logoflag == "right") {
				logoImg.skin = "template/customComp/tip/right.png";
				bgImg.skin = "template/customComp/tip/right_bg.png";	
				label.color = "#006666";
			}else if (logoflag == "wrong") {
				logoImg.skin = "template/customComp/tip/wrong.png";
				bgImg.skin = "template/customComp/tip/wrong_bg.png";	
				label.color = "#cc0000";
			}else if (logoflag == "warn") {
				logoImg.skin = "template/customComp/tip/warn.png";
				bgImg.skin = "template/customComp/tip/warn_bg.png";	
				label.color = "#CC6600";
			}
			
			bgImg.size(label.width + 20, 50);
			infoContaienr.width = bgImg.width;
			label.pos((bgImg.width - label.width) / 2, (bgImg.height - label.height) / 2);
			
			tipContainer.addChild(infoContaienr);
			infoContaienr.addChild(bgImg);
			infoContaienr.addChild(label);
			infoContaienr.pos(logoImg.width, 0);
			tipContainer.addChild(logoImg);
			tipContainer.size(logoImg.width + bgImg.width, logoImg.height);
			
			
			if (iscenter) {
				tipContainer.pos((1024 - tipContainer.width) / 2, posy);
			}else {
				tipContainer.pos(xx, yy);
			}
			
			Laya.timer.once(delayTime*1000, null, function() {
				Tween.to(tipContainer, { y: tipContainer.y - 20, alpha: 0 }, time * 1000, Ease.cubicIn, Handler.create(null, function(e:*=null){
					tipContainer.removeSelf();
				}));
			} );
		}
		
	}
}