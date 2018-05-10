package 
{
	/**
	 * ...
	 * @author MXL
	 */
	public class Global 
	{
		private static var _instance:Global = new Global();
		public static function instance():Global {
			return _instance;
		}
		
		public var totalWidth:Number = 1282;//总宽度
		public var totalHeight:Number = 709;//总长度
		public var bottomSpace:Number = 50;//距离底部空隙
		
		public var bulletMoveSpeed:Number = 15;//子弹移动速度
		public var ISPAUSE:Boolean = false;//是否暂停
		public var ISOVER:Boolean = false;//是否结束
		
		//子弹修正值
		public var bulletOneValue:Number = 40;
		public var bulletOtherValue:Number = 160;
		
		public var totalFishNum:Number = 30;//屏幕中最多fish
		
		public var totalSocre:Number = 1000;//初始总分数
		
		private var _lvlnum:Number = 1;//当前的关卡
		public function get lvlnum():Number{
			return _lvlnum;
		}
		public function set lvlnum(val:Number):void{
			_lvlnum = val;
			_lvlnum = Math.min(_lvlnum, 40);
			
			lvlAddValue = 1 + _lvlnum * 0.05;
		}
		
		public var lvlAddValue:Number = 0;//关卡增加速度系数
		public var getPowerNum:Number = 0;//获取到的能量
		
		public var shootInterTime:Number = 1;//子弹发射间隔 
		public var shootPower:Number = 1;//子弹威力
		
	}
}