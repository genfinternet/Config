#!/bin/sh

function exist_file()
{
    if [ -e $1 ]; then
        return 1
    else
        return 0
    fi
}

function create_c()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        a=`basename $1`
        a="${a%.*}"
        echo "#include <stdio.h>" >>$1
        echo "#include <stdlib.h>" >>$1
        echo "" >>$1
        if [ $a != "main" ]; then
            echo "#include \""$a.h"\"" >>$1
            echo "" >>$1
        fi
        echo "int main(void)" >>$1
        echo "{" >>$1
        echo "    return 0;" >>$1
        echo "}" >>$1
    fi
}

function create_h()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        a=`basename $1`
        a=`echo $a | tr 'a-z.' 'A-Z_'`
        echo "#ifndef" $a >>$1
        echo "# define" $a >>$1
        echo "" >>$1
        echo "#endif /* !"$a "*/" >>$1
    fi  
}

function create_java()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
    #    a=`basename $1`
    #    a="${a%.*}"
    #    name=`echo $a | sed "s/\([a-z]\)/\L\1/g"`
    #    class=`echo $name | sed "s/-\([a-z]\)/\U\1/g" | sed "s/\(^[a-z]\)/\U\1/g"`
    #    echo "/**" >>$1
    #    echo " ** \file $name.cc" >>$1
    #    echo " ** \brief Implementation of $class" >>$1
    #    echo " */" >>$1
    #    echo "" >>$1
    #    echo "#include <$name.hh>" >>$1
    #    echo "" >>$1
    #    echo "$class::$class()" >>$1
    #    echo "{}" >>$1
    #    echo "$class::~$class()" >>$1
    #    echo "{}" >>$1
    fi
}

function create_cc()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        a=`basename $1`
        a="${a%.*}"
        name=`echo $a | sed "s/\([a-z]\)/\L\1/g"`
        class=`echo $name | sed "s/-\([a-z]\)/\U\1/g" | sed "s/\(^[a-z]\)/\U\1/g"`
        echo "/**" >>$1
        echo " ** \file $name.cc" >>$1
        echo " ** \brief Implementation of $class" >>$1
        echo " */" >>$1
        echo "" >>$1
        echo "#include <$name.hh>" >>$1
        echo "" >>$1
        echo "$class::$class()" >>$1
        echo "{}" >>$1
        echo "$class::~$class()" >>$1
        echo "{}" >>$1
    fi
}

function create_sql()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        a=`basename $1`
        a=`echo $a | tr 'a-z.' 'A-Z_'`
        echo "DROP TABLE IF EXISTS table_name CASCADE;" >>$1
        echo "" >>$1
        echo "CREATE TABLE table_name" >>$1
        echo "(" >>$1
        echo "    id SERIAL NOT NULL," >>$1
        echo "    PRIMARY KEY (id)" >>$1
        echo ")" >>$1
    fi  
}

function create_hh()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        a=`basename $1`
        a="${a%.*}"
        name=`echo $a | sed "s/\([a-z]\)/\L\1/g"`
        class=`echo $name | sed "s/-\([a-z]\)/\U\1/g" | sed "s/\(^[a-z]\)/\U\1/g"`
        echo "/**" >>$1
        echo " ** \file $name.hh" >>$1
        echo " ** \brief Declaration of $class" >>$1
        echo " */" >>$1
        echo "" >>$1
        echo "#pragma once" >>$1
        echo "" >>$1
        echo "#include <stdio>" >>$1
        echo "" >>$1
        echo "class $class" >>$1
        echo "{" >>$1
        echo "  public:" >>$1
        echo "    $class();" >>$1
        echo "    ~$class();" >>$1
        echo "  private:" >>$1
        echo "" >>$1
        echo "  protected:" >>$1
        echo "" >>$1
        echo "}" >>$1
        echo "#include <$name.hxx>" >>$1
    fi
}

function create_hxx()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        a=`basename $1`
        a="${a%.*}"
        name=`echo $a | sed "s/\([a-z]\)/\L\1/g"`
        class=`echo $name | sed "s/-\([a-z]\)/\U\1/g" | sed "s/\(^[a-z]\)/\U\1/g"`
        echo "/**" >>$1
        echo " ** \file $name.cc" >>$1
        echo " ** \brief Inline methods of $class" >>$1
        echo " */" >>$1
        echo "" >>$1
        echo "#pragma once" >>$1
        echo "#include <$name.hh>" >>$1
    fi
}

function create_tig()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        echo -e "/* file $1 */\nlet\n\nin\n\nend">>$1
    fi  
}

function create_py()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        chmod 740 $1
        echo -e "#!/bin/python3\n\n">>$1
    fi
}

function create_tih()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        echo -e "/* file $1 */\n\n">>$1
    fi  
}
function create_sh()
{
    exist_file $1
    if [ $? -eq 0 ]; then
        touch $1
        chmod 740 $1
        echo -e "#!/bin/sh\n\n">>$1
    fi  
}

function verbose()
{
    if [ "$FLAG_VERBOSE" = "on" ]; then
        if [ $1 = "creation" ]; then
            shift
            echo -e "\e[34mCreating file \`\e[36m$@\e[34m'\e[0m" 
        elif [ $1 = "openning" ]; then
            shift
            for i in $list_to_open; do
                file=`basename $i`
                list_to_print="$list_to_print $file"
            done
            echo -e "\e[34mOpenning \e[36m$list_to_print\e[0m"
        elif [ $1 = "call" ]; then
            shift
            echo -e "\e[34mCalling function create_$@\e[0m"
        fi
    fi
}

create_file()
{
    extention=$1
    shift
    verbose "call" $extention
    if [ $FLAG_DEBUG != "on" ]; then
        create_$extention $@
    fi
    verbose "creation" $@
}

function get_list_doc()
{
    list_to_open=""
    for i in $@; do
        if [ -f $i ]; then
            list_to_open="$list_to_open $i"
        else
            echo $i | grep -E "\.$" >/dev/null 2>/dev/null
            if [ $? -eq 0 ]; then
                bool=""
                for j in $SUPPORTED_EXTENTIONS; do
                    if [ -f $i$j ]; then
                        list_to_open="$list_to_open $i$j"
                        bool="$bool 1"
                    fi
                done
                if [ "$bool" = "" ]; then
                    for j in $PRIORITY_PICKS; do
                        create_file $j $i$j
                        list_to_open="$list_to_open $i$j"
                    done
                fi
            else
                for j in $SUPPORTED_EXTENTIONS; do
                    echo $i | grep -E "\.$j$" >/dev/null 2>/dev/null
                    if [ $? -eq 0 ]; then
                        create_file $j $i
                    fi
                done
                list_to_open="$list_to_open $i"
            fi
        fi
    done
    verbose "openning" $list_to_open
    if [ "$FLAG_DEBUG" != "on" ]; then
        vim -O $list_to_open
    fi
}

get_list_doc $@
