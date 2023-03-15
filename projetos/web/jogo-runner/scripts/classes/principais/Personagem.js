class Personagem {
    constructor(x, y, largura, altura, alturaBaixo, forcaPulo, numMaxPulo, srcSprite, larguraSprite, alturaSprite, numColunasSprite, numLinhasSprite, animacoesPersonagem) {
        this.deslocamentoY = 0;
        this.forcaPulo = forcaPulo;
        this.numMaxPulo = numMaxPulo;
        this.numPulo = 0; 
        this.sprite = new Sprite(srcSprite, larguraSprite, alturaSprite, x, y, largura, altura, numColunasSprite, numLinhasSprite)
        this.alturaBaixo = alturaBaixo;
        this.abaixado = false;
        this.estado = 'parado';
        this.animacoes = { 
            andando : new AnimacaoSprite(
                animacoesPersonagem.ANDANDO.NUM,
                animacoesPersonagem.ANDANDO.TEMPO,
                animacoesPersonagem.ANDANDO.COLUNAS,
                animacoesPersonagem.ANDANDO.AJUSTE_LARGURA,
                animacoesPersonagem.ANDANDO.AJUSTE_ALTURA,
                animacoesPersonagem.ANDANDO.AJUSTE_X_SRC,
                animacoesPersonagem.ANDANDO.AJUSTE_Y_SRC,
                animacoesPersonagem.ANDANDO.AJUSTE_X_CENARIO,
                animacoesPersonagem.ANDANDO.AJUSTE_Y_CENARIO
            ),
            parado : new AnimacaoSprite(
                animacoesPersonagem.PARADO.NUM,
                animacoesPersonagem.PARADO.TEMPO,
                animacoesPersonagem.PARADO.COLUNAS,
                animacoesPersonagem.PARADO.AJUSTE_LARGURA,
                animacoesPersonagem.PARADO.AJUSTE_ALTURA,
                animacoesPersonagem.PARADO.AJUSTE_X_SRC,
                animacoesPersonagem.PARADO.AJUSTE_Y_SRC,
                animacoesPersonagem.PARADO.AJUSTE_X_CENARIO,
                animacoesPersonagem.PARADO.AJUSTE_Y_CENARIO
            ),
            pulando : new AnimacaoSprite(
                animacoesPersonagem.PULANDO.NUM,
                animacoesPersonagem.PULANDO.TEMPO,
                animacoesPersonagem.PULANDO.COLUNAS,
                animacoesPersonagem.PULANDO.AJUSTE_LARGURA,
                animacoesPersonagem.PULANDO.AJUSTE_ALTURA,
                animacoesPersonagem.PULANDO.AJUSTE_X_SRC,
                animacoesPersonagem.PULANDO.AJUSTE_Y_SRC,
                animacoesPersonagem.PULANDO.AJUSTE_X_CENARIO,
                animacoesPersonagem.PULANDO.AJUSTE_Y_CENARIO
            )
            
        };
    }


    pular(){
       if(this.numMaxPulo > this.numPulo){
           this.deslocamentoY = -this.forcaPulo; 
       }
       this.numPulo++;
    }

    animationAndar(){
        if(this.estado != 'pulando' && this.estado != 'parado'){ 
            this.sprite.runAnimacao(this.animacoes.andando);
        }
    }

    animationFicarParado(){
        if(this.estado == 'parado'){
            this.sprite.runAnimacao(this.animacoes.parado);
        }
    }

    animationPulando(){
        if(this.estado == 'pulando'){
            this.sprite.runAnimacao(this.animacoes.pulando);
        }
    }

    executarAnimations(){
        this.animationFicarParado();
        this.animationAndar();
        this.animationPulando();
    }

    voltarAlturaNormal(){
        this.sprite.dimensao.altura += this.alturaBaixo;
        this.abaixado = false;
    }

    abaixar(){
        this.sprite.dimensao.altura -= this.alturaBaixo;
        this.abaixado = true;
    }
}