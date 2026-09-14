//%attributes = {"invisible":true}

ARRAY TEXT:C222(TabControl; 0)
ARRAY TEXT:C222(TextTabControl; 0)

var $json : Collection

If (Get database localization:C1009(Current localization:K5:22)="ja")
	$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("Table_Init-ja.json").getText(); Is collection:K8:32)
Else 
	$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("Table_Init-en.json").getText(); Is collection:K8:32)
End if 

$json:=$json.orderBy("SampleSort")
COLLECTION TO ARRAY:C1562($json; TabControl; "Title"; TextTabControl; "Text")

//ALL RECORDS([Table_Init])
//ORDER BY([Table_Init]; [Table_Init]SampleSort)
//SELECTION TO ARRAY([Table_Init]Title; TabControl)
//SELECTION TO ARRAY([Table_Init]Text; TextTabControl)
//UNLOAD RECORD([Table_Init])

TabControl:=0
textInfo:=TextTabControl{1}
textExample:=TextTabControl{2}

var $platform : Integer
_O_PLATFORM PROPERTIES:C365($platform)

If ($platform=Windows:K25:3)
	ST SET ATTRIBUTES:C1093(textInfo; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 18)
	ST SET ATTRIBUTES:C1093(textExample; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 12)
End if 
