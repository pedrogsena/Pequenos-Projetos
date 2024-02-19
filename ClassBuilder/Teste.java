public class Teste {

    // attributes
    private String nome;
    private int numero;
    private double preco;

    // constructor
    public Teste (String nome, int numero, double preco) {
        this.nome = nome;
        this.numero = numero;
        this.preco = preco;
    }

    // getters and setters

    public String getNome () {
        return this.nome;
    }

    public void setNome (String nome) {
        this.nome = nome;
    }

    public int getNumero () {
        return this.numero;
    }

    public void setNumero (int numero) {
        this.numero = numero;
    }

    public double getPreco () {
        return this.preco;
    }

    public void setPreco (double preco) {
        this.preco = preco;
    }


    // main
    public static void main (String args[]) {

    }

}
