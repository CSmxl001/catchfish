package util.tips 
{
	import laya.display.Node;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Ease;
	import laya.utils.Tween;
	
	/**一大波tip
	 * ...
	 * @author Mu
	 */
	public class TipManager extends Sprite 
	{
		private static var _instance:TipManager = null;
		public static function instance():TipManager {
			if (_instance == null) {
				_instance = new TipManager();
			}
			return _instance;
		}
		
		private var tipArr:Array = [];
		private var maxNum:Number = 5;
		private var starty:Number = 100;
		private var moveSpace:Number = 40;
		/**
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
		public function createTip(container:Node,content: String, showbg: Boolean = true, iscenter: Boolean = true, 
		xx: Number = 0, yy: Number = 0, time: Number = 0.5, color: String = "#ffffff", size: Number = 24, font: String = "华文细黑",
		bond: Boolean = false, bgcolor:String = "#000000", bgbordercolor:String = "#000000"):void {
			movetip(tipArr);
			
			var tip:TipElement = new TipElement(content, showbg, time, color, size, font, bond, bgcolor, bgbordercolor);
			if (iscenter) {
				tip.x = (1024 - tip.width) / 2;
				tip.y = starty;
			}else {
				tip.x = xx;
				tip.y = yy;
			}
			container.addChild(tip);
			
			tipArr.push(tip);
			tip.on("TipDisposeSelf", this, diposeSelf);
		}
		/**
		 * 向上移动tip
		 * @param	arr
		 */
		private function movetip(arr:Array):void {
			for (var i:Number = 0; i < arr.length; i++) {
				var item:TipElement = arr[i] as TipElement;
				item.alpha = (0.15 * (i+1)>0.7)?0.7:0.15 * (i+1);
				Tween.to(item, { y:item.y - moveSpace}, 120, Ease.cubicIn);
			}
		}
		/**
		 * 销毁自己
		 * @param	data
		 */
		private function diposeSelf(data:*):void {
			deposeTip(data);
		}
		/**
		 * 清除数据
		 * @param	tip
		 */
		private function deposeTip(tip:TipElement):void {
			if (this.tipArr.indexOf(tip)!=-1) {
				this.tipArr.splice(this.tipArr.indexOf(tip), 1);
				tip.removeSelf();
			}
		}
	}
}