#!/bin/bash

case $# in

    0)
        echo "Missing arguments!"
        ;;

    1)
        if [[ ! -e "$1.java" ]]; then
            touch "$1.java"
        fi
        echo "public class $1 {" > "$1.java"
        printf "\n" >> "$1.java"
        echo "    public static void main (String args[]) {" >> "$1.java"
        printf "\n" >> "$1.java"
        echo "    }" >> "$1.java"
        printf "\n" >> "$1.java"
        echo "}" >> "$1.java"
        ;;

    *)
        numArgs=$#
        if [[ $((numArgs % 2)) -eq 0 ]]; then
            echo "The number of arguments must be odd!"
        else
            numAttrs=$(((numArgs - 1) / 2))
            if [[ ! -e "$1.java" ]]; then
                touch "$1.java"
            fi
            echo "public class $1 {" > "$1.java"

            printf "\n    // attributes\n" >> "$1.java"
            declare -i counter=1
            line=""
            listAttrTypes=()
            listAttrNames=()
            for arg in "$@"; do
                if [[ $arg == $1 ]]; then
                    continue
                else
                    counter+=1
                    if [[ $((counter % 2)) -eq 0 ]]; then
                        listAttrTypes+=("$arg")
                        line="    private $arg "
                    else
                        listAttrNames+=("$arg")
                        line+="$arg;"
                        echo "$line" >> "$1.java"
                    fi
                fi
            done

            printf "\n    // constructor\n" >> "$1.java"
            line="    public $1 ("
            for ((index = 0; index < numAttrs; index++)); do
                line+="${listAttrTypes[$index]} ${listAttrNames[$index]}"
                if [[ $index -lt $((numAttrs - 1)) ]]; then
                    line+=", "
                else
                    line+=") {"
                fi
            done
            echo "$line" >> "$1.java"

            for name in "${listAttrNames[@]}"; do
                echo "        this.$name = $name;" >> "$1.java"
            done
            echo "    }" >> "$1.java"

            printf "\n    // getters and setters\n\n" >> "$1.java"
            for ((index = 0; index < numAttrs; index++)); do
                echo "    public ${listAttrTypes[$index]} get${listAttrNames[$index]^} () {" >> "$1.java"
                echo "        return this.${listAttrNames[$index]};" >> "$1.java"
                printf "    }\n\n" >> "$1.java"
                echo "    public void set${listAttrNames[$index]^} (${listAttrTypes[$index]} ${listAttrNames[$index]}) {" >> "$1.java"
                echo "        this.${listAttrNames[$index]} = ${listAttrNames[$index]};" >> "$1.java"
                printf "    }\n\n" >> "$1.java"
            done

            printf "\n    // main\n" >> "$1.java"
            echo "    public static void main (String args[]) {" >> "$1.java"
            printf "\n" >> "$1.java"
            echo "    }" >> "$1.java"
            printf "\n" >> "$1.java"
            echo "}" >> "$1.java"

        fi
        ;;

esac
