package element.fish 
{
	import data.DataProxy;
	import data.FishVo;
	import laya.display.Animation;
	import laya.maths.Point;
	import laya.utils.Pool;
	/**
	 * ...
	 * @author MXL
	 */
	public class FishManager 
	{
		/**
		 * 单利类
		 */
		private static var _instance:FishManager;
		public static function instance():FishManager {
			if (!_instance) {
				_instance = new FishManager();
			}
			return _instance;
		}
		
		//鱼正常状态
		public static var FISH_NORMAL_1:String = "fish_normal_1";
		public static var FISH_NORMAL_2:String = "fish_normal_2";
		public static var FISH_NORMAL_3:String = "fish_normal_3";
		public static var FISH_NORMAL_4:String = "fish_normal_4";
		public static var FISH_NORMAL_5:String = "fish_normal_5";
		public static var FISH_NORMAL_6:String = "fish_normal_6";
		public static var FISH_NORMAL_7:String = "fish_normal_7";
		public static var FISH_NORMAL_8:String = "fish_normal_8";
		public static var FISH_NORMAL_9:String = "fish_normal_9";
		public static var FISH_NORMAL_10:String = "fish_normal_10";
		public static var FISH_NORMAL_11:String = "fish_normal_11";
		public static var FISH_NORMAL_12:String = "fish_normal_12";
		
		//鱼死亡状态
		public static var FISH_DEAD_1:String = "fish_dead_1";
		public static var FISH_DEAD_2:String = "fish_dead_2";
		public static var FISH_DEAD_3:String = "fish_dead_3";
		public static var FISH_DEAD_4:String = "fish_dead_4";
		public static var FISH_DEAD_5:String = "fish_dead_5";
		public static var FISH_DEAD_6:String = "fish_dead_6";
		public static var FISH_DEAD_7:String = "fish_dead_7";
		public static var FISH_DEAD_8:String = "fish_dead_8";
		public static var FISH_DEAD_9:String = "fish_dead_9";
		public static var FISH_DEAD_10:String = "fish_dead_10";
		public static var FISH_DEAD_11:String = "fish_dead_11";
		public static var FISH_DEAD_12:String = "fish_dead_12";
		
		//缓存标识
		public static var FISH_INFO_1:String = "fish_info_1";
		public static var FISH_INFO_2:String = "fish_info_2";
		public static var FISH_INFO_3:String = "fish_info_3";
		public static var FISH_INFO_4:String = "fish_info_4";
		public static var FISH_INFO_5:String = "fish_info_5";
		public static var FISH_INFO_6:String = "fish_info_6";
		public static var FISH_INFO_7:String = "fish_info_7";
		public static var FISH_INFO_8:String = "fish_info_8";
		public static var FISH_INFO_9:String = "fish_info_9";
		public static var FISH_INFO_10:String = "fish_info_10";
		public static var FISH_INFO_11:String = "fish_info_11";
		public static var FISH_INFO_12:String = "fish_info_12";
		
		/**
		 * 缓存子弹爆炸效果
		 */
		public function cacheAnimation():void {
			///id 0 小丑鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish12/live.json",FISH_NORMAL_1);
			Animation.createFrames("res/atlas/fish/fishimg/fish12/dead.json",FISH_DEAD_1);
			
			///id 1 蜻蜓鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish8/live.json",FISH_NORMAL_2);
			Animation.createFrames("res/atlas/fish/fishimg/fish8/dead.json", FISH_DEAD_2);
			
			///id 2 黄鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish5/live.json",FISH_NORMAL_3);
			Animation.createFrames("res/atlas/fish/fishimg/fish5/dead.json", FISH_DEAD_3);
			
			///id 3 热带鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish9/live.json",FISH_NORMAL_4);
			Animation.createFrames("res/atlas/fish/fishimg/fish9/dead.json", FISH_DEAD_4);
			
			///id 4 金枪鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish7/live.json",FISH_NORMAL_5);
			Animation.createFrames("res/atlas/fish/fishimg/fish7/dead.json", FISH_DEAD_5);
			
			///id 5 水母
			Animation.createFrames("res/atlas/fish/fishimg/fish10/live.json",FISH_NORMAL_6);
			Animation.createFrames("res/atlas/fish/fishimg/fish10/dead.json", FISH_DEAD_6);
			
			///id 6 鳄鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish2/live.json",FISH_NORMAL_7);
			Animation.createFrames("res/atlas/fish/fishimg/fish2/dead.json", FISH_DEAD_7);
			
			///id 7 大乌龟
			Animation.createFrames("res/atlas/fish/fishimg/fish11/live.json",FISH_NORMAL_8);
			Animation.createFrames("res/atlas/fish/fishimg/fish11/dead.json", FISH_DEAD_8);
			
			///id 8 海豚
			Animation.createFrames("res/atlas/fish/fishimg/fish4/live.json",FISH_NORMAL_9);
			Animation.createFrames("res/atlas/fish/fishimg/fish4/dead.json", FISH_DEAD_9);
			
			///id 9 鲸鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish6/live.json",FISH_NORMAL_10);
			Animation.createFrames("res/atlas/fish/fishimg/fish6/dead.json", FISH_DEAD_10);
			
			///id 10 海胆鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish3/live.json",FISH_NORMAL_11);
			Animation.createFrames("res/atlas/fish/fishimg/fish3/dead.json", FISH_DEAD_11);
			
			///id 11 灯笼鱼
			Animation.createFrames("res/atlas/fish/fishimg/fish1/live.json",FISH_NORMAL_12);
			Animation.createFrames("res/atlas/fish/fishimg/fish1/dead.json", FISH_DEAD_12);
		}
		
		/**
		 * 创建鱼
		 * @param	type
		 * @return
		 */
		public function createFishById(id:Number):FishFahter {
			var fish:FishFahter;
			var fishVo:FishVo = DataProxy.instance().getDataById(id);
			
			fish = Pool.getItemByClass("fish_info_"+(id+1)+"", FishFahter);
			fishVo.fishInfo = "fish_info_"+(id+1)+"";
			fishVo.leveAn = "fish_normal_"+(id+1)+"";
			fishVo.deadAn = "fish_dead_"+(id+1)+"";
			
			fish.fishVo = fishVo;
			fish.id = id;
			
			return fish;
		}
		
		/**
		 * 回收fish
		 * @param	bullet
		 */
		public function recoverFish(fish:FishFahter):void {
			Pool.recover(fish.fishVo.fishInfo,fish);
		}
		
		
		/**
		 * 获取心形路径点
		 * @param	dis  大小
		 * @param	mj   点密集度
		 * @return
		 */
		public function heartPathDot(dis:Number=150,mj:Number=10):Array {
			var angle:Number;//储存极角
			var p:Point;
			var rarr:Array = [];
			var sin:Number;
			var cos:Number;
			var heartX:Number = 0;//心形中点的坐标
			var heartY:Number = 0;
			var heartSize:Number = dis;//心形的大小
			 
			var A:Number = Math.PI/4;
			var X:Number;
			var Y:Number;
			var lastX:Number;
			for (var i:int = 0; i <= 360; i+=mj) {
				 //计算极角和极径
				 angle = Math.PI * i / 180;                                
				 //心形
				 X=2*Math.cos(angle)*Math.cos(A) - Math.sin(angle)*Math.sin(A);
				 Y=2*Math.cos(angle)*Math.sin(A) + Math.sin(angle)*Math.cos(A);
				 if(X>0){
					Y = -Y;
				 }
				 
				 p = new Point(heartX + X * heartSize, heartY + Y * heartSize);
				 rarr.push(p);
				 
				 lastX = X;
			}
			return rarr;
		}
		
		/**
		 * 矩形路径点
		 * @param	rows
		 * @param	cols
		 * @param	space
		 * @return
		 */
		public function rectPathDot(rows:Number=4, cols:Number=8, space:Number = 80):Array {
			var p:Point;
			var arr:Array = [];
			var xx:Number=0;
			var yy:Number=0;
			for (var i = 0; i < rows; i++) {
				for (var j = 0; j < cols; j++) {
					p = new Point(xx, yy);
					xx += space;
					arr.push(p);
				}
				xx = 0;
				yy += space;
			}
			return arr;
		}
		
		/**
		 * 菱形路径点
		 * @param	rows
		 * @param	cols
		 * @param	space
		 * @return
		 */
		public function rhombPathDot(rows:Number=7,cols:Number=7,space:Number=80):Array {
			var val:Number = Math.floor(cols / 2);//开始空的格数
			var p:Point;
			var arr:Array = [];
			var xx:Number=0;
			var yy:Number = 0;
			
			var flag:Number = 1;//1将序  2升序
			for (var i = 0; i < rows; i++) {
				if (val < 0) {
					flag = 2;
					val = 1;
				}
				for (var j = val; j < val+(cols-val*2); j++) {
					xx = j * space;
					p = new Point(xx, yy);
					arr.push(p);
				}
				if (flag == 1) {
					val--;
				}else if (flag == 2) {
					val++;
				}
				
				yy += space;
			}
			return arr;
		}
		
		/**
		 * 圆形路径
		 * @param	count 几环
		 * @param	space 半径间距
		 * @param	angleSpace 角度间距
		 * @return
		 */
		public function circlePathDot(count:Number=3,space:Number=80,angleSpace:Number=30):Array {
			var radius:Number = 0;
			var angle:Number;
			var p:Point;
			var arr:Array = [];
			var xx:Number=0;
			var yy:Number = 0;
			for (var i = 1; i <= count; i++) {
				radius = i * space;
				for (var j = 0; j < 360; j += angleSpace) {
					xx = Math.cos(j * Math.PI / 180) * radius;
					yy = Math.sin(j * Math.PI / 180) * radius;
					p = new Point(xx, yy);
					arr.push(p);
				}
			}
			return arr;
		}
		
	}
}