class GameEngine {
    constructor() {
        this.const = {
            CENARIO : {
                SPRITE : {
                    SRC : 'img/plano-de-fundo.png',
                    POSICAO_X : 0,
                    POSICAO_Y : 0,
                    LARGURA : canvas.dimensao.largura,
                    ALTURA : canvas.dimensao.altura,
                }
            },
            CHAO : {
                POSICAO_Y : 150,
                POSICAO_X : 0,
                ALTURA : 100,
                VELOCIDADE_MOVE : 0.5,
                SPRITE : {
                    SRC : 'img/chao-2.png',
                    LARGURA : 1084,
                    ALTURA : 153,
                }
            },
            PERSONAGEM : {
                POSICAO_X : 70,
                ALTURA : 100,
                ALTURA_ABAIXADO : 50,
                LARGURA : 100,
                FORCA_PULO : 22,
                NUM_MAX_PULO : 1,
                SPRITE_SHEET : {
                    SRC : 'img/per-1.1.png',
                    LARGURA : 417,
                    ALTURA : 339,
                    COLUNAS : 4,
                    LINHAS : 3,
                },
                ANIMACOES : {
                    ANDANDO : {
                        NUM : 1,
                        TEMPO : 6,
                        COLUNAS : 4,
                        AJUSTE_LARGURA : 4,
                        AJUSTE_ALTURA : -12,
                        AJUSTE_X_SRC : -5,
                        AJUSTE_Y_SRC : undefined,
                        AJUSTE_X_CENARIO : undefined,
                        AJUSTE_Y_CENARIO : undefined,
                    },
                    PARADO : {
                        NUM : 0,
                        TEMPO : 6,
                        COLUNAS : 4,
                        AJUSTE_LARGURA : 4,
                        AJUSTE_ALTURA : -18,
                        AJUSTE_X_SRC : 15,
                        AJUSTE_Y_SRC : 50,
                        AJUSTE_X_CENARIO : undefined,
                        AJUSTE_Y_CENARIO : undefined,
                    },
                    PULANDO : {
                        NUM : 1,
                        TEMPO : 0,
                        COLUNAS : 1,
                        AJUSTE_LARGURA : undefined,
                        AJUSTE_ALTURA : undefined,
                        AJUSTE_X_SRC : undefined,
                        AJUSTE_Y_SRC : undefined,
                        AJUSTE_X_CENARIO : undefined,
                        AJUSTE_Y_CENARIO : undefined,
                    }
                },
            },
            OBSTACULO : {
                TEMPO_INSERCAO: 70,
                INTERVALO_INSERCAO : 0,
                VELOCIDADE_MOVE_INICIAL: 8,
                TIPO_STR : ['TRONCO_PEQUENO','TRONCO_GRANDE', 'BRUXA'], 
                TIPO : {
                    TRONCO_PEQUENO : {
                        SPRITE : {
                            LARGURA : 60,
                            ALTURA : 60,
                            POSICAO_X : canvas.dimensao.largura,
                            POSICAO_Y : 0,
                        },
                        SPRITE_SHEET : {
                            SRC : 'img/obs-2.png',
                            LARGURA : 280,
                            ALTURA : 148,
                            COLUNAS : 4,
                            LINHAS : 2,
                        },
                        ANIMACOES : {
                            ANDANDO : {
                                NUM : 1,
                                TEMPO : 8,
                                COLUNAS : 4,
                                AJUSTE_LARGURA : undefined,
                                AJUSTE_ALTURA : undefined,
                                AJUSTE_X_SRC : undefined,
                                AJUSTE_Y_SRC : undefined,
                                AJUSTE_X_CENARIO : undefined,
                                AJUSTE_Y_CENARIO : undefined,
                            }
                        }
                    },
                    TRONCO_GRANDE : {
                        SPRITE : {
                            LARGURA : 140,
                            ALTURA : 120,
                            POSICAO_X : canvas.dimensao.largura,
                            POSICAO_Y : 0, 
                        },
                        SPRITE_SHEET : {
                            SRC : 'img/obs-3.png',
                            LARGURA : 3612,
                            ALTURA : 1940,
                            COLUNAS : 18,
                            LINHAS : 10,
                        },
                        ANIMACOES : {
                            ANDANDO : {
                                NUM : 1,
                                TEMPO : 8,
                                COLUNAS : 6,
                                AJUSTE_LARGURA : -25,
                                AJUSTE_ALTURA : -30,
                                AJUSTE_X_SRC : 18, 
                                AJUSTE_Y_SRC : 55, 
                                AJUSTE_X_CENARIO : undefined,
                                AJUSTE_Y_CENARIO : undefined,
                            }
                        }
                    },
                    BRUXA : {
                        SPRITE : {
                            LARGURA : 119,
                            ALTURA : 73,
                            POSICAO_Y : -60,
                            POSICAO_X : canvas.dimensao.largura 
                        },
                        SPRITE_SHEET : {
                            SRC : 'img/obs-1.png',
                            LARGURA : 358,
                            ALTURA : 73,
                            COLUNAS : 3,
                            LINHAS : 1,
                        },
                        ANIMACOES : {
                            ANDANDO : {
                                NUM : 0,
                                TEMPO : 6,
                                COLUNAS : 3,
                                AJUSTE_LARGURA : undefined,
                                AJUSTE_ALTURA : undefined,
                                AJUSTE_X_SRC : undefined,
                                AJUSTE_Y_SRC : undefined,
                                AJUSTE_X_CENARIO : undefined,
                                AJUSTE_Y_CENARIO : undefined,
                            }
                        } 
                    }
                }
        
            },
            FISICA : {
                GRAVIDADE : 0.9
            }
            
        };
        this.cenario = new Cenario(
            this.const.CENARIO.SPRITE.SRC, 
            this.const.CENARIO.SPRITE.POSICAO_X, 
            this.const.CENARIO.SPRITE.POSICAO_Y,
            this.const.CENARIO.SPRITE.LARGURA,
            this.const.CENARIO.SPRITE.ALTURA
        );
        this.chao = new Chao(
            this.const.CHAO.POSICAO_X,  
            canvas.dimensao.altura - this.const.CHAO.POSICAO_Y, 
            canvas.dimensao.largura, 
            this.const.CHAO.ALTURA, 
            this.const.CHAO.SPRITE.SRC, 
            this.const.CHAO.SPRITE.LARGURA, 
            this.const.CHAO.SPRITE.ALTURA,
            this.const.CHAO.VELOCIDADE_MOVE
        );
        this.personagem = new Personagem(
            this.const.PERSONAGEM.POSICAO_X, 
            this.chao.sprite.posicao.y - this.const.PERSONAGEM.ALTURA, 
            this.const.PERSONAGEM.LARGURA, 
            this.const.PERSONAGEM.ALTURA,
            this.const.PERSONAGEM.ALTURA_ABAIXADO,
            this.const.PERSONAGEM.FORCA_PULO, 
            this.const.PERSONAGEM.NUM_MAX_PULO, 
            this.const.PERSONAGEM.SPRITE_SHEET.SRC, 
            this.const.PERSONAGEM.SPRITE_SHEET.LARGURA, 
            this.const.PERSONAGEM.SPRITE_SHEET.ALTURA, 
            this.const.PERSONAGEM.SPRITE_SHEET.COLUNAS, 
            this.const.PERSONAGEM.SPRITE_SHEET.LINHAS, 
            this.const.PERSONAGEM.ANIMACOES
        );

        this.fisica = new Fisica(
            this.const.FISICA.GRAVIDADE
        );
        this.teclado = new Teclado();
        this.velocidadeMoveObs = this.const.OBSTACULO.VELOCIDADE_MOVE_INICIAL;
        this.listObstaculos = [] 
        this.jogando = true;
        this.escore = 0; 
    }
    
