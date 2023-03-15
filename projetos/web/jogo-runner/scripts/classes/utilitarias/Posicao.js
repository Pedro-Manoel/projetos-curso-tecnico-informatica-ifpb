class Posicao {
    constructor(x, y){
        this.x = x;
        this.y = y;
    }

    moverParaCima(valor){
        this.subtraiLinearY(valor);
    }

    moverParaBaixo(valor){
        this.somaLinearY(valor);
    }

    moverParaFrente(valor){
        this.somaLinearX(valor);
    }

    moverParaTras(valor){
        this.subtraiLinearX(valor);
    }

    novoY(valor){
        this.y = valor;
    }

    novoX(valor){
        this.x = valor;
    }

    somaLinearY(valor){
        this.y += valor;
    }

    subtraiLinearY(valor){
        this.y -= valor;
    }

    multiplicaLinearY(valor){
        this.y *= valor;
    }

    divideLinearY(valor){
        this.x /= valor;
    }

    somaLinearX(valor){
        this.x += valor;
    }

    subtraiLinearX(valor){
        this.x -= valor;
    }

    multiplicaLinearX(valor){
        this.x *= valor;
    }

    divideLinearX(valor){
        this.x /= valor;
    }
}