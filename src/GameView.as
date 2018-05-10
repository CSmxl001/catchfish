package 
{
	import data.BulletVo;
	import data.DataProxy;
	import element.fish.FishFahter;
	import element.seaweed.SeaweedManager;
	import element.bullet.BulletFahter;
	import element.bullet.BulletManager;
	import element.cannon.CannonFather;
	import element.cannon.CannonManager;
	import element.coin.Coin;
	import element.coin.CoinManager;
	import element.fish.FishManager;
	import element.tools.Tools;
	import element.tools.ToolsManager;
	import element.view.CritUtils;
	import element.view.InfoLog;
	import element.view.ScoreView;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.media.SoundManager;
	import laya.ui.Label;
	import laya.utils.Browser;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.TimeLine;
	import laya.utils.Timer;
	import laya.utils.Tween;
	import ui.GameViewUI;
	import util.tips.CustomTips;
	
	/**
	 * ...
	 * @author MXL
	 */
	public class GameView extends GameViewUI 
	{
		private var cannon:CannonFather;//大炮
		private var _cannonType:Number = 0;//大炮类型
		public function get cannonType():Number {
			return _cannonType;
		}
		public function set cannonType(val:Number):void {
			_cannonType = val;
			_cannonType = Math.min(Math.max(_cannonType, CannonFather.MIN_TYPE), CannonFather.MAX_TYPE);
			cannon.type = _cannonType;
		}
		
		private var gameInfo:ScoreView;
		
		private var bulletArr:Array = [];//子弹数组
		private var deadBullet:Array = [];//死亡子弹
		private var fishArr:Array = [];//fish
		
		private var infoLog:InfoLog;
		public function GameView() 
		{
			initData();
			initView();
			initEvent();
		}
		/**
		 * 初始画数据
		 */
		private function initData():void {
			///缓存动画
			SeaweedManager.instance().cacheAnimation();
			BulletManager.instance().cacheAnimation();
			FishManager.instance().cacheAnimation();
			CannonManager.instance().cacheAnimation();
			CoinManager.instance().cacheAnimation();
			ToolsManager.instance().cacheAnimation();
			///海藻动画
			SeaweedManager.instance().createSeaweed(bottomCon);
			
			infoLog = new InfoLog();
			infoLog.popup(true);
		}
		/**
		 * 初始化界面
		 */
		private function initView():void {
			//创建大炮
			cannon = CannonManager.instance().createCannon(this);
			cannon.pos(dz.x, dz.y - cannon.xiuVal);
			cannonType = 5;
			
			Global.instance().lvlnum = 1;
			
			//界面
			gameInfo = new ScoreView();
			this.addChild(gameInfo);
			gameInfo.pos(30, Global.instance().totalHeight - 60);
			gameInfo.totalScore = Global.instance().totalSocre;
			createFish(Global.instance().totalFishNum);
			createTools();
			
			//createOrder();
		}
		
		/**
		 * 初始化事件
		 */
		private function initEvent():void {
			this.on(Event.MOUSE_DOWN, this, thisDownHand);
			btn_pre.on(Event.MOUSE_DOWN, this, powBtnHand);
			btn_next.on(Event.MOUSE_DOWN, this, powBtnHand);
			btn_info.on(Event.CLICK,this,function(){
				infoLog.popup(true);
			})
			
			Laya.timer.frameLoop(1, this, loopHand);
		}
		
		/**
		 * 调整大炮威力
		 * @param	e
		 */
		private function powBtnHand(e:Event):void {
			e.stopPropagation();
			
			if (e.currentTarget == btn_pre) {
				cannonType--;
			}else {
				cannonType++;
			}
		}
		
		/**
		 * 发射子弹
		 * @param	e
		 */
		private function thisDownHand(e:Event):void {
			if (Global.instance().ISPAUSE) return;
			
			//发射子弹有效区域
			if (this.mouseY <= Global.instance().totalHeight - Global.instance().bottomSpace) {
				//能量不足
				if (!checkCanShoot(DataProxy.instance().getDataByType(cannon.type))){
					return;
				}
				
				var time:Number = Browser.now();
				if (time > cannon.shootTime*Global.instance().shootInterTime) {
					//调整大炮角度
					var disy:Number = (this.mouseY - cannon.y);
					var disx:Number = (this.mouseX - cannon.x);
					cannon.rotateAn(Math.atan2(disy, disx) * 180 / Math.PI + 90);
				
					cannon.shootTime = time+cannon.shootInterval;
					cannon.shootAn();
					
					var bullet:BulletFahter = BulletManager.instance().createBulletByType(cannon.type);
					var angle:Number = cannon.rotation - 90;
					bullet.pos(cannon.x + Math.cos(angle * Math.PI / 180) * cannon.selfHeight, 
					cannon.y+Math.sin(angle*Math.PI/180)*cannon.selfHeight);
					bullet.rotation = cannon.rotation;
					this.addChild(bullet);
					bullet.init();
					
					bullet.once(BulletFahter.BOOM_COM, this, bulletBoom);
					bulletArr.push(bullet);
				}
				
			}
		}
		
		/**
		 * 循环函数
		 */
		private function loopHand():void{
			checkHitFish2();
			checkHitTools();
		}
		
		/**
		 * 子弹爆炸二次检测碰撞 交点碰撞，相对矩形精确一些
		 * @param	bullet
		 */
		private function boomCheckHit(bullet:BulletFahter):void{
			var fish:FishFahter;
			var j = 0;
			var frect:Rectangle;
			for (j = 0; j < fishArr.length; j++){
				fish = fishArr[j];
				if (!fish || !fish.parent) continue;
				frect = fish.getHitRectangle();
				if (!fish.dead){
					if (checkOver(frect, bullet)){
						fish.hp -= getBulletHard(bullet);
					}
				}
			}
		}
		
		/**
		 * 子弹碰撞到鱼
		 */
		private function checkHitFish2():void{
			var bullet:BulletFahter;
			var fish:FishFahter;
			var i = 0;
			var j = 0;
			var frect:Rectangle;
			for (i = 0; i < bulletArr.length; i++){
				bullet = bulletArr[i];
				if (!bullet || !bullet.parent) continue;
				for (j = 0; j < fishArr.length; j++){
					fish = fishArr[j];
					if (!fish || !fish.parent) continue;
					frect = fish.getHitRectangle();
					if (!bullet.isHitFish && !bullet.deaded && !fish.dead){
						if (checkOver(frect, bullet)) {
							bullet.isHitFish = true;
							fish.hp -= getBulletHard(bullet);	
						}
					}
				}
			}
		}
		
		/**
		 * 获取子弹伤害
		 * @param	bullet
		 * @return
		 */
		private function getBulletHard(bullet:BulletFahter):Number{
			var value:Number = bullet.dataVo.power * Global.instance().shootPower;
			var ran:Number = Math.random();
			var min:Number = 2;
			var max:Number = 4;
			var bei:Number = 1;
			if (ran > 0.9){
				bei = min + Math.floor(Math.random() * max)
				var crit:CritUtils = new CritUtils(bei);
				bottomCon.addChild(crit);
				crit.pos(bullet.x, bullet.y);
			}
			
			return value*bei;
		}
		
		/**
		 * 子弹碰撞道具
		 */
		private function checkHitTools():void{
			var bullet:BulletFahter;
			var tool:Tools
			var i = 0;
			var j = 0;
			var frect:Rectangle;
			for (i = 0; i < bulletArr.length; i++){
				bullet = bulletArr[i];
				if (!bullet || !bullet.parent) continue;
				for (j = 0; j < ToolsManager.instance().toolArr.length; j++){
					tool = ToolsManager.instance().toolArr[j];
					if (!tool || !tool.parent) continue;
					frect = tool.getHitRectangle();
					if (!bullet.isHitTool && !bullet.deaded && !tool.deaded){
						if (checkOver(frect,bullet)){
							bullet.isHitTool = true;
							tool.disposeS();
						}
					}
				}
			}
		}
		
		/**
		 * 子弹爆炸二次检测碰撞 交点碰撞，相对矩形精确一些
		 * @param	bullet
		 */
		private function boomCheckHitTool(bullet:BulletFahter):void{
			var tool:Tools
			var j = 0;
			var frect:Rectangle;
			for (j = 0; j < ToolsManager.instance().toolArr.length; j++){
				tool = ToolsManager.instance().toolArr[j];
				if (!tool || !tool.parent) continue;
				frect = tool.getHitRectangle();
				if (!tool.deaded){
					if (checkOver(frect, bullet)){
						tool.disposeS();
					}
				}
			}
		}
		
		
		/**
		 * 检查是否相交
		 * @param	fullet
		 * @param	fish
		 */
		private function checkOver(frect:Rectangle,bullet:BulletFahter):Boolean{
			var bc:Point = bullet.getCenter();
			var br:Number = bullet.hitRadius;
			var xv:Number = 10;//修正范围
			var p1:Point = new Point(frect.x+xv, frect.y+xv);
			var p2:Point = new Point(frect.x+xv + frect.width-xv*2, frect.y+xv);
			var p3:Point = new Point(frect.x+xv, frect.y+xv+frect.height-xv*2);
			var p4:Point = new Point(frect.x+xv + frect.width-xv*2, frect.y+xv + frect.height-xv*2);
			
			var arr4:Array = getNode(p1, p2, bc, br);
			var arr3:Array = getNode(p1, p3, bc, br);
			var arr2:Array = getNode(p2, p4, bc, br);
			var arr1:Array = getNode(p3, p4, bc, br);
			
			
			var arr:Array = arr1.concat(arr2).concat(arr3).concat(arr4);
			var boo:Boolean = false;
			
			return isOver(frect,arr);
		}
		
		/**
		 * 是否包含集合中的任意一个点
		 * @param	frect
		 * @param	parr
		 * @return
		 */
		private function isOver(frect:Rectangle,parr:Array):Boolean{
			for (var i = 0; i < parr.length; i++){
				var p:Point = parr[i];
				if (frect.contains(p.x, p.y)){
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 返回线跟圆的交点
		 * @param	p1  点1
		 * @param	p2  点2
		 * @param	c   圆心
		 * @param	r   半径
		 * @return  两个交点
		 */
		private function getNode(p1:Point, p2:Point, c:Point, r:Number):Array{
			var x1:Number;
			var x2:Number;
			var y1:Number;
			var y2:Number;
			
			var po1:Point = new Point(0,0);
			var po2:Point = new Point(0,0);
			if (p2.x - p1.x == 0){
				x1 = p1.x;
				x2 = p1.x;
				y1 = Math.pow(r*r-Math.pow((p1.x-c.x),2),1/2)+c.y;//下面点
				y2 = -Math.pow(r*r-Math.pow((p1.x-c.x),2),1/2)+c.y;//上面点
			}else{
				var k:Number = (p2.y-p1.y)/(p2.x-p1.x);
				var b:Number = p1.y-(p2.y-p1.y)/(p2.x-p1.x)*p1.x;
				var m:Number = b-c.y;
				var val = -2*m*k*c.x- k*k*c.x*c.x+k*k*r*r-m*m+r*r;
				x1 = ((c.x-m*k)- Math.pow(val,1/2))/(k*k+1)//左边点
				y1 = k*x1+b;
				
				x2 = ((c.x-m*k)+ Math.pow(val,1/2))/(k*k+1)//右边点
				y2 = k*x1+b;
			}
			
			po1.setTo(x1, y1);
			po2.setTo(x2, y2);

			return [po1,po2];
		}
		
		/**
		 * 子弹爆炸
		 * @param	bullet
		 */
		private function bulletBoom(bullet:BulletFahter):void{
			boomCheckHit(bullet);
			boomCheckHitTool(bullet);
			
			var index:Number = bulletArr.indexOf(bullet);
			bulletArr.splice(index, 1);
			
			bullet.removeSelf();
			bullet.deaded = true;
			BulletManager.instance().recoverBullerByType(bullet.sign);
			
			gameInfo.totalScore -= bullet.dataVo.power;
		}
		
		/**
		 * 创建fish
		 * @param	fishNum
		 */
		private function createFish(fishNum:Number):void{
			var fish:FishFahter;
			var ranVal:Number;
			var typeVal:Number = 0;
			for (var i = 0; i < fishNum; i++){
				ranVal = Math.random();
				
				if (ranVal > 0 && ranVal <= 0.92){//0-5
					typeVal = Math.floor(Math.random()*6);
				}else if (!hasFish(10)&&!hasFish(11)&&ranVal > 0.92 && ranVal <= 0.94){//10，11
					typeVal = Math.random() > 0.5?10:11;
				}else if (!hasFish(6)&&!hasFish(7)&&ranVal > 0.94 && ranVal <= 0.96){//6.7
					typeVal = Math.random() > 0.5?6:7;
				}else if (!hasFish(9)&&ranVal > 0.96 && ranVal <= 0.98){//8，9
					typeVal = 9;
				}else if (ranVal > 0.98 && !hasFish(8)){
					typeVal = 8;
				}
				
				if (typeVal==9){
					CustomTips.instance().AddTip(this, "海底出现鲨鱼，击败它可以获得大量能量哦！！", "warn", true, 100, 100, 300, false, 100, 3);
				}else if (typeVal == 8){
					CustomTips.instance().AddTip(this, "海豚出现啦！击败它掉落鱼雷哦！鱼雷只存在10秒钟！", "right", true, 100, 100, 300, false, 100, 3);
				}else if (typeVal == 6){
					CustomTips.instance().AddTip(this, "鳄鱼来了！击败它掉落能量宝箱哦！宝箱只存在10秒钟！", "warn", true, 100, 100, 300, false, 100, 3);
				}else if (typeVal == 7){
					CustomTips.instance().AddTip(this, "海龟出现！击败它掉落武器增强道具！", "warn", true, 100, 100, 300, false, 100, 3);
				}else if (typeVal == 11) {
					CustomTips.instance().AddTip(this, "灯笼鱼出现！击败它掉落鱼饵，鱼饵可以吸引来鱼群哦！", "warn", true, 100, 100, 300, false, 100, 3);
				}
				
				fish = FishManager.instance().createFishById(typeVal);
				bottomCon.addChild(fish);
				fish.init(Math.random()>0.5?"right":"left");
				fish.once(FishFahter.FISH_DEAD, this, fishDead);
				
				fishArr.push(fish);
			}
		}
		
		private function hasFish(val:Number):Boolean{
			var fish:FishFahter;
			for (var i = 0; i < fishArr.length; i++){
				fish = fishArr[i];
				if (fish.fishVo.id == val){
					return true
				}
			}
			return false;
		}
		
		/**
		 * 创建道具
		 * @param	type
		 */
		private function createTools(type:Number,xx:Number,yy:Number):void{
			var tool:Tools = ToolsManager.instance().createToolByType(type);
			tool.once(Tools.DEAD_OVER, this, deadAnOver);
			tool.pos(xx, yy);
			bottomCon.addChild(tool);
		}
		/**
		 * 道具触发
		 * @param	tool
		 */
		private function deadAnOver(tool:Tools):void{
			if (tool.type == 1){
				killAllFish();
				//闪屏
				var timeline:TimeLine=new TimeLine();
				timeline
				.addLabel("right", 0).to(bottomCon, {alpha:0.1}, 80)
				.addLabel("left",0).to(bottomCon, {alpha:1}, 80)
				.addLabel("right2", 0).to(bottomCon, {alpha:0.1}, 80)
				.addLabel("left2", 0).to(bottomCon, {alpha:1}, 80)
				.addLabel("right3", 0).to(bottomCon, {alpha:0.1}, 80)
				.addLabel("left3",0).to(bottomCon, {alpha:1}, 80)
				
				timeline.play(0, false);
				timeline.once(Event.COMPLETE, this, function(){
					timeline.destroy();
					Global.instance().ISPAUSE = false;
					bottomCon.alpha = 1;
				})
				SoundManager.playSound("res/sound/boom.wav");
			}else if (tool.type == 2){//宝箱
				Global.instance().ISPAUSE = false;
				CoinManager.instance().addCoin(500, "coin", tool.x, tool.y, bottomCon);
				Global.instance().getPowerNum += 500;
				gameInfo.totalScore += 500;
			}else if (tool.type == 3){//武器道具
				Global.instance().ISPAUSE = false;
				//startEffect();
				cannon.strongTime = 20;
				CustomTips.instance().AddTip(this, "武器增强！！", "warn", true, 100, 100, 300, false, 100, 3);
				SoundManager.playSound("res/sound/bullet_power.mp3");
			}else if (tool.type == 4) {//鱼饵
				Global.instance().ISPAUSE = false;
				createOrder();
			}
		}
		
		/**
		 * 杀死所有fish
		 */
		private function killAllFish():void {
			var fish:FishFahter;
			for (var i = 0; i < fishArr.length;i++ ){
				fish = fishArr[i];
				fish.hp = 0;
			}
		}
		
		/**
		 * fish dead
		 * @param	fish
		 */
		private function fishDead(fish:FishFahter):void{
			var index:Number = fishArr.indexOf(fish);
			fishArr.splice(index, 1);
			
			//队列中的鱼 奖励翻倍 杀死队列中的鱼不创建新鱼
			var val:Number = 1;
			if (fish.isInOrder) {
				val = 2;
			}else {
				createFish(1);
			}
			
			CoinManager.instance().createMoreCoin(fish, bottomCon);
			
			gameInfo.totalScore += fish.fishVo.score*val;
			Global.instance().getPowerNum += fish.fishVo.score*val;
			lvlSet();
			
			//掉落鱼雷
			if (fish.fishVo.id == 8){
				createTools(1,fish.x,fish.y);
			}else if (fish.fishVo.id == 6){//掉落宝箱
				createTools(2,fish.x,fish.y);
			}else if (fish.fishVo.id == 7){//掉落增强道具
				createTools(3,fish.x,fish.y);	
			}else if (fish.fishVo.id == 11) {//掉落鱼饵
				createTools(4,fish.x,fish.y);	
			}
		}
		
		/**
		 * 关卡设置
		 */
		private function lvlSet():void{
			if (Global.instance().getPowerNum!=0 && Global.instance().getPowerNum / 2000 >Global.instance().lvlnum){
				Global.instance().lvlnum++;
				SoundManager.playSound("res/sound/lvlup.mp3");
				CustomTips.instance().AddTip(this, "速度提升！！", "right", true, 100, 100, 300, false, 100, 3);
			}
		}
		
		/**
		 * 随机创建鱼群
		 * @param	count
		 */
		private function createOrder(count:Number = 6):void {
			SoundManager.playSound("res/sound/mfish.mp3");
			CustomTips.instance().AddTip(this, "鱼群来袭!,鱼群中的鱼有双倍奖励哦！", "right", true, 100, 100, 300, false, 100, 3);
			var time:Number = 3000;
			var dir:String = Math.random() > 0.5?"right":"left";
			var timer:Timer;
			var fishtype:Number = Math.floor(Math.random() * 4);
			for (var i = 0; i < count; i++) {
				timer = new Timer();
				timer.once(time+i * 3000, this, function() {
					createFishOrder(Math.floor(Math.random() * 4), fishtype,dir);
				})
			}
		}
		
		/**
		 * 是否可以发射子弹
		 * @param	vo
		 * @return
		 */
		private function checkCanShoot(vo:BulletVo):Boolean{
			if (gameInfo.totalScore-vo.power < 0){
				CustomTips.instance().AddTip(this, "能量不足！！", "right", true, 100, 100, 300, false, 60, 3);
				SoundManager.playSound("res/sound/crit.mp3");
				return false;
			}
			return true;
		}
		
		/**
		 * 创建队形
		 * @param	flag 0心 1矩形 2菱形 3圆形
		 * @param	type 鱼类型
		 * @param	dirs 游向 left 向左游
		 */
		private function createFishOrder(flag:Number = 0,type:Number=0,dirs:String="left"):void {
			var pathArr:Array=[];
			var fish:FishFahter;
			var p:Point;
			var newp:Point;
			var xiux:Number=0;
			var xiuy:Number=0;
			switch(flag) {
				case 0:
					pathArr = FishManager.instance().heartPathDot();
					if (dirs == "right") {
						xiux = -600;
					}else {
						xiux = Global.instance().totalWidth+600;
					}
					
					xiuy = 400;
					break;
				case 1:
					pathArr = FishManager.instance().rectPathDot();
					if (dirs == "right") {
						xiux = -600;
					}else {
						xiux = Global.instance().totalWidth+600;
					}
					
					xiuy = 250;
					break;
				case 2:
					pathArr = FishManager.instance().rhombPathDot();
					if (dirs == "right") {
						xiux = -600;
					}else {
						xiux = Global.instance().totalWidth+600;
					}
					
					xiuy = 100;
					break;
				case 3:
					pathArr = FishManager.instance().circlePathDot();
					if (dirs == "right") {
						xiux = -400;
					}else {
						xiux = Global.instance().totalWidth+400;
					}
					
					xiuy = 350;
					break;
			}
			
			var i = 0;
			for (i = 0; i < pathArr.length; i++) {
				p = pathArr[i];
				newp = new Point(p.x + xiux, p.y + xiuy);
				fish = FishManager.instance().createFishById(type);
				bottomCon.addChild(fish);
				fish.init(dirs,newp,true);
				fish.once(FishFahter.FISH_DEAD, this, fishDead);
				fish.once(FishFahter.FISH_DEAD_SELF, this, fishDeadSelf);
				fishArr.push(fish);
			}
		}
		
		/**
		 * 鱼自己死亡
		 * @param	fish
		 */
		private function fishDeadSelf(fish:FishFahter):void {
			var index:Number = fishArr.indexOf(fish);
			fishArr.splice(index, 1);
		}
		
	}
}