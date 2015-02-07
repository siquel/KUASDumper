while test $# -gt 0; do
         case "$1" in
               -y|--year)
                     shift
                     if test $# -gt 0; then
			 export YEAR=$1
                     else
			echo "no year specified"
			exit 1
		     fi
                     shift
		     ;;
               -d|--date)
		    shift
                    if test $# -gt 0; then
			export DATE=$1
		    else
			echo "no date specified"
		        exit 1
                    fi
		    shift
		    ;;
		-m|--month)
			shift
			if test $# -gt 0; then
				export MONTH=$1
			else
				echo "no month specified"
				exit 1
			fi
			shift
			;;
                -g|--group)
			shift
			if test $# -gt 0; then
				export GROUP=$1
			else
				echo "no group specified"
				exit 1
			fi
			shift
			;;
                -o|--output)
			shift
			if test $# -gt 0; then
				export OUTPUT_FILE=$1
			else
				echo "no output file specified"
				exit 1
			fi
			shift
			;;
		*)
			break
			;;

          esac
done

if [ -z "$GROUP" ]; then
	echo "no group specified"
	exit 1;
fi

if [ -z "$OUTPUT_FILE" ]; then
	echo "no output file specified"
	exit 1;
fi

if [ -z "$YEAR" ]; then
    export YEAR=$(/bin/date +"%y") 
fi

if [ -z "$DATE" ]; then
    export DATE=$(/bin/date +"%d")
fi

if [ -z "$MONTH" ]; then
    export MONTH=$(/bin/date +"%m")
fi

   
curl --cookie "$(cat cookie)"  "http://asp.kajak.fi:88/v8/kalenterit2/index.php?av_v=1&av=${YEAR}${MONTH}${DATE}140907140901&cluokka=$GROUP&kt=lk&laji=&guest=asiakas&lang=fin&ui=&yks=&apvm=140908&tiedot=kaikki&ss_ttkal=&ccv=&yhopt=&b=1409565111" --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Firefox/31.0"  -o "$OUTPUT_FILE" -H "Content-Type: text/html; charset=ISO-8859-1" 
