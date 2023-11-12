import { Component, OnInit, ViewChild } from '@angular/core';
import { Injectable } from '@angular/core';
import { AngularFirestore, DocumentChangeAction } from '@angular/fire/compat/firestore';
import { Table } from 'primeng/table';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { AvisoInterface } from 'src/app/interfaces/artigos.interface';
import { ArtigoService } from 'src/app/services/artigos.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-avisos',
  templateUrl: './avisos.component.html',
  styleUrls: ['./avisos.component.scss']
})
export class AvisosComponent implements OnInit {
  @ViewChild('dt') dataTable: Table | undefined;
  avisoForm!: FormGroup;
  filtroGlobal: string = '';
  avisos: any[] = [];
  grupos: any[] = [];
  avisoSelecionado: AvisoInterface;
  mostrarDialog = false;

  constructor(private fb: FormBuilder, private firestore: AngularFirestore, private artigoService: ArtigoService) {
    this.avisoSelecionado = artigoService.initAviso();
  }

  ngOnInit() {
    this.inicializarForm();
    this.getAvisos().subscribe((data: any[]) => {
      this.avisos = data;
    });
  }

  inicializarForm() {
    this.avisoForm = this.fb.group({
      titulo: ['', Validators.required],
      subtitulo: ['', Validators.required],
      conteudo: ['', Validators.required],
      dtLimiteExibicao: [''],
      grupo: ['']
    });
  }

  applyGlobalFilter(event: Event) {
    console.log('entrou', this.dataTable);

    if (this.dataTable) {
      this.dataTable.filterGlobal(this.filtroGlobal, 'contains');
    }
  }

  novoAviso() {
    this.avisoSelecionado = this.artigoService.initAviso();
    this.show();
  }

  show() {
    this.mostrarDialog = !this.mostrarDialog;
    console.log(this.mostrarDialog, this.avisoSelecionado);
  }

  fecharDialog() {
    this.mostrarDialog = false;
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
            console.log(data.dtInclusao, id, new Date('2099/01901'));
            return { id, ...data };
          });
        })
      );
  }

  // Método para adicionar um novo artigo
  adicionarAviso(artigo: any) {
    let res;
    if (this.avisoForm.valid) {
      res = this.firestore.collection('artigos').add(artigo);
    }
  }

  // Método para atualizar um artigo existente
  salvar(): Promise<void> {
    return this.firestore.collection('artigos').doc(this.avisoSelecionado.id).update(this.avisoSelecionado);
  }

  // Método para excluir um artigo
  excluirAviso(id: string): Promise<void> {
    return this.firestore.collection('artigos').doc(id).delete();
  }

}
