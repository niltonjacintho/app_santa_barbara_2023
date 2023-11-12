import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { AngularFirestore } from '@angular/fire/compat/firestore';
import { AvisoInterface } from './../interfaces/artigos.interface'


@Injectable({
    providedIn: 'root'
})
export class ArtigoService {

    avisoInterface: AvisoInterface;

    private avisoGruposSubject: BehaviorSubject<any> = new BehaviorSubject<any>(null);
    public avisoGrupos$: Observable<any> = this.avisoGruposSubject.asObservable();

    grupos: any[] = []; // Armazenará os grupos

    constructor(private firestore: AngularFirestore) {
        this.carregarGrupos(); // Carrega os grupos ao inicializar o serviço
        this.avisoInterface = this.initAviso();
    }

    initAviso(): AvisoInterface {
        let res: AvisoInterface = {
            id: '',
            titulo: '',
            imagem: '',
            dtLimiteExibicao: new Date(),
            subtitulo: '',
            likes: 0,
            autor: '',
            visualizacoes: 0,
            conteudo: '',
            video: '',
            dtInclusao: new Date(),
            grupo: '',
            ativo: true
        };
        return res;
    }

    avisoIsValid(aviso:AvisoInterface): boolean{
        return (aviso.titulo != '') && (aviso.subtitulo != '') && (aviso.conteudo != '');
    }

    updateAviso(aviso: any) {

    }

    carregarGrupos() {
        this.firestore.collection('grupos').valueChanges().subscribe((grupos: any[]) => {
            this.grupos = grupos;
            this.avisoGruposSubject.next(grupos);
        });
    }
}



