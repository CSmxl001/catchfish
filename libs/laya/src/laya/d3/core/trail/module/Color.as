package laya.d3.core.trail.module 
{
	
	public class Color 
	{
		/**
		 * 红色
		 */
		public static const RED:Color = new Color(1, 0, 0, 1);
		/**
		 * 绿色
		 */
		public static const GREEN:Color = new Color(0, 1, 0, 1);
		/**
		 * 蓝色
		 */
		public static const BLUE:Color = new Color(0, 0, 1, 1);
		/**
		 * 蓝绿色
		 */
		public static const CYAN:Color = new Color(0, 1, 1, 1);
		/**
		 * 黄色
		 */
		public static const YELLOW:Color = new Color(1, 0.92, 0.016, 1);
		/**
		 * 品红色
		 */
		public static const MAGENTA:Color = new Color(1, 0, 1, 1);
		/**
		 * 灰色
		 */
		public static const GRAY:Color = new Color(0.5, 0.5, 0.5, 1);
		/**
		 * 白色
		 */
		public static const WHITE:Color = new Color(1, 1, 1, 1);
		/**
		 * 黑色
		 */
		public static const BLACK:Color = new Color(0, 0, 0, 1);
		
		public var r:Number;
		public var g:Number;
		public var b:Number;
		public var a:Number;
		
		public function Color(r:Number, g:Number, b:Number, a:Number) 
		{
			this.r = r;
			this.g = g;
			this.b = b;
			this.a = a;
		}
		
	}

}