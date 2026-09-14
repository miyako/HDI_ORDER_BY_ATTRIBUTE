Case of 
		
	: (FORM Event.code=On Load)
		
		If (Get menu bar reference:C979="")
			SET MENU BAR:C67(1)
		End if 
		
		DISABLE MENU ITEM:C150(Get menu bar reference:C979; 1; Current process:C322)
		
		var $vers : Text
		$vers:=Application version:C493
		
		Form.quit:=False
		
		If ($vers<"1620")  //1620 means 16R2   1601 means 16.1
			
			OBJECT SET TITLE:C194(*; "BtnDemo"; Localized string:C991("BtnClose"))
			OBJECT SET VISIBLE:C603(*; "TxtSorry@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "TxtInfo@"; False:C215)
			Form.quit:=True
			
		End if 
		
	: (FORM Event.code=On Unload)
		
		ENABLE MENU ITEM:C149(Get menu bar reference:C979; 1; Current process:C322)
		
End case 
