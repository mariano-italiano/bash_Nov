#!/usr/bin/awk -f

BEGIN {
	var="programowanie AWK"
	print var

	str1="Programujemy " 
	str2="w AWK" 
	str3=str1 str2 
	print str3

	var3=3+2
	print var3

	x=rand()
	print x

	lowerStr = "witam"
	print toupper(lowerStr)
       
	longStr = "tekst oddzielony wieloma spacjami"
	split(longStr,slowa, " ")
	print slowa[1],slowa[2]
	
	nextStr = "Długość tekstu"
	print length(nextStr)
}
