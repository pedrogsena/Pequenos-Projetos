# ClassBuilder-Java
**Autor:** Pedro Gabriel Sena Cardoso  
**Versão:** 0.1.0

Script em Bash que constrói uma classe em Java.  
O primeiro argumento deve ser o nome da classe.  
Os demais argumentos devem ser, em sequência, o tipo e o nome de cada atributo da classe.  
O script não cria arquivo algum se um número par de argumentos for passado.  
Por exemplo:
* `bash ClassBuilder-Java.sh ClasseVazia` cria um arquivo chamado `ClasseVazia.java`, que consiste numa classe sem atributos, e que contém apenas um método *main*, este vazio.
* `bash ClassBuilder-Java.sh Teste String nome int numero double preco` cria um arquivo chamado `Teste.java`, que contém três atributos:
    * `nome`, do tipo `String`;
    * `numero`, do tipo `int`;
    * e `preco`, do tipo `double`.

Além de um método construtor, métodos *get* e *set* para cada atributo, e um método *main*, este vazio.

## Changelog

\[0.1.0\]: Script criado.
