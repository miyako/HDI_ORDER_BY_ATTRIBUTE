Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		C_LONGINT:C283($col; $row)
		
		LISTBOX GET CELL POSITION:C971(*; "contactsList"; $col; $row)
		
		GOTO SELECTED RECORD:C245([CONTACTS_2:8]; $row)
		vStringifyObject:=JSON Stringify:C1217([CONTACTS_2:8]Info:2)
		
End case 