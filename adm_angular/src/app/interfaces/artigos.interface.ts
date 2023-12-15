export interface AvisoInterface {
    id: string;
    titulo: string;
    imagem: string;
    dtLimiteExibicao: Date;
    data: Date;
    subtitulo: string;
    likes: number;
    autor: string;
    visualizacoes: number;
    conteudo: string;
    video: string;
    dtInclusao: Date;
    grupo: string;
    ativo: boolean;
}
