class AnimacaoSprite {
    constructor(num, tempo, numColunas, larguraAjuste, alturaAjuste, xSrc, ySrc, xCenario, yCenario){
        this.num = num;
        this.tempo = tempo;
        this.numColunas = numColunas;
        this.ajustes = {
            dimensao : new Dimensao(larguraAjuste,alturaAjuste),
            posicaoSrc : new Posicao(xSrc,ySrc),
            posicaoCenario : new Posicao(xCenario, yCenario)
        };
    }
}