    clickTecla(){
        if((event.keyCode == this.teclado.keys.BARRA_DE_ESPACO || event.keyCode == this.teclado.keys.SETA_PARA_CIMA)  && this.jogando){ 
            this.personagem.estado = 'pulando';
            this.personagem.pular();
        }
        if(event.keyCode == this.teclado.keys.SETA_PARA_BAIXO && this.personagem.abaixado == false){
            this.personagem.abaixar()
        }
        if((event.keyCode == this.teclado.keys.BARRA_DE_ESPACO || event.keyCode == this.teclado.keys.SETA_PARA_CIMA) && !this.jogando){
            this.reiniciar();
        }
    }

    soltaTecla(){
        if(event.keyCode == 40 && this.personagem.abaixado == true){
            this.personagem.voltarAlturaNormal();
        }  
    }
    
    gerarObs(){
        let randomIndex = Math.floor(Math.random() * this.const.OBSTACULO.TIPO_STR.length);
        let obs = this.const.OBSTACULO.TIPO[(this.const.OBSTACULO.TIPO_STR[randomIndex])] 
        let obsRandom = new Obstaculo(
                obs.SPRITE.POSICAO_X,
                obs.SPRITE.POSICAO_Y + this.chao.getPosicaoParaChaoAltura(obs.SPRITE.ALTURA),
                obs.SPRITE.LARGURA,
                obs.SPRITE.ALTURA,
                this.velocidadeMoveObs, 
                obs.SPRITE_SHEET.SRC,
                obs.SPRITE_SHEET.LARGURA, 
                obs.SPRITE_SHEET.ALTURA,
                obs.SPRITE_SHEET.COLUNAS, 
                obs.SPRITE_SHEET.LINHAS,
                obs.ANIMACOES
            )
        return obsRandom;
    }

