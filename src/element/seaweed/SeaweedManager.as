package element.seaweed 
{
	import element.seaweed.SeaWeed;
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.maths.Point;
	/**
	 * ...
	 * @author MXL
	 */
	public class SeaweedManager 
	{
		private static var _instance:SeaweedManager=new SeaweedManager();
		public static function instance():SeaweedManager {
			return _instance;
		}
		
		/**
		 * 缓存动画
		 */
		public function cacheAnimation():void {
			Animation.createFrames("res/atlas/fish/seaweed/seaweed1.json", "seaweed1");
			Animation.createFrames("res/atlas/fish/seaweed/seaweed2.json", "seaweed2");
			Animation.createFrames("res/atlas/fish/seaweed/seaweed3.json", "seaweed3");
			Animation.createFrames("res/atlas/fish/seaweed/seaweed4.json", "seaweed4");
		}
		
		/**
		 * 创建海藻
		 */
		public function createSeaweed(container:Sprite, count:Number = 12):void {
			var parr:Array = 
			[
			new Point(120, 110), new Point(890, 100), new Point(1017, 102),
			new Point(300, 240), new Point(500, 300), new Point(830, 354),
			new Point(1173, 412), new Point(101, 256), new Point(660, 590),
			new Point(440, 380), new Point(360, 472), new Point(700, 290)
			]
			var seaweed:SeaWeed;
			for (var i = 0; i < count; i++) {
				seaweed = new SeaWeed();
				container.addChild(seaweed);
				seaweed.animationBody.play(Math.floor(Math.random()*10), true, "seaweed" + (Math.floor(Math.random() * 4) + 1));
				var p:Point = parr[i];
				var rs:Number = Math.random()*0.6 + 0.4;
				seaweed.scale(rs, rs);
				seaweed.rotation = Math.random() * 360;
				seaweed.pos(p.x, p.y);
			}
		}
	}
}