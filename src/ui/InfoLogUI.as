/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class InfoLogUI extends Dialog {
		public var btn_close:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1280,"height":709},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1280,"skin":"fish/img/package_herolist_bg.png","sizeGrid":"23,38,19,41","height":709,"alpha":0.7}},{"type":"Label","props":{"y":89,"x":314,"width":652,"text":"每发子弹都有两段伤害哦！！","height":38,"fontSize":50,"font":"华文行楷","color":"#ffffff","bold":true}},{"type":"Button","props":{"y":648,"x":1126,"width":128,"var":"btn_close","skin":"fish/img/button.png","sizeGrid":"19,56,14,64","labelSize":22,"labelFont":"华文行楷","labelColors":"#ffffff,","labelBold":true,"label":"关闭","height":40}},{"type":"Box","props":{"y":223,"x":197},"child":[{"type":"Image","props":{"x":169,"skin":"fish/fishimg/fish11/live/fish11_live0001.png","scaleY":0.5,"scaleX":0.5}},{"type":"Image","props":{"y":175,"x":74,"skin":"fish/fishimg/fish2/live/fish2_live0001.png","scaleY":0.5,"scaleX":0.5}},{"type":"Image","props":{"y":246,"x":67,"skin":"fish/fishimg/fish4/live/fish4_live0001.png","scaleY":0.5,"scaleX":0.5}},{"type":"Image","props":{"y":346,"skin":"fish/fishimg/fish6/live/fish6_live0009.png","scaleY":0.5,"scaleX":0.5}},{"type":"Label","props":{"y":9,"x":315,"width":524,"text":"海龟，掉落武器增强道具！！","height":28,"fontSize":30,"font":"华文行楷","color":"#ffffff","bold":true}},{"type":"Label","props":{"y":181,"x":315,"width":350,"text":"鳄鱼，掉落能量宝箱！！","height":38,"fontSize":30,"font":"华文行楷","color":"#ffffff","bold":true}},{"type":"Label","props":{"y":276,"x":315,"width":240,"text":"海豚，掉落鱼雷!!","height":38,"fontSize":30,"font":"华文行楷","color":"#ffffff","bold":true}},{"type":"Label","props":{"y":372,"x":315,"width":253,"text":"鲨鱼，大量能量!!","height":38,"fontSize":30,"font":"华文行楷","color":"#ffffff","bold":true}},{"type":"Image","props":{"y":97,"x":123,"skin":"fish/fishimg/fish1/live/fish1_live0001.png","scaleY":0.5,"scaleX":0.5}},{"type":"Label","props":{"y":95,"x":315,"width":524,"text":"灯笼鱼，掉落鱼饵，可以吸引鱼群！！","height":28,"fontSize":30,"font":"华文行楷","color":"#ffffff","bold":true}},{"type":"Image","props":{"y":241,"x":596,"skin":"fish/tools/boom/boom0001.png","scaleY":0.5,"scaleX":0.5}},{"type":"Image","props":{"y":169,"x":685,"skin":"fish/tools/bx.png","scaleY":0.5,"scaleX":0.5}},{"type":"Image","props":{"y":84,"x":858,"skin":"fish/tools/fishfood.png","scaleY":0.5,"scaleX":0.5}},{"type":"Image","props":{"y":2,"x":728,"skin":"fish/tools/power.png","scaleY":0.5,"scaleX":0.5}},{"type":"Image","props":{"y":367,"x":602,"skin":"fish/money/coin/coin0001.png"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}