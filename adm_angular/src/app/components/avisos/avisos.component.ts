import { Component, OnInit, ViewChild } from '@angular/core';
import { Injectable } from '@angular/core';
import { AngularFirestore, DocumentChangeAction } from '@angular/fire/compat/firestore';
import { Table } from 'primeng/table';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Component({
  selector: 'app-avisos',
  templateUrl: './avisos.component.html',
  styleUrls: ['./avisos.component.scss']
})
export class AvisosComponent implements OnInit {
  @ViewChild('dt') dataTable: Table | undefined;
  filtroGlobal: string = '';
  avisos: any[] = [];
  avisoSelecionado: any = {};

  constructor(private firestore: AngularFirestore) { }

  ngOnInit() {
    this.getAvisos().subscribe((data: any[]) => {
      this.avisos = data;
    });
  }

  applyGlobalFilter(event: Event) {
    console.log('entrou', this.dataTable);

    if (this.dataTable) {
      this.dataTable.filterGlobal(this.filtroGlobal, 'contains');
    }
  }

  getAvisos(): Observable<any[]> {
    return this.firestore.collection('artigos', ref => ref.where('grupo', '==', 'avisos'))
      .snapshotChanges()
      .pipe(
        map((actions: DocumentChangeAction<any>[]) => {
          return actions.map(a => {
            const data = a.payload.doc.data();
            const id = a.payload.doc.id;
            if (data.dtInclusao != null) {
              data.dtInclusao = new Date(data.dtInclusao);
            }
            // try {
            //   
            // } catch (error) {
            //   data.dtInclusao = new Date('2099/01/1');
            // }

            console.log(data.dtInclusao, id, new Date('2099/01901'));
            return { id, ...data };
          });
        })
      );
  }

  // Método para adicionar um novo artigo
  adicionarAviso(artigo: any): Promise<any> {
    return this.firestore.collection('artigos').add(artigo);
  }

  // Método para atualizar um artigo existente
  atualizarAviso(id: string, data: any): Promise<void> {
    return this.firestore.collection('artigos').doc(id).update(data);
  }

  // Método para excluir um artigo
  excluirAviso(id: string): Promise<void> {
    return this.firestore.collection('artigos').doc(id).delete();
  }

}
