package element.tools 
{
	import laya.display.Animation;
	import laya.media.SoundManager;
	import laya.utils.Pool;
	/**
	 * ...
	 * @author Mu
	 */
	public class ToolsManager 
	{
		private static var _instance:ToolsManager = new ToolsManager();
		public static function instance():ToolsManager {
			return _instance;
		}
		
		//动画标识
		//鱼雷
		public static var BOMB_NORMAL:String = "bomb_normal";
		public static var BOMB_BOOM:String = "bomb_boom";
		//宝箱
		public static var BOX_NORMAL:String = "box_normal";
		public static var BOX_OPEN:String = "box_open";
		//力量
		public static var POWER_NORMAL:String = "power_normal";
		public static var POWER_OPEN:String = "power_open";
		//鱼饵
		public static var FOOD_NORMAL:String = "food_normal";
		public static var FOOD_EAT:String = "food_eat";
		
		//类型
		public static var TYPE_BOOM:Number = 1;
		public static var TYPE_BOX:Number = 2;
		public static var TYPE_POWER:Number = 3;
		public static var TYPE_Food:Number = 4;
		
		//道具集合
		public var toolArr:Array = [];
		
		/**
		 * 缓存动画
		 */
		public function cacheAnimation():void {
			//bomb
			Animation.createFrames("res/atlas/fish/tools/boom.json", BOMB_BOOM);
			Animation.createFrames(["fish/tools/boom/boom0001.png"], BOMB_NORMAL);
			
			//宝箱
			Animation.createFrames(["fish/tools/bx.png"], BOX_NORMAL);
			Animation.createFrames(["fish/tools/bx.png"], BOX_OPEN);
			
			//力量
			Animation.createFrames(["fish/tools/power.png"], POWER_NORMAL);
			Animation.createFrames(["fish/tools/power.png"], POWER_OPEN);
			
			//鱼饵
			Animation.createFrames(["fish/tools/fishfood.png"], FOOD_NORMAL);
			Animation.createFrames(["fish/tools/fishfood.png"], FOOD_EAT);
		}
		
		/**
		 * 创建
		 * @param	type
		 * @return
		 */
		public function createToolByType(type:Number):Tools{
			var tool:Tools = Pool.getItemByClass(type, Tools);
			switch(type){
				case 1:
					tool.normalAn = BOMB_NORMAL;
					tool.deadAn = BOMB_BOOM;
					
					tool.xval = 40;
					tool.yval = 40;
					tool.wval = 90;
					tool.hval = 60;
					break;
				case 2:
					tool.normalAn = BOX_NORMAL;
					tool.deadAn = BOX_OPEN;
					break;
				case 3:
					tool.normalAn = POWER_NORMAL;
					tool.deadAn = POWER_OPEN;
					break;
				case 4:
					tool.normalAn = FOOD_NORMAL;
					tool.deadAn = FOOD_EAT;
					break;
			}
			
			tool.type = type;
			tool.once(Tools.DEAD_OVER, this, deadAnOver);
			tool.once(Tools.DEADED, this, deadedOver);
			tool.once(Tools.DEAD_SELF, this, deadedSelfOver);
			
			tool.init();
			
			toolArr.push(tool);
			SoundManager.playSound("res/sound/tool.mp3");
			return tool;
		}
		
		/**
		 * 死亡动画结束
		 * @param	tools
		 */
		public function deadAnOver(tools:Tools):void{
			var index:Number = toolArr.indexOf(tools);
			toolArr.splice(index, 1);
		}
		
		/**
		 * 死亡
		 * @param	tools
		 */
		public function deadedOver(tools:Tools):void{
			
		}
		
		/**
		 * 自毁结束
		 * @param	tools
		 */
		public function deadedSelfOver(tools:Tools):void{
			var index:Number = toolArr.indexOf(tools);
			toolArr.splice(index, 1);
		}
		}
		
		/**
		 * 回收
		 * @param	tool
		 */
		public function recover(tool:Tools):void{
			tool.removeSelf();
			Pool.recover(tool.type, tool);
		}
		
	}
}