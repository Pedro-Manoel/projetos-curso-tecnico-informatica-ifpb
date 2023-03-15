class Fisica {
    constructor(gravidade){
        this.gravidade = gravidade;
    }

    submeteGravidade(obj, chao){
        obj.deslocamentoY += this.gravidade;
        obj.sprite.posicao.moverParaBaixo(obj.deslocamentoY);
        
        if(chao.isChao(obj)){
            chao.colocaNoChao(obj);
            if(obj.numPulo){
                obj.numPulo = 0;
            }
        }
    }
}