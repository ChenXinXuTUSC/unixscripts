#!/bin/bash

source ~/.bash_func.d/recursivedo.sh
source ~/.bash_func.d/colorful-prefix.sh

# other tool kits
function sourcesh()
{
    file=${1}
    if [[ ${file} == *.sh ]] && [ -f ${file} ]; then
        source ${file}
        # echo "sourced ${file}"
    fi
}
