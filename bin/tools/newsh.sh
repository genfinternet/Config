#!/bin/sh
exist_file()
{
    if [ -e $1 ]; then
        return 1
    else
        return 0
    fi
}

if [ "$#" = "0" ]; then
	echo "State your file's name";
else
	if [ "$#" = "1" ]; then
		cd .;
	elif [ "$2" = "0" ]; then
		cd ~/bin; 
	else
		cd $2;
	fi
    
    exist_file $1.sh
    if [ $? -eq 0 ]; then
        echo -e "#!/bin/sh\n\n" $1.sh;
    	chmod 740 $1.sh;
    fi
    vim $1.sh;
fi
