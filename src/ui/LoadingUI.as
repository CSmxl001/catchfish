/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class LoadingUI extends View {
		public var bars:Image;
		public var btn_start:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1282,"height":709},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"fish/img/img4.jpg"}},{"type":"Image","props":{"y":0,"x":0,"skin":"fish/img/img3.png"}},{"type":"Box","props":{"y":409,"x":428},"child":[{"type":"Image","props":{"skin":"fish/load/linebg.png"}},{"type":"Image","props":{"y":36,"x":32,"var":"bars","skin":"fish/load/bars.png","sizeGrid":"0,11,0,10","scaleY":0.4}},{"type":"Button","props":{"y":156,"x":84,"width":256,"var":"btn_start","skin":"fish/load/button_star.png","height":77}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}