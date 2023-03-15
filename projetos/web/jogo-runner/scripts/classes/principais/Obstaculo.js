class Obstaculo {
    constructor(x, y, largura, altura, velocidadeMove, srcSprite, larguraSprite, alturaSprite, numColunasSprite, numLinhasSprite, animacoesObstaculo) {
        this.velocidadeMove = velocidadeMove;
        this.sprite = new Sprite(srcSprite, larguraSprite, alturaSprite, x, y, largura, altura, numColunasSprite, numLinhasSprite)
        this.animacoes = {
            movendo : new AnimacaoSprite(
                animacoesObstaculo.ANDANDO.NUM,
                animacoesObstaculo.ANDANDO.TEMPO,
                animacoesObstaculo.ANDANDO.COLUNAS,
                animacoesObstaculo.ANDANDO.AJUSTE_LARGURA,
                animacoesObstaculo.ANDANDO.AJUSTE_ALTURA,
                animacoesObstaculo.ANDANDO.AJUSTE_X_SRC,
                animacoesObstaculo.ANDANDO.AJUSTE_Y_SRC,
                animacoesObstaculo.ANDANDO.AJUSTE_X_CENARIO,
                animacoesObstaculo.ANDANDO.AJUSTE_Y_CENARIO
            )
        }
    }

    animationMovendo(){
        this.sprite.runAnimacao(this.animacoes.movendo);
    }

    executarAnimations(){
        this.animationMovendo();
    }

    mover(){
        this.sprite.posicao.moverParaTras(this.velocidadeMove)
    }

    isCenario(){
        if(this.sprite.posicao.x + this.sprite.dimensao.largura >= 0){
            return true;
        }else{
            return false;
        }
    }

    randomTempoInsercao(tempoInsercaoMax){
        return tempoInsercaoMax + (Math.floor( Math.random() * tempoInsercaoMax + 20) + 1);
    }

    colidio(obj, chao){
        let distanciaEntreObjX = 17 
        let distanciaEntreObjY = 35 
        
        if(obj.sprite.posicao.x - distanciaEntreObjX + obj.sprite.dimensao.largura > this.sprite.posicao.x && this.sprite.posicao.y + this.sprite.dimensao.altura > obj.sprite.posicao.y && 
            obj.sprite.posicao.x <= this.sprite.posicao.x + this.sprite.dimensao.largura  && 
            chao.isChao(obj) == true){
            return true; 
        } else if(obj.sprite.posicao.y - distanciaEntreObjY + obj.sprite.dimensao.altura >= this.sprite.posicao.y && 
            obj.sprite.posicao.x + obj.sprite.dimensao.largura > this.sprite.posicao.x && 
            obj.sprite.posicao.x <= this.sprite.posicao.x + this.sprite.dimensao.largura && 
            chao.isChao(obj) == false){
            return true;
        } else {
            return false;
        }
    }
}