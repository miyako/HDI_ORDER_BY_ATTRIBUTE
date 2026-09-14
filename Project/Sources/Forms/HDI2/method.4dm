Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Get menu bar reference:C979="")
			SET MENU BAR:C67(1)
		End if 
		
		DISABLE MENU ITEM:C150(Get menu bar reference:C979; 1; Current process:C322)
		
		
		hdi_init
		
		If (ds:C1482.CONTACTS_2.getCount()=0)
			
			If (Get database localization:C1009(Current localization:K5:22)="ja")
				$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("CONTACTS_2-ja.json").getText(); Is collection:K8:32)
			Else 
				$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("CONTACTS_2-en.json").getText(); Is collection:K8:32)
			End if 
			
			ds:C1482.CONTACTS_2.fromCollection($json)
			
		End if 
		
		ALL RECORDS:C47([CONTACTS_2:8])
		CREATE EMPTY SET:C140([CONTACTS_2:8]; "ListboxSet1")
		GOTO SELECTED RECORD:C245([CONTACTS_2:8]; 1)
		ADD TO SET:C119([CONTACTS_2:8]; "ListBoxSet1")
		vStringifyObject:=JSON Stringify:C1217([CONTACTS_2:8]Info:2)
		
		ARRAY TEXT:C222(_arrDistinctPath; 0)
		DISTINCT ATTRIBUTE PATHS:C1395([CONTACTS_2:8]Info:2; _arrDistinctPath)
		_arrDistinctPath{0}:=Localized string:C991("Order by")
		
		OBJECT SET HELP TIP:C1181(*; "Header10"; "OB Get([CONTACTS_2]Info;\"LastName\")+\" \"+OB Get([CONTACTS_2]Info;\"FirstName\")")
		OBJECT SET HELP TIP:C1181(*; "Header11"; "OB Get([CONTACTS_2]Info;\"City\")")
		OBJECT SET HELP TIP:C1181(*; "Header12"; "OB Get([CONTACTS_2]Info;\"Phone\")")
		OBJECT SET HELP TIP:C1181(*; "Header4"; "OB Get([CONTACTS_2]Info;\"Company\")")
		OBJECT SET HELP TIP:C1181(*; "Header1"; "OB Get([CONTACTS_2]Info;\"Age\")")
		OBJECT SET HELP TIP:C1181(*; "Header2"; "OB Get([CONTACTS_2]Info;\"address\")")
		
	: (Form event code:C388=On Unload:K2:2)
		
		ENABLE MENU ITEM:C149(Get menu bar reference:C979; 1; Current process:C322)
		
End case 
