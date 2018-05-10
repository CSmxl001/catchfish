package element.cannon 
{
	import laya.display.Animation;
	import laya.display.Sprite;
	/**
	 * ...
	 * @author MXL
	 */
	public class CannonManager 
	{
		/**
		 * 单利类
		 */
		private static var _instance:CannonManager;
		public static function instance():CannonManager {
			if (!_instance) {
				_instance = new CannonManager();
			}
			return _instance;
		}
		
		//大炮正常
		public static var CANNON_NORMAL_1:String = "cannon_normal_1";
		public static var CANNON_NORMAL_2:String = "cannon_normal_2";
		public static var CANNON_NORMAL_3:String = "cannon_normal_3";
		public static var CANNON_NORMAL_4:String = "cannon_normal_4";
		public static var CANNON_NORMAL_5:String = "cannon_normal_5";
		public static var CANNON_NORMAL_6:String = "cannon_normal_6";
		public static var CANNON_NORMAL_7:String = "cannon_normal_7";
		//大炮射击
		public static var CANNON_SHOOT_1:String = "cannon_shoot_1";
		public static var CANNON_SHOOT_2:String = "cannon_shoot_2";
		public static var CANNON_SHOOT_3:String = "cannon_shoot_3";
		public static var CANNON_SHOOT_4:String = "cannon_shoot_4";
		public static var CANNON_SHOOT_5:String = "cannon_shoot_5";
		public static var CANNON_SHOOT_6:String = "cannon_shoot_6";
		public static var CANNON_SHOOT_7:String = "cannon_shoot_7";
		
		//闪电特效
		public static var EFFECT_FLASH:String = "effect_flash";
		
		/**
		 * 缓存动画
		 */
		public function cacheAnimation():void {
			///大炮 1
			Animation.createFrames(["fish/cannon/cannon1/cannon10001.png"],CANNON_NORMAL_1);
			Animation.createFrames("res/atlas/fish/cannon/cannon1.json", CANNON_SHOOT_1);
			
			///大炮 2
			Animation.createFrames(["fish/cannon/cannon2/cannon20001.png"],CANNON_NORMAL_2);
			Animation.createFrames("res/atlas/fish/cannon/cannon2.json", CANNON_SHOOT_2);
			
			///大炮 3
			Animation.createFrames(["fish/cannon/cannon3/cannon30001.png"],CANNON_NORMAL_3);
			Animation.createFrames("res/atlas/fish/cannon/cannon3.json", CANNON_SHOOT_3);
			
			///大炮 4
			Animation.createFrames(["fish/cannon/cannon4/cannon40001.png"],CANNON_NORMAL_4);
			Animation.createFrames("res/atlas/fish/cannon/cannon4.json", CANNON_SHOOT_4);
			
			///大炮 5
			Animation.createFrames(["fish/cannon/cannon5/cannon50001.png"],CANNON_NORMAL_5);
			Animation.createFrames("res/atlas/fish/cannon/cannon5.json", CANNON_SHOOT_5);
			
			///大炮 6
			Animation.createFrames(["fish/cannon/cannon6/cannon60001.png"],CANNON_NORMAL_6);
			Animation.createFrames("res/atlas/fish/cannon/cannon6.json", CANNON_SHOOT_6);
			
			///大炮 7
			Animation.createFrames(["fish/cannon/cannon7/cannon70001.png"],CANNON_NORMAL_7);
			Animation.createFrames("res/atlas/fish/cannon/cannon7.json", CANNON_SHOOT_7);
			
			//闪电特效
			Animation.createFrames("res/atlas/fish/effect/flash.json", EFFECT_FLASH);
		}
		
		
		private var cannon:CannonFather;
		/**
		 * 
		 * @param	container大炮容器
		 * @param	type  类型 1-7
		 */
		public function createCannon(container:Sprite,xx:Number,yy:Number):CannonFather {
			if (!cannon) {
				cannon = new CannonFather();
				container.addChild(cannon);
				cannon.pos(xx, yy);
			}
			return cannon;
		}
		
		
	}
}