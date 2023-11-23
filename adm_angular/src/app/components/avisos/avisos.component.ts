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
  selectedGrupo: any;

  constructor(private fb: FormBuilder, private firestore: AngularFirestore, private artigoService: ArtigoService) {
    this.avisoSelecionado = artigoService.initAviso();
  }

  onChange(e: any) {
    console.log(e);
    console.log(this.selectedGrupo)
  }

  onRowSelect(e: any) {
    this.selectedGrupo = this.grupos.find((item) => {
      return item.id == this.avisoSelecionado.grupo;
    });
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
      this.selectedGrupo = this.grupos.find((item) => {
        console.log('aviso selecionado no inicio', this.avisoSelecionado)
        return item.id == this.avisoSelecionado.id;
      });
      console.log(this.selectedGrupo)
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
    console.log('AVISO SELECIONADO', this.avisoSelecionado)
    this.show();
  }

  tratar(event: any) {
    console.log('event', event)
  }

  show() {
    this.mostrarDialog = !this.mostrarDialog;

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
            console.log(a.payload.doc.data())
            const data: AvisoInterface = a.payload.doc.data();
            const id = a.payload.doc.id;
            // console.log(data)
            if (a.payload.doc.data().dtInclusao != null) {
              data.dtInclusao = a.payload.doc.data().dtInclusao.toDate;
            }
            if (a.payload.doc.data().dtLimiteExibicao != null) {
              data.dtLimiteExibicao = a.payload.doc.data().dtLimiteExibicao.toDate()
            }
            return { ...data };
          });
        })
      );
  }

  getGrupos() {
    this.firestore.collection('grupos').valueChanges().subscribe((grupos: any[]) => {
      this.grupos = grupos;
      // this.avisoGruposSubject.next(grupos);
    });
  }


  // Método para atualizar um artigo existente
  async salvar(): Promise<string> {
    if (this.artigoService.avisoIsValid(this.avisoSelecionado)) {
      let id = uuidv4();
      let imageid = '';
      this.avisoSelecionado.id = this.avisoSelecionado.id == '' ? id : this.avisoSelecionado.id;
      this.avisoSelecionado.grupo = 'avisos';
      this.avisoSelecionado.dtInclusao = new Date();
      await this.firestore.collection('artigos').doc(this.avisoSelecionado.id).set(this.avisoSelecionado).then(async () => {
        const file: File = this.imagemSelecionada.target.files[0];
        if (this.imagemSelecionada != null) {
          const m = await this.artigoService.uploadImagem('avisos', file, this.avisoSelecionado).then((imgUrl) => {
            console.log('RETORNEI COM A URL', imgUrl)
          })
          this.imagemSelecionada = null;
        }
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
