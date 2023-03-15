class Sprite {
    constructor(srcSpriteSheet, larguraSpriteSheet, alturaSpriteSheet, x, y, largura, altura, numColunasSpriteSheet, numLinhasSpriteSheet){
        this.spriteSheet = new SpriteSheet(srcSpriteSheet, larguraSpriteSheet, alturaSpriteSheet, numColunasSpriteSheet, numLinhasSpriteSheet);
        this.posicao = new Posicao(x,y); 
        this.dimensao = new Dimensao(largura,altura);
        this.src = new Posicao(); 
        this.frameAtual = 0;
        this.tempoAnimacaoAtual = 0;
    }

    atualizarFrame(animacaoSprite){
        if(this.tempoAnimacaoAtual == 0){
            this.frameAtual =  ++this.frameAtual % animacaoSprite.numColunas; 
            this.src.x = this.frameAtual * this.spriteSheet.SpritePadrao.largura;
            this.src.y = animacaoSprite.num * this.spriteSheet.SpritePadrao.altura;
           
            if(this.tempoAnimacaoAtual == 0){
                this.tempoAnimacaoAtual = animacaoSprite.tempo;
            }
        }else{
            this.tempoAnimacaoAtual--;
        }
    }
    
    aplicarAjustesAnimacao(animacaoSprite){
        if(animacaoSprite.ajustes.dimensao.largura != undefined){
            this.spriteSheet.SpritePadrao.largura += animacaoSprite.ajustes.dimensao.largura;
        }
        if(animacaoSprite.ajustes.dimensao.altura != undefined){
            this.spriteSheet.SpritePadrao.altura += animacaoSprite.ajustes.dimensao.altura;      
        }
        if(animacaoSprite.ajustes.posicaoSrc.x != undefined){
            this.src.x += animacaoSprite.ajustes.posicaoSrc.x
        }
        if(animacaoSprite.ajustes.posicaoSrc.y != undefined){
            this.src.y += animacaoSprite.ajustes.posicaoSrc.y 
        }
        if(animacaoSprite.ajustes.posicaoCenario.x != undefined){
            this.posicao.x += animacaoSprite.ajustes.posicaoCenario.x 
        }
        if(animacaoSprite.ajustes.posicaoCenario.y != undefined){
            this.posicao.y += animacaoSprite.ajustes.posicaoCenario.y
        }
    }

    runAnimacao(animacaoSprite){
        this.numAnimacaoAtual = animacaoSprite.num;
        this.atualizarFrame(animacaoSprite);
        
        let src = new Posicao(this.src.x, this.src.y)
        let dimensao =  new Dimensao(this.spriteSheet.SpritePadrao.largura, this.spriteSheet.SpritePadrao.altura)        
        let posicao = new Posicao(this.posicao.x, this.posicao.y);
                
        canvas.insertSpriteAnimado(this);
    
        this.src = src ;
        this.spriteSheet.SpritePadrao = dimensao;
        this.posicao = posicao;
    }

    insertSprite(){
        canvas.insertSpriteEstatico(this);
    }
}