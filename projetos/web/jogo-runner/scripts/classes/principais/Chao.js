class Chao {
    constructor(x, y, largura, altura, srcSprite, larguraSprite, alturaSprire, velocidadeMove) {
        this.distanciaSprites = x + largura + 62;
        this.sprite = new Sprite(srcSprite, larguraSprite, alturaSprire, x, y, largura, altura)
        this.spriteAux = new Sprite(srcSprite, larguraSprite, alturaSprire, this.distanciaSprites, y, largura, altura)
        this.velocidadeMove = velocidadeMove;
        
    }

    isChao(obj){
        if(obj.sprite.posicao.y > this.sprite.posicao.y - obj.sprite.dimensao.altura){
            return true
        }else{
            return false;
        }
    }

    move(){
        this.sprite.posicao.x -= this.velocidadeMove; 
        this.spriteAux.posicao.x -= this.velocidadeMove; 
        if(this.sprite.posicao.x  + this.sprite.dimensao.largura + (this.sprite.spriteSheet.dimensao.largura - this.sprite.dimensao.largura)  < 0){ 
            this.sprite.posicao.x = this.sprite.dimensao.largura;
        }else if(this.spriteAux.posicao.x  + this.sprite.dimensao.largura + (this.spriteAux.spriteSheet.dimensao.largura - this.sprite.dimensao.largura)  < 0){
            this.spriteAux.posicao.x = this.sprite.dimensao.largura;
        }
    }

    colocaNoChao(obj){
        obj.sprite.posicao.novoY(this.getPosicaoParaChao(obj))
    }

    getPosicaoParaChao(obj){
        return this.sprite.posicao.y - obj.sprite.dimensao.altura + 5;
    }

    getPosicaoParaChaoAltura(altura){
        return this.sprite.posicao.y - altura + 5;
    }

    runAnimacaoMove(){
        this.sprite.insertSprite();
        this.spriteAux.insertSprite();
        this.move()
    }
}