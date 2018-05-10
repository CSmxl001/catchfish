package element.coin 
{
	import element.fish.FishFahter;
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.media.SoundManager;
	import laya.utils.Pool;
	/**
	 * ...
	 * @author MXL
	 */
	public class CoinManager 
	{
		public static var _instance:CoinManager = new CoinManager();
		public static function instance():CoinManager {
			return _instance;
		}
		
		public static var COIN:String = "coin";//金币
		public static var SILVER:String = "silver";//金币
		
		/**
		 * 缓存动画
		 */
		public function cacheAnimation():void {
			Animation.createFrames("res/atlas/fish/money/coin.json", COIN);
			Animation.createFrames("res/atlas/fish/money/silver.json", SILVER);
		}
		
		/**
		 * 创建一个钱币
		 * @param	type
		 * @return
		 */
		public function createCoin(type:String):Coin {
			var coin:Coin = Pool.getItemByClass(type, Coin);
			coin.type = type;
			return coin;
		}
		
		/**
		 * 添加金币
		 * @param	fish
		 * @param	con
		 */
		public function createMoreCoin(fish:FishFahter,con:Sprite):void{
			var score:Number = fish.isInOrder?fish.fishVo.score * 2:fish.fishVo.score;
			var coinType:String;
			var coinNum:Number = 0;
			if (score >= 10){
				coinType = COIN;
				coinNum = Math.floor(score / 10);
			}else{
				coinType = SILVER;
				coinNum = score;
			}
			
			addCoin(coinNum, coinType, fish.x, fish.y, con);
		}
		
		/**
		 * 添加金币
		 * @param	coinNum
		 * @param	coinType
		 * @param	sx
		 * @param	sy
		 * @param	con
		 */
		public function addCoin(coinNum:Number,coinType:String,sx:Number,sy:Number, con:Sprite):void{
			var coin:Coin;
			var yy:Number = 0;
			var xx:Number = 0;
			var delayTime:Number = 200;
			
			if (coinNum > 5){
				SoundManager.playSound("res/sound/coin_more.mp3");
			}else{
				SoundManager.playSound("res/sound/coin2.mp3");
			}
			
			for (var i = 0; i < coinNum; i++){
				coin = createCoin(coinType);
				coin.once(Coin.MOVE_END, this, moveEnd);
				coin.pos(sx + coin.width * xx, sy+yy*coin.height);
				con.addChild(coin);
				
				xx ++;
				if (xx % 6==0){
					yy++;
					xx = 0;
				}
				
				delayTime += 20;
				coin.moveToPos(100, Global.instance().totalHeight+50,delayTime);
			}
		}
		
		/**
		 * 移动完成
		 * @param	coin
		 */
		private function moveEnd(coin:Coin):void{
			coin.removeSelf();
			recoverCoin(coin);
		}
		
		/**
		 * 回收钱币
		 * @param	coin
		 */
		public function recoverCoin(coin:Coin):void {
			Pool.recover(coin.type, coin);
		}
		
		
	}
}