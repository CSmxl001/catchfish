package util.tips 
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.ui.Label;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	/**
	 * ...
	 * @author Mu
	 */
	public class TipElement extends Sprite
	{
		private var AnTimes:Number = 0;//缓动时间
		private var bgs:Sprite;
		/**
		 * 单个tip元素
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
		public function TipElement(content: String, showbg: Boolean = true, 
		time: Number = 1.5, color: String = "#ffffff", size: Number = 24, font: String = "微软雅黑",
		bond: Boolean = false, bgcolor:String = "#000000", bgbordercolor:String = "#000000"):void {
			bgs = new Sprite();
			this.addChild(bgs);

			var label = new Label();
			label = new Label();
			label.align = "center";
			label.fontSize = size;
			label.color = color;
			label.text = content;
			label.bold = bond;
			label.font = font;
			bgs.addChild(label);

			var g = bgs.graphics;
			if(showbg)
				g.drawRect(0, 0, label.width + 20, label.height + 10, bgcolor, bgbordercolor, 1);
			else
				g.drawRect(0, 0, label.width + 20, label.height + 10, null, null, 1);
				
			bgs.size(label.width + 20, label.height + 10);
			this.size(label.width + 20, label.height + 10);

			label.x = (bgs.width - label.width) / 2;
			label.y = (bgs.height - label.height) / 2;

			
			AnTimes = time;
			Laya.timer.once(1000, this, disposeSelf);
		}
		
		/**
		 * 释放资源
		 */
		public function disposeSelf(val:Number=1):void {
			var self = this;
			Tween.to(bgs, {alpha: 0 },AnTimes * 1000*val, Ease.cubicIn, Handler.create(null, function(e:*=null){
				self.event("TipDisposeSelf",self);
			}));
		}
		
	}

}