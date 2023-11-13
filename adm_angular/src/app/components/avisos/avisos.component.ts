import { Component, OnInit, ViewChild } from '@angular/core';
import { Injectable } from '@angular/core';
import { AngularFirestore, DocumentChangeAction } from '@angular/fire/compat/firestore';
import { Table } from 'primeng/table';
import { Observable, of } from 'rxjs';
import { map } from 'rxjs/operators';
import { AvisoInterface } from 'src/app/interfaces/artigos.interface';
import { ArtigoService } from 'src/app/services/artigos.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { v4 as uuidv4 } from 'uuid';

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
  grupoSelecionado: string | undefined;
  mostrarDialog = false;
  imagemSelecionada: any;

  constructor(private fb: FormBuilder, private firestore: AngularFirestore, private artigoService: ArtigoService) {
    this.avisoSelecionado = artigoService.initAviso();
  }

  ngOnInit() {
    this.inicializarForm();
    this.getAvisos().subscribe((data: any[]) => {
      this.avisos = data;
    });
    this.artigoService.avisoGrupos$.subscribe((data) => {
      // Use the received data here
      console.log('GRUPOS ', data);
      this.grupos = data;
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

  onFileSelected(event: any) {
    this.imagemSelecionada = event;
  }

  novoAviso() {
    this.avisoSelecionado = this.artigoService.initAviso();
    this.show();
  }

  atualizarAviso() {
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

  // // Método para adicionar um novo artigo
  // async adicionarAviso(artigo: any) {
  //   let res;
  //   let imageid = '';
  //   if (this.avisoForm.valid) {
  //     res = await this.firestore.collection('artigos').add(artigo).then(() => {
  //       const file: File = this.imagemSelecionada.target.files[0];
  //       console.log('pegando o arqivo', file.name);
  //       this.artigoService.uploadImagem(file).then((res) => {
  //         imageid = res;
  //       })
  //     });

  //     this.avisoSelecionado.imagem = imageid;
  //     this.salvar();
  //   }
  // }

  // Método para atualizar um artigo existente
  salvar(): Promise<string> {
    if (this.artigoService.avisoIsValid(this.avisoSelecionado)) {
      let id = uuidv4();
      let imageid = '';
      this.avisoSelecionado.id = this.avisoSelecionado.id == '' ? id : this.avisoSelecionado.id;
      this.avisoSelecionado.grupo = 'avisos';
      this.avisoSelecionado.dtInclusao = new Date();
      this.firestore.collection('artigos').doc(this.avisoSelecionado.id).set(this.avisoSelecionado).then(() => {
        const file: File = this.imagemSelecionada.target.files[0];
        console.log('pegando o arqivo', file.name);
        const m = this.artigoService.uploadImagem('avisos', file);
        console.log('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMM', m)
      });
      this.avisoSelecionado.imagem = imageid;
      this.firestore.collection('artigos').doc(this.avisoSelecionado.id).set(this.avisoSelecionado);
      return Promise.resolve('dados salvos')
    }
    return Promise.reject("Campos obrigatórios não preenchidos");
  }

  // Método para excluir um artigo
  excluirAviso(id: string): Promise<void> {
    return this.firestore.collection('artigos').doc(id).delete();
  }

}
