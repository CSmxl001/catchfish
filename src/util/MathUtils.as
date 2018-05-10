package util 
{
	import laya.maths.Point;
	/**
	 * ...
	 * @author MXL
	 */
	public class MathUtils 
	{
		/**
		 * 获取两个点之间的距离
		 * @param p1
		 * @param p2
		 * @return 
		 */		
		public static function towPoingDistance(p1:Point,p2:Point):Number
		{
			var dx:Number = p1.x -p2.x;
			var dy:Number = p1.y-p2.y;
			var dist:Number = Math.sqrt(dx*dx+dy*dy);
			return dist;
		}
		
	}

}