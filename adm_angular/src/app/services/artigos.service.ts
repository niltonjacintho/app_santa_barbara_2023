import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { AngularFirestore } from '@angular/fire/compat/firestore';

@Injectable({
    providedIn: 'root'
})
export class ArtigoService {
    private avisoGruposSubject: BehaviorSubject<any> = new BehaviorSubject<any>(null);
    public avisoGrupos$: Observable<any> = this.avisoGruposSubject.asObservable();

    grupos: any[] = []; // Armazenará os grupos

    constructor(private firestore: AngularFirestore) {
        this.carregarGrupos(); // Carrega os grupos ao inicializar o serviço
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



