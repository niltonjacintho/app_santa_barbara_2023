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
            data: new Date(),
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
        return (aviso.titulo != '') && (aviso.subtitulo != '') && (aviso.grupo != '');
    }

    async uploadImagem(tipo: string, event: any, aviso: AvisoInterface): Promise<string> {
        let imgUrl = '';
        this.file = event as File;
        const storageRef = ref(this.storage, tipo + '/' + this.file.name);
        const uploadTask = uploadBytesResumable(storageRef, this.file);
        uploadTask.on('state_changed', function (snapshot) {
            const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
        }, (error) => {
            console.log('ERROOOO ', error);
            // Handle unsuccessful uploads
        }, () => {
            // Handle successful uploads on complete
            // For instance, get the download URL: https://firebasestorage.googleapis.com/...
            getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
                console.log('File available at', downloadURL);
                aviso.imagem = downloadURL;
                this.firestore.collection('artigos').doc(aviso.id).set(aviso);
            });
        });
        console.log('RETORNANDO   ', imgUrl)
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

    isNumber(value: any): value is number {
        const n: Number = Number(value);
        return !Number.isNaN(n)
    }

}



