package data 
{
	/**
	 * ...
	 * @author MXL
	 */
	public class AnalysisXML 
	{  
		/**
		 * 单利类
		 */
		private static var _instance:AnalysisXML;
		public static function instance():AnalysisXML {
			if (!_instance) {
				_instance = new AnalysisXML();
			}
			return _instance;
		}
		
		/**
		 * 解析fish数据
		 */
		public function analysisFishData():void {
			var xml:XmlDom = Laya.loader.getRes("res/xml/fish.xml");
			var nodes:Array = xml.firstChild.childNodes;
			var fishVo:FishVo;
			for (var i:int = 0; i < nodes.length; i++)
			{
				var node:Object = nodes[i];
				if (node.nodeName == "fish") {
					fishVo = new FishVo();
					
					var sunnodes:Array = node.childNodes;
					for (var j:int = 0; j < sunnodes.length; j++) {
						var sunnode:Object = sunnodes[j];
						if (sunnode.nodeName == "name") {
							fishVo.name = sunnode.firstChild.nodeValue;
						}else if (sunnode.nodeName == "id") {
							fishVo.id = Number(sunnode.firstChild.nodeValue);
						}else if (sunnode.nodeName == "liveUrl") {
							fishVo.liveUrl = sunnode.firstChild.nodeValue;
						}else if (sunnode.nodeName == "deadUrl") {
							fishVo.deadUrl = sunnode.firstChild.nodeValue;
						}else if (sunnode.nodeName == "grade") {
							fishVo.grade = Number(sunnode.firstChild.nodeValue);
						}else if (sunnode.nodeName == "blood_min") {
							fishVo.blood_min = Number(sunnode.firstChild.nodeValue);
						}else if (sunnode.nodeName == "blood_Max") {
							fishVo.blood_Max = Number(sunnode.firstChild.nodeValue);
						}else if (sunnode.nodeName == "score") {
							fishVo.score = Number(sunnode.firstChild.nodeValue);
						}else if (sunnode.nodeName == "speed") {
							fishVo.speed = Number(sunnode.firstChild.nodeValue);
						}else if (sunnode.nodeName == "hitValue"){
							fishVo.hitValue = Number(sunnode.firstChild.nodeValue);
						}
					}
					
					DataProxy.instance().fishDataDic.set(fishVo.id, fishVo);
				}
			}
		}
		
		/**
		 * bullet data 
		 */
		public function analysisBulletData():void {
			var xml:XmlDom = Laya.loader.getRes("res/xml/bullet.xml");
			var nodes:Array = xml.firstChild.childNodes;
			var bulletVo:BulletVo;
			for (var i:int = 0; i < nodes.length; i++)
			{
				var node:Object = nodes[i];
				bulletVo = new BulletVo();
				bulletVo.type = node.getAttribute("type");
				bulletVo.powerRadius = node.getAttribute("powerRadius");
				bulletVo.boomRadius = node.getAttribute("boomRadius");
				bulletVo.speed = node.getAttribute("speed");
				bulletVo.power = node.getAttribute("power");
				DataProxy.instance().bulletDataDic.set(bulletVo.type, bulletVo);
			}
			
		}
		
		
		
	}
}