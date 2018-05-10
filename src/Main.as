package {
	import data.AnalysisXML;
	import element.view.LoadingView;
	import laya.display.Stage;
	import laya.media.SoundManager;
	import laya.net.Loader;
	import laya.ui.Label;
	import laya.utils.Handler;
	import laya.webgl.WebGL;
	public class Main {
		
		private var loadView:LoadingView;
		public function Main() {
			//初始化引擎
			Laya.init(Global.instance().totalWidth,Global.instance().totalHeight,WebGL);
			Laya.stage.bgColor = "#ffffff";
			Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
			Laya.stage.alignH = "center";
			Laya.stage.alignV = "middle";
			
			SoundManager.playMusic("res/sound/bg_start.mp3");
			
			loadLoadingAsset();
		}		
		
		/**
		 * 加载loading素材
		 */
		private function loadLoadingAsset():void{
			var assets:Array =
			[
				{url:"fish/img/img4.jpg",type:Loader.IMAGE},
				{url:"fish/img/img3.png",type:Loader.IMAGE},
				{url:"res/atlas/fish/load.json",type:Loader.ATLAS},
			]
			
			Laya.loader.load(assets, Handler.create(this, loadComs1), Handler.create(this, loadProgress1,null,false));
		}
		
		/**
		 * loading素材加载完成
		 */
		private function loadComs1(e:*= null):void {
			loadView = new LoadingView();
			loadView.once("startgame", this, startGame);
			Laya.stage.addChild(loadView);
			
			loadOtherAsset();
		}
		
		/**
		 * loading素材加载进度
		 */
		private function loadProgress1(val:Number):void {
			
		}
			
		
		/**
		 * 加载loading素材
		 */
		private function loadOtherAsset():void {
			
			var assets:Array = 
			[
				///加载子弹素材
				{url: "res/atlas/fish/bullet/bullet1.json",type:Loader.ATLAS},
				{url: "res/atlas/fish/bullet/bullet2.json",type:Loader.ATLAS},
				{url: "res/atlas/fish/bullet/bullet3.json",type:Loader.ATLAS},
				{url: "res/atlas/fish/bullet/bullet4.json",type:Loader.ATLAS},
				{url: "res/atlas/fish/bullet/bullet5.json",type:Loader.ATLAS},
				{url: "res/atlas/fish/bullet/bullet6.json",type:Loader.ATLAS},
				{url: "res/atlas/fish/bullet/bullet7.json",type:Loader.ATLAS},
				{url: "res/atlas/fish/bullet/bullet8.json",type:Loader.ATLAS},
				{url: "res/atlas/fish/bullet/bullet9.json", type:Loader.ATLAS },
				
				///鱼动画资源
				{url: "res/atlas/fish/fishimg/fish1/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish1/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish2/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish2/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish3/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish3/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish4/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish4/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish5/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish5/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish6/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish6/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish7/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish7/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish8/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish8/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish9/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish9/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish10/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish10/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish11/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish11/dead.json", type:Loader.ATLAS },
				
				{url: "res/atlas/fish/fishimg/fish12/live.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/fishimg/fish12/dead.json", type:Loader.ATLAS },
				
				//tips
				{url: "res/atlas/fish/tip.json", type:Loader.ATLAS },
				
				//大炮
				{url: "res/atlas/fish/cannon/cannon1.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/cannon/cannon2.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/cannon/cannon3.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/cannon/cannon4.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/cannon/cannon5.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/cannon/cannon6.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/cannon/cannon7.json", type:Loader.ATLAS },
				
				//其他素材
				{url: "res/atlas/fish/img.json", type:Loader.ATLAS },
				
				//海藻
				{url: "res/atlas/fish/seaweed/seaweed1.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/seaweed/seaweed2.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/seaweed/seaweed3.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/seaweed/seaweed4.json", type:Loader.ATLAS },
				
				//金币
				{url: "res/atlas/fish/money/coin.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/money/silver.json", type:Loader.ATLAS },
				
				//道具
				//炸弹
				{url: "res/atlas/fish/tools/boom.json", type:Loader.ATLAS },
				{url: "res/atlas/fish/tools.json", type:Loader.ATLAS },
				
				//特效
				{url: "res/atlas/fish/effect/flash.json", type:Loader.ATLAS },
				
				///鱼数据xml
				{url: "res/xml/fish.xml",type:Loader.XML},
				{url: "res/xml/bullet.xml",type:Loader.XML},
			];
			
			Laya.loader.load(assets, Handler.create(this, loadComs), Handler.create(this, loadProgress,null,false));
		}
		
		/**
		 * 素材加载完成
		 */
		private function loadComs(e:*= null):void {
			AnalysisXML.instance().analysisFishData();
			AnalysisXML.instance().analysisBulletData();
			
			//设置全局数据
			Global.instance().totalHeight = 1282; 
			Global.instance().totalHeight = 709; 
		}
		
		/**
		 * 素材加载进度
		 */
		private function loadProgress(val:Number):void {
			if (loadView){
				loadView.setData(val);
			}
		}
		
		private function startGame():void{
			SoundManager.musicVolume = 0.3;
			SoundManager.playMusic("res/sound/bg_game.mp3");
			
			Laya.stage.addChild(new GameView());
		}
	}
}