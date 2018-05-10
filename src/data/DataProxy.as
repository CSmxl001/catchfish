package data 
{
	import laya.utils.Dictionary;
	/**
	 * ...
	 * @author MXL
	 */
	public class DataProxy 
	{
		private static var _instance:DataProxy = null;
		public static function instance():DataProxy
		{
			if (!_instance) {
				_instance = new DataProxy();
			}
			return _instance;
		}
		
		//鱼相关数据
		public var fishDataDic:Dictionary = new Dictionary();
		public function getDataById(id:Number):FishVo {
			return fishDataDic.get(id);
		}
		
		//bullet data
		public var bulletDataDic:Dictionary = new Dictionary();
		public function getDataByType(type:Number):BulletVo {
			return bulletDataDic.get(type);
		}
	}
}