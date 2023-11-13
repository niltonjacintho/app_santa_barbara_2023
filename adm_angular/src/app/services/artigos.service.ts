import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { AngularFirestore } from '@angular/fire/compat/firestore';
import { AvisoInterface } from './../interfaces/artigos.interface'
import { Storage, ref, uploadBytesResumable, getDownloadURL } from '@angular/fire/storage';

@Injectable({
    providedIn: 'root'
})
export class ArtigoService {

    avisoInterface: AvisoInterface;
    public file: any = {};

    private avisoGruposSubject: BehaviorSubject<any> = new BehaviorSubject<any>(null);
    public avisoGrupos$: Observable<any> = this.avisoGruposSubject.asObservable();

    grupos: any[] = []; // Armazenará os grupos

    constructor(private firestore: AngularFirestore, public storage: Storage) {
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

    avisoIsValid(aviso: AvisoInterface): boolean {
        return (aviso.titulo != '') && (aviso.subtitulo != '') && (aviso.conteudo != '');
    }

    async uploadImagem(tipo: string, event: any): Promise<string> {
        let imgUrl = '';
        this.file = event as File;
        const storageRef = ref(this.storage, tipo + '/' + this.file.name);
        const uploadTask = uploadBytesResumable(storageRef, this.file);
        uploadTask.on('state_changed', (snapshot) => {
            const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
            if (progress == 100) {
                getDownloadURL(uploadTask.snapshot.ref).then((downloadUrl) => {
                    console.log('file available at ', downloadUrl)
                    imgUrl = downloadUrl;
                })
            }
        }, () => {
            console.log('upload done');
            getDownloadURL(uploadTask.snapshot.ref).then((downloadUrl) => {
                console.log('file available at ', downloadUrl)
            }
            )
        });
        return Promise.resolve(imgUrl);
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



