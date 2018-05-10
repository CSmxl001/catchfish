/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class GameViewUI extends View {
		public var bottomCon:Box;
		public var dz:Image;
		public var btn_next:Button;
		public var btn_pre:Button;
		public var btn_info:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1280,"height":709},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1280,"skin":"fish/img/blockwhite.png","sizeGrid":"20,12,16,11","height":709}},{"type":"Box","props":{"y":0,"x":0,"var":"bottomCon"},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"fish/img/img2.jpg"}}]},{"type":"Image","props":{"y":611,"x":431,"skin":"fish/img/dz1.png.png"}},{"type":"Image","props":{"y":710,"x":640,"var":"dz","skin":"fish/img/dz.png","rotation":180,"anchorY":0,"anchorX":0.5}},{"type":"Box","props":{"y":0,"x":0},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"fish/img/img1.png"}}]},{"type":"Button","props":{"y":663,"x":759,"var":"btn_next","skin":"fish/img/button_arrow.png"}},{"type":"Button","props":{"y":704,"x":523,"var":"btn_pre","skin":"fish/img/button_arrow.png","rotation":180}},{"type":"Button","props":{"y":648,"x":1130,"width":128,"var":"btn_info","skin":"fish/img/button.png","sizeGrid":"19,56,14,64","labelSize":22,"labelFont":"华文行楷","labelColors":"#ffffff,","labelBold":true,"label":"信息","height":40}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}