    criarObstaculo(){
        if(this.const.OBSTACULO.INTERVALO_INSERCAO <= 0){
            let obs = this.gerarObs();
            this.listObstaculos.push(obs); 
            this.const.OBSTACULO.INTERVALO_INSERCAO = obs.randomTempoInsercao(this.const.OBSTACULO.TEMPO_INSERCAO);
        } else{
            this.const.OBSTACULO.INTERVALO_INSERCAO -= 1;
        }    
    }

    loop(){
        if(this.jogando){
            canvas.limpar()
            this.cenario.sprite.insertSprite();
            this.chao.runAnimacaoMove();
            this.personagem.executarAnimations();
            this.criarObstaculo();
            canvas.insertTexto(this.escore);

            if(this.chao.isChao(this.personagem) && this.personagem.estado != 'abaixando' && this.personagem.estado != 'parado'){
                this.personagem.estado = 'andando';
            }else if(!this.chao.isChao(this.personagem)){
                this.personagem.estado = 'pulando';
            }

            for( let x = 0; x < this.listObstaculos.length; x++){
                this.listObstaculos[x].mover();
                this.listObstaculos[x].executarAnimations() 
                if(this.listObstaculos[x].colidio(this.personagem, this.chao)){
                    this.jogando = false;
                }
                            
                if(!this.listObstaculos[x].isCenario()){ 
                    this.listObstaculos.splice(x, 1);
                    x--;
                }
        }
        this.fisica.submeteGravidade(this.personagem, this.chao);
    }
       
        window.requestAnimationFrame(ok => {
            this.loop();
        });
    }

    reiniciar(){
        this.escore = 0; 
        this.listObstaculos = [];
        this.jogando = true;
        this.velocidadeMoveObs = this.const.OBSTACULO.VELOCIDADE_MOVE_INICIAL;
        this.chao.velocidadeMove = 0.5
        this.velocidadeEscore = 1;
    }

    init(){
        if(this.jogando){
            setInterval(ok => { this.escore++ },800);
        }
        this.loop();
    }
}