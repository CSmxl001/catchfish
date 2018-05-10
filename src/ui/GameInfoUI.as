/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class GameInfoUI extends View {
		public var score:Label;
		public var addPower:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":351,"height":50},"child":[{"type":"Image","props":{"y":0,"x":0,"width":218,"skin":"fish/img/package_herolist_bg.png","sizeGrid":"23,38,19,41","height":50}},{"type":"Box","props":{"y":3,"x":11,"width":203,"height":43},"child":[{"type":"Label","props":{"y":9,"width":117,"text":"剩余能量：","height":30,"fontSize":24,"color":"#ffffff","bold":true}},{"type":"Label","props":{"y":24,"x":164,"width":106,"var":"score","text":"1000","height":30,"fontSize":24,"font":"Arial","color":"#ec7f09","bold":true,"anchorY":0.5,"anchorX":0.5,"align":"center"}}]},{"type":"Button","props":{"y":4,"x":224,"width":128,"var":"addPower","skin":"fish/img/button.png","sizeGrid":"19,56,14,64","labelSize":22,"labelFont":"华文行楷","labelColors":"#ffffff,","labelBold":true,"label":"补充能量","height":40}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}