#!/bin/bash

function PascalCase() {
  retorno=""
  for termo in $@; do
    temp=$(echo -n "${termo,,}" | tr -d '\n')
    temp=$(echo -n "${temp^}")
    retorno+="$temp"
  done
  echo "$retorno"
}

function camelCase() {
  retorno=""
  for termo in $@; do
    temp=$(echo -n "${termo,,}" | tr -d '\n')
    if [[ "$termo" != "$1" ]]; then
      temp=$(echo -n "${temp^}")
    fi
    retorno+="$temp"
  done
  echo "$retorno"
}

function EstaDentro() {
  local retorno="false"
  local termo=$1
  shift
  local lista=("$@")
  for item in "${lista[@]}"; do
    if [[ "$item" == "$termo" ]]; then
      retorno="true"
      break
    fi
  done
  echo "$retorno"
}

case $# in

  0)

      # Começando o script.

      clear
      echo "Boas vindas ao construtor de classes do Java, versão interativa."
      echo "Por convenção, recomenda-se escrever nomes de classes e interfaces"
      echo " em PascalCase, e nomes de atributos e métodos em camelCase."
      echo " "
      listaNomesPermissoes=('private' 'protected' 'public')
      listaNomesTiposPrimitivos=('boolean' 'byte' 'char' 'double' 'float' 'int' 'long' 'short')

      # Obtendo as primeiras informações do arquivo a ser escrito.

      read -p "Você vai escrever uma classe ou uma interface? (C/I) " classeOuInterface
      if [[ "${classeOuInterface^}" == "I" ]]; then
        read -p "Sua interface é default, private, protected ou public? " permissaoEntidade
      else
        read -p "Sua classe é default, private, protected ou public? " permissaoEntidade
      fi
      if [[ "${classeOuInterface^}" == "I" ]]; then
        read -p "Qual é o nome da sua interface? " nomeEntidade
      else
        read -p "Sua classe é abstrata? (S/N) " seAbstrata
        read -p "Qual é o nome da sua classe? " nomeEntidade
        if [[ "${seAbstrata^}" != "S" ]]; then
          read -p "Sua classe herda de outra classe? (S/N) " seHerda
          if [[ "${seHerda^}" == "S" ]]; then
            read -p "Qual é o nome da classe que ela extende? " classeMae
            # classeMae=$(PascalCase $classeMae)
          fi
        fi
        read -p "Sua classe implementa interfaces? (S/N) " seImplementa
        if [[ "${seImplementa^}" == "S" ]]; then
          listaInterfaces=()
          interface="MinhaInterface"
          while [[ -n "$interface" ]]; do
            read -p "Que interface ela implementa? (Apenas aperte Enter para encerrar.) " interface
            if [[ -z "$interface" ]]; then
              break
            else
              # interface=$(PascalCase $interface)
              listaInterfaces+=("$interface")
            fi
          done
        fi
      fi
      # nomeEntidade=$(PascalCase $nomeEntidade)

      # Escrevendo a primeira linha do arquivo.

      primeiraLinha=""
      # if [[ "${permissaoEntidade,,}" == "private" ||  "${permissaoClasse,,}" == "protected" ||  "${permissaoClasse,,}" == "public" ]]; then
      seEstaDentro=$(EstaDentro "${permissaoEntidade,,}" "${listaNomesPermissoes[@]}")
      if [[ "$seEstaDentro" == "true" ]]; then
        primeiraLinha+="${permissaoEntidade,,} "
      fi
      if [[ "${classeOuInterface^}" == "I" ]]; then
        primeiraLinha+="interface $nomeEntidade {\n\n"
      else
        if [[ "${seAbstrata^}" == "S" ]]; then
          primeiraLinha+="abstract "
        fi
        primeiraLinha+="class $nomeEntidade"
        if [[ "${seHerda^}" == "S" ]]; then
          primeiraLinha+=" extends $classeMae"
        fi
        if [[ "${seImplementa^}" == "S" && "${#listaInterfaces[@]}" -ne 0 ]]; then
          primeiraLinha+=" implements "
          for interface in "${listaInterfaces[@]}"; do
            primeiraLinha+="$interface"
            if [[ "$interface" != "${listaInterfaces[-1]}" ]]; then
              primeiraLinha+=", "
            fi
          done
        fi
        primeiraLinha+=" {\n\n"
      fi
      if [[ -e "$nomeEntidade.java" ]]; then
        touch "$nomeEntidade.java"
      fi
      printf "$primeiraLinha" > "$nomeEntidade.java"
      if [[ "${classeOuInterface^}" == "I" ]]; then
        echo "Escrevemos a primeira linha da sua interface!"
      else
        echo "Escrevemos a primeira linha da sua classe!"
      fi
      echo " "

      # Atributos, construtor, getters e setters

      if [[ "${classeOuInterface^}" == "I" ]]; then
        read -p "Sua interface tem atributos? (S/N) " seTemAtributos
      else
        if [[ "${seHerda^}" == "S" ]]; then
          read -p "Sua classe tem atributos além dos herdados? (S/N) " seTemAtributos
        else
          read -p "Sua classe tem atributos? (S/N) " seTemAtributos
        fi
      fi
      if [[ "${seTemAtributos^}" == "S" ]]; then

        # Preparação

        nomeAtributo="atributo"
        declare -i contadorAtributos=0
        listaAtributos=()
        listaTiposAtributos=()
        listaPermissoesAtributos=()
        soPrimitivas="true"
        printf "  // atributos\n" >> "$nomeEntidade.java"

        # Obtendo atributos

        if [[ "${classeOuInterface^}" == "I" ]]; then
          echo "Vamos agora anotar os atributos da sua interface; para encerrar,"
          echo " basta apertar Enter quando perguntarmos seu nome."
          echo "Vale lembrar que, para interfaces, seus atributos"
          echo " sempre serão públicos, estáticos e finais por padrão."
        else
          echo "Vamos agora anotar os atributos da sua classe; para encerrar,"
          echo " basta apertar Enter quando perguntarmos seu nome."
        fi
        echo "Se o seu atributo for um vetor (array), inclua \"[]\" após o tipo."
        echo "(Por exemplo, \"int[]\" para um vetor de números inteiros.)"
        echo " "

        while [[ -n "$nomeAtributo" ]]; do

          # Entrada de Dados

          echo "Vamos preencher os dados do atributo #$((contadorAtributos+1)):"
          read -p "Qual é o nome do seu atributo? " nomeAtributo
          if [[ -z "$nomeAtributo" ]]; then
            break
          else
            contadorAtributos=$((contadorAtributos+1))
            listaAtributos+=("$nomeAtributo")
          fi
          read -p "De que tipo é seu atributo? " tipoAtributo
          listaTiposAtributos+=("$tipoAtributo")
          if [[ "${classeOuInterface^}" != "I" ]]; then
            read -p "Seu atributo é default, private, protected ou public? " permissaoAtributo
            listaPermissoesAtributos+=("${permissaoAtributo,,}")
          fi

          # Checando Métrica e Escrevendo Linha

          linha="  "
          if [[ "${classeOuInterface^}" != "I" ]]; then
            seEstaDentro=$(EstaDentro "${permissaoAtributo,,}" "${listaNomesPermissoes[@]}")
            if [[ "$seEstaDentro" == "true" ]]; then
              linha+="${permissaoAtributo,,} "
            fi
          fi
          seEstaDentro=$(EstaDentro "${tipoAtributo,,}" "${listaNomesTiposPrimitivos[@]}")
          if [[ "$seEstaDentro" == "false" ]]; then
            soPrimitivas="false"
            linha+="$tipoAtributo "
          else
            linha+="${tipoAtributo,,} "
          fi
          linha+="$nomeAtributo;\n"
          printf "$linha" >> "$nomeEntidade.java"

        done
        printf "\n" >> "$nomeEntidade.java"
        if [[ "${classeOuInterface^}" == "I" ]]; then
          echo "Escrevemos os atributos da sua interface no arquivo."
        else
          echo "Escrevemos os atributos da sua classe no arquivo."
        fi
        echo -n "Que interessante! "
        if [[ "$soPrimitivas" == "true" ]]; then
          echo "Você só usou tipos primitivos para seus atributos!"
        else
          echo "Você usou pelo menos um tipo que não é primitivo"
          echo " (por exemplo, String) para seus atributos!"
        fi
        echo " "

        # Construtor

        if [[ "${classeOuInterface^}" != "I" && "${seAbstrata^}" != "S" ]]; then
          read -p "Você vai querer que sua classe tenha um método construtor? (S/N) " temConstrutor
          if [[ "${temConstrutor^}" == "S" ]]; then
            linha="  // construtor\n  "
            read -p "Qual é a permissão de acesso de seu construtor? " permissaoConstrutor
            seEstaDentro=$(EstaDentro "${permissaoConstrutor,,}" "${listaNomesPermissoes[@]}")
            if [[ "$seEstaDentro" == "true" ]]; then
              linha+="${permissaoConstrutor,,} "
            fi
            linha+="$nomeEntidade ("
            read -p "Você vai querer incluir os argumentos da sua classe no construtor? (S/N) " argumentosConstrutor
            if [[ "${argumentosConstrutor^}" == "S" ]]; then
              for ((indice = 0; indice < contadorAtributos; indice++)); do
                linha+="${listaTiposAtributos[$indice]} ${listaAtributos[$indice]}"
                if [[ $indice < $((contadorAtributos - 1)) ]]; then
                  linha+=", "
                fi
              done
            fi
            linha+=") {\n"
            if [[ "${seHerda^}" == "S" ]]; then
              linha+="    super() // insira dentro dos parênteses os atributos de $classeMae\n"
            fi
            for ((indice = 0; indice < contadorAtributos; indice++)); do
              linha+="    this.${listaAtributos[$indice]} = ${listaAtributos[$indice]}\n"
            done
            linha+="\n"
            printf "$linha" >> "$nomeEntidade.java"
            echo "Escrevemos o construtor de sua classe no arquivo."
          fi
          echo " "
        fi

        # Getters e Setters

        echo "Agora, vamos escrever os métodos get e set para os atributos."
        echo " "
        printf "  // getters e setters\n\n" >> "$nomeEntidade.java"
        for  ((indice = 0; indice < contadorAtributos; indice++)); do
          echo "Para o atributo #$((indice+1)):"
          read -p "Você vai querer um método get para ele? (S/N) " seQuerGet
          read -p "Você vai querer um método set para ele? (S/N) " seQuerSet
          if [[ "${seQuerGet^}" == "S" ]]; then
            if [[ "${classeOuInterface^}" != "I" && "${seAbstrata^}" != "S" ]]; then
              linha="  public ${listaTiposAtributos[$indice]} get${listaAtributos[$indice]^} () {\n    return this.${listaAtributos[$indice]};\n  }\n\n"
            else
              linha="  public ${listaTiposAtributos[$indice]} get${listaAtributos[$indice]^} ();\n\n"
            fi
            printf "$linha" >> "$nomeEntidade.java"
          fi
          if [[ "${seQuerSet^}" == "S" ]]; then
            if [[ "${classeOuInterface^}" != "I" && "${seAbstrata^}" != "S" ]]; then
              linha="  public void set${listaAtributos[$indice]^} (${listaTiposAtributos[$indice]} ${listaAtributos[$indice]}) {\n    this.${listaAtributos[$indice]} = ${listaAtributos[$indice]};\n  }\n\n"
            else
              linha="  public ${listaTiposAtributos[$indice]} set${listaAtributos[$indice]^} ();\n\n"
            fi
            printf "$linha" >> "$nomeEntidade.java"
          fi
        done
        echo "Escrevemos os métodos get e set dos atributos no arquivo."
        echo " "

      fi

      # Método principal

      if [[ "${classeOuInterface^}" != "I" && "${seAbstrata^}" != "S" ]]; then
        read -p "Sua classe terá um método principal, o 'main'? (S/N) " temMain
        if [[ "${temMain^}" == "S" ]]; then
          printf "  // outros métodos\n\n  // método principal\n  public static void main (String args[]) {\n\n    // insira seu código aqui\n\n  }\n\n" >> "$nomeEntidade.java"
          echo "Incluímos um método principal na sua classe."
        fi
      fi
      echo " "

      # Finalizando

      printf "}\n" >> "$nomeEntidade.java"
      if [[ "${classeOuInterface^}" == "I" ]]; then
        echo "E com isso, encerramos a sua interface!"
      else
        echo "E com isso, encerramos a sua classe!"
      fi
      echo "Você pode conferir o resultado abrindo o arquivo numa IDE,"
      echo " ou num editor de código como o Notepad++."
      echo "No Linux, você pode usar o vim, o nano ou o gedit."
      echo "Entre as IDEs, você pode usar o VS Code ou o Intellij."
      echo "Ou você pode usar qualquer outra ferramenta da sua preferência."
      echo "Agora que a parte mais maçante de escrever"
      echo " código orientado a objetos já foi concluída,"
      echo " regojize-se desenvolvendo a parte mais divertida: as regras de negócio!"
      echo " "

      ;;

  1)

      case $1 in

        -h)

               echo "Esta é a versão interativa do construtor de classes do Java."
               echo "Nela, nós vamos construir juntos a sua classe, passo a passo."
               echo "Enquanto conversamos e navegamos pelos menus desse programa,"
               echo " vamos montando um a um os elementos da sua classe."
               echo "Desde abstração e herança, passando por controle de acesso,"
               echo " implementação de interfaces, e polimorfismo de métodos."
               echo "O processo é rápido e dura poucos minutos; ou menos,"
               echo " se você for criar uma classe simples."
               echo "Mas também temos alguns comandos rápidos, que veremos abaixo."
               printf "\n"
               echo "  -h: Abre esta pequena janela de ajuda."
               echo "  -m: Constrói uma classe Main, vazia, com um método main."
               echo "  -p: Constrói uma classe Principal, vazia, com um método main."
               echo " "
               ;;

        -m)

               if [[ ! -e "Main.java" ]]; then
                 touch "Main.java"
               fi
               printf "public class Main {\n\n  public static void main (String args[]) {\n\n    System.out.println(\"Olá mundo!\");\n\n  }\n\n}\n" > "Main.java"
               ;;

        -p)

               if [[ ! -e "Principal.java" ]]; then
                 touch "Principal.java"
               fi
               printf "public class Principal {\n\n  public static void main (String args[]) {\n\n    System.out.println(\"Olá mundo!\");\n\n  }\n\n}\n" > "Principal.java"
               ;;

        *)

            echo "Argumento inválido."
            ;;

      esac
      ;;

  *)

      echo "Argumentos em demasia."
      ;;

esac
