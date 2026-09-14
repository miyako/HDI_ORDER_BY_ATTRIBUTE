//%attributes = {"invisible":true}

Case of 
	: (Form event code:C388=On Header Click:K2:40)
		var $title : Text
		// reset the popup drop down to the 0 element
		_arrDistinctPath:=0
		
		// get the title of the header
		$title:=OBJECT Get title:C1068(Self:C308->)
		
		Case of 
			: ($title=":xliff:Name")
				
				// name is a concatened element formed by 2 attributes. So there is 2 linked ORDER BY ATTRIBUTES
				If (Self:C308->=1)
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "LastName"; >; *)
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "FirstName"; >)
					
					//this is for the arrow icon
					Self:C308->:=2
				Else 
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "LastName"; <; *)
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "FirstName"; <)
					
					//this is for the arrow icon
					Self:C308->:=1
				End if 
				
				// The City attribute
			: ($title=":xliff:City")
				If (Self:C308->=1)
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "City"; >)
					Self:C308->:=2
					
				Else 
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "City"; <)
					Self:C308->:=1
					
				End if 
				
				//The phone attributes
			: ($title=":xliff:Phone")
				If (Self:C308->=1)
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "Phone"; >)
					Self:C308->:=2
					
				Else 
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "Phone"; <)
					Self:C308->:=1
					
				End if 
				
			: ($title=":xliff:Company")
				If (Self:C308->=1)
					
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "CompanyName"; >)
					Self:C308->:=2
					
				Else 
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "CompanyName"; <)
					Self:C308->:=1
					
				End if 
				
			: ($title=":xliff:Age")
				
				If (Self:C308->=1)
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "Age"; >)
					Self:C308->:=2
					
				Else 
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "Age"; <)
					Self:C308->:=1
					
				End if 
				
			: ($title=":xliff:Address")
				
				If (Self:C308->=1)
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "Adress"; >)
					Self:C308->:=2
					
				Else 
					ORDER BY ATTRIBUTE:C1407([CONTACTS_2:8]; [CONTACTS_2:8]Info:2; "Adress"; <)
					Self:C308->:=1
					
				End if 
				
		End case 
End case 
