class SpriteSheet {
    constructor(src, largura, altura, numColunas, numLinhas){
        this.dimensao = new Dimensao(largura, altura);
        this.numColunas = numColunas;
        this.numLinhas = numLinhas;
        this.SpritePadrao = new Dimensao( largura/numColunas, altura/numLinhas);
        this.element = new Image;
        if(src != undefined){
            this.element.src = src;
        }
    }
    
}