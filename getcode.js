with(new ActiveXObject('Msxml2.XMLHTTP')){
	Open('GET','https://gist.githubusercontent.com/raw/feaa63c35f4c2baab24c9aaf9b3f4e47',0)
	Send()
	WScript.Echo(readBy(responseBody,'utf-8'))
}

function readBy(bin,charset){
	var steam = new ActiveXObject("ADODB.Stream")
	steam.Type = 1
	steam.Mode = 3
	steam.Open()
	steam.Write(bin)
	steam.Position = 0
	steam.Type = 2
	steam.Charset = charset
	return steam.ReadText
}