class Canvas {
    constructor(element){
        this.element = element;
        this.contexto = element.getContext('2d');
        this.dimensao = new Dimensao(element.width,element.height)
    }

    insertRetangulo(obj){
        this.contexto.fillStyle = "#000";
        this.contexto.fillRect(obj.sprite.posicao.x, obj.sprite.posicao.y, obj.sprite.dimensao.largura, obj.sprite.dimensao.altura);
    }

    insertTexto(text){
        this.contexto.fillStyle = '#fff';
        this.contexto.font = '30px Arial';
        this.contexto.fillText(text, 900, 68);
    }

    limpar(){
        this.contexto.clearRect(0, 0, this.dimensao.largura, this.dimensao.altura);
    }

    insertSpriteAnimado(sprite){
       this.contexto.drawImage(sprite.spriteSheet.element, sprite.src.x, sprite.src.y, sprite.spriteSheet.SpritePadrao.largura, sprite.spriteSheet.SpritePadrao.altura, sprite.posicao.x, sprite.posicao.y, sprite.dimensao.largura, sprite.dimensao.altura);
    }

    insertSpriteEstatico(sprite){
        this.contexto.drawImage(sprite.spriteSheet.element, sprite.posicao.x, sprite.posicao.y, sprite.spriteSheet.dimensao.largura, sprite.spriteSheet.dimensao.altura)
    }
}