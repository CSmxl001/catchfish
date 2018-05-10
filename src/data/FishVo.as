package data 
{
	/**
	 * ...
	 * @author MXL
	 */
	public class FishVo 
	{
		public var id:Number = 0;//id
		public var name:String = "";//鱼名字
		public var grade:Number = 0;//等级
		public var score:Number = 0;//得分
		public var speed:Number = 0;//速度
		public var blood_min:Number = 0 ;//最小血
		public var blood_Max:Number = 0;//最大血
		public var liveUrl:String = "";//游动动画路径
		public var deadUrl:String = "";//死亡动画路径
		public var hitValue:Number = 0;//碰撞区域修正值
		
		public var fishInfo:String = "";//缓存标识
		public var leveAn:String = "";//离开动画
		public var deadAn:String = "";//死亡动画
	}
}