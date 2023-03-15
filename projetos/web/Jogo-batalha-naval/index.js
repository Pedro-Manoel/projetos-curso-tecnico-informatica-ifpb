"use strict"; 

class View{
    constructor(){
        this.viewNumTentativas = document.getElementById('disparos'); 
        this.viewNumAcertos = document.getElementById('acertos');
        this.inputDisparo = document.getElementById('coordenadas');
        this.notificacao= document.getElementById('notificacao');
        this.buttonEscolha = document.getElementById('btn-escolha');
        this.tabuleiro = document.querySelectorAll("td[class='escolha']");
    }

    monstrarNumJogo(numAcertos, numTentativas, numMaxTentativas){
        this.viewNumAcertos.innerHTML = numAcertos; 
        this.viewNumTentativas.innerHTML = ( numMaxTentativas - numTentativas);
    }

    mostrarEscolhaErrada(coordenadas){
        document.getElementById(coordenadas).className = 'escolha-errada';
    }

    mostrarEscolhaCerta(coordenadas){
        document.getElementById(coordenadas).className = 'escolha-certa';
    }

    monstrarMensagemErro(mensagem){
        this.notificacao.innerHTML = mensagem; 
        this.notificacao.className = 'notificacao-erro';
    }

    monstrarMensagemSucesso(mensagem){
        this.notificacao.innerHTML = mensagem; 
        this.notificacao.className = 'notificacao-sucesso';
    }

    ocultaNotificacao(){
        this.notificacao.className = 'notificacao';
    }

    mudarButtonEscolhaReiniciar(){
        this.buttonEscolha.className = 'jogar-novamente'
        this.buttonEscolha.innerHTML = 'Jogar Novamente'
    }

    mudarButtonEscolhaDisparar(){
        this.buttonEscolha.className = 'dispara'
        this.buttonEscolha.innerHTML = 'Disparar'
    }

    animatON(posicao){
        var letra = posicao[0];
        var numero = posicao[1]; 
        document.getElementById('label-' + letra).style.color = 'red';
        document.getElementById('label-' + numero).style.color = 'red';
    }
    
    animatOFF(posicao){
        var letra = posicao[0];
        var numero = posicao[1]; 
        document.getElementById('label-' + letra).style.color = 'white';
        document.getElementById('label-' + numero).style.color = 'white';
    }

    reiniciarTabuleiro(){
        for(var x=0; x <= this.tabuleiro.length-1; x++){
            this.tabuleiro[x].className = 'escolha'; 
        }
    }

    esvaziaImput(){
        this.inputDisparo.value = '';
    }

}

class BatalhaNaval{
    constructor(numMaxTentativas, numSubmarino, numEmbarcacoes_2partes, numEmbarcacoes_3partes){
        this.numMaxTentativas = numMaxTentativas; 
        this.tentativas = 0;
        this.numSubmarino = numSubmarino;
        this.numEmbarcacoes_2partes = numEmbarcacoes_2partes;
        this.numEmbarcacoes_3partes = numEmbarcacoes_3partes;
        this.numAcertos = 0; 
        this.finalizado = false; 
        this.view = new View();
        this.embarcacoes = [];
        this.coordLetras = new Array('A','B','C','D','E','F','G');
        this.coordNumero = new Array(1,2,3,4,5,6,7);
        this.disparosRealizados = []; 
    }

    verificaPosicaoOcupada(posicao){
        for(var x=0; x <= this.embarcacoes.length - 1; x++){
            if(this.embarcacoes[x].indexOf(posicao) != -1){
                return true; 
            }
        }
        return false;
    }

    verificaPosicaoPossivel(posicao){
        var letra = posicao[0];
        var numero = parseInt(posicao[1]);
        if(this.coordLetras.indexOf(letra) != -1 && this.coordNumero.indexOf(numero) != -1){
            return true;
        }else{
            return false;
        }
    }
    
    verificaEmbarcacaoDestruida(){
        for(var x=0; x <= this.embarcacoes.length - 1; x++){
            if(this.embarcacoes[x].length == 0 ){
                return true; 
            }
        }
        return false;
    }

    destruirParteEmbarcacao(posicao){
        for(var x=0; x <= this.embarcacoes.length - 1; x++){
            if(this.embarcacoes[x].indexOf(posicao) != -1){
                var index = this.embarcacoes[x].indexOf(posicao)
                this.embarcacoes[x].splice(index,1);
                break;
            }
        }
    }

    randomPosicao(){
        var l = this.coordLetras[Math.floor(Math.random() * this.coordLetras.length)] 
        var n = this.coordNumero[Math.floor(Math.random() * this.coordNumero.length)]
        var posicao = l + n.toString(); 
        return {letra:l,numero:n,str:posicao} 
    }

    gerarEmbarcacoes(){
        var posicao = {}; 
        var numSubmarino = this.numSubmarino;
        var numEmbarcacoes_2partes = this.numEmbarcacoes_2partes;
        var numEmbarcacoes_3partes = this.numEmbarcacoes_3partes;

        while(numSubmarino > 0){ 
            posicao = this.randomPosicao();
            if(this.verificaPosicaoOcupada(posicao.str) == false){
               if(this.gerarPosicoesAdjacentes(posicao,0)){
                    numSubmarino -= 1;                
               }
            }
        }

        while(numEmbarcacoes_2partes > 0){ 
            posicao = this.randomPosicao();
            if(this.verificaPosicaoOcupada(posicao.str) == false){
                if(this.gerarPosicoesAdjacentes(posicao,1)){
                    numEmbarcacoes_2partes -= 1;                 
                }
            }
        }

        while(numEmbarcacoes_3partes > 0){ 
            posicao = this.randomPosicao();
            if(this.verificaPosicaoOcupada(posicao.str) == false){
                if(this.gerarPosicoesAdjacentes(posicao,2)){
                    numEmbarcacoes_3partes -= 1;
                }
            }
        }
    }

    gerarPosicoesAdjacentes(posicaoInicial, numPartes){
        var embarcacao = []
        var direcao = {frente:1,tras:1};
        var somaNum = {frente:false,tras:false}
        var posicao = '';        
        
        embarcacao.push(posicaoInicial.str); 

        while(numPartes > 0){
            if(direcao.frente > 0 && numPartes > 0){
                posicao = posicaoInicial.letra + ( posicaoInicial.numero + direcao.frente).toString() 
                if(this.verificaPosicaoPossivel(posicao)){
                    if(this.verificaPosicaoOcupada(posicao)){
                        return false;
                    }else{
                        embarcacao.push(posicao);
                        numPartes -= 1;  
                    }
                }else{
                    direcao.frente = 0;
                    somaNum.tras = true;
                }
            }
            
            if(direcao.tras > 0 && numPartes > 0){
                posicao = posicaoInicial.letra + ( posicaoInicial.numero - direcao.tras).toString() 
                if(this.verificaPosicaoPossivel(posicao)){
                    if(this.verificaPosicaoOcupada(posicao)){
                        return false;
                    }else{
                        embarcacao.push(posicao);
                        numPartes -= 1;
                    }
                }else{
                    direcao.tras = 0;
                    somaNum.frente = true;
                }
            }

            if(somaNum.frente){
                direcao.frente += 1;
                somaNum.frente = false;
            }else if(somaNum.tras){
                direcao.tras += 1;
                somaNum.tras = false;
            }
        }

        this.embarcacoes.push(embarcacao); 
        return true;
    }

    verificaDisparoRealizado(posicao){
        if(this.disparosRealizados.indexOf(posicao) != -1){
            return true;
        }else{
            return false;
        }
    }

    disparar(posicao){
        if(this.finalizado == false){
            this.view.ocultaNotificacao()
            this.tentativas+= 1;
            this.disparosRealizados.push(posicao);
            
            if(this.verificaPosicaoOcupada(posicao)){
                this.numAcertos+=1;
                this.view.mostrarEscolhaCerta(posicao);
                this.destruirParteEmbarcacao(posicao);
                if(this.verificaEmbarcacaoDestruida(posicao)){
                    var mensagemSucesso = 'Parabéns você acaba de destruir, uma embarcação inimiga ';
                    this.view.monstrarMensagemSucesso(mensagemSucesso);
                    this.finalizar();
                }
            }else{
                this.view.mostrarEscolhaErrada(posicao);
            }
            this.view.monstrarNumJogo(this.numAcertos,this.tentativas,this.numMaxTentativas);
            if(this.numMaxTentativas == this.tentativas && this.finalizado == false){
                var mensagemErro = 'Que pena, você fracassou em tentar destruir as embarcações inimigas'
                this.view.monstrarMensagemErro(mensagemErro);
                this.finalizar();
            }
        }
    }

    btnJogo(){
        if(this.finalizado == false){
            var posicao = this.view.inputDisparo.value.toUpperCase();
            if(this.verificaPosicaoPossivel(posicao)){
                if(this.verificaDisparoRealizado(posicao) == false){
                    this.disparar(posicao);
                }  
            }else{
                this.view.monstrarMensagemErro('Coordenadas Inválidas');            
            }
        }else{
            this.reiniciar();
        }
    }
        
    iniciar(){
        if(this.finalizado == false){ 
            this.view.monstrarNumJogo(this.numAcertos,this.tentativas,this.numMaxTentativas);
            this.gerarEmbarcacoes();
            
        }
    }

    reiniciar(){
        if(this.finalizado){
            this.tentativas = 0;
            this.numAcertos = 0;
            this.embarcacoes = [];
            this.disparosRealizados = [];
            this.view.reiniciarTabuleiro();
            this.finalizado = false;
            this.view.mudarButtonEscolhaDisparar();
            this.view.ocultaNotificacao();
            this.view.esvaziaImput();
            this.iniciar();
        }
    }

    finalizar(){
       this.finalizado = true;
       this.view.mudarButtonEscolhaReiniciar();
    }
}

var batalhaNaval = new BatalhaNaval(8,3,2,2);
batalhaNaval.iniciar();


