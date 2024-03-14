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
import { MessageService } from 'primeng/api';
import moment from 'moment';
import { getDocs } from 'firebase/firestore';

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

  constructor(private fb: FormBuilder, private firestore: AngularFirestore, private artigoService: ArtigoService, private messageService: MessageService) {
    this.avisoSelecionado = artigoService.initAviso();
  }

  onChange(e: any) {
    console.log(e);
    console.log('grupo apos alterar', this.selectedGrupo)
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
    return this.firestore.collection('artigos', ref => ref.where('grupo', '!=', ''))
      .snapshotChanges()
      .pipe(
        map((actions: DocumentChangeAction<any>[]) => {
          return actions.map(a => {
            console.log(a.payload.doc.data())
            const data: AvisoInterface = a.payload.doc.data();
            const id = a.payload.doc.id;
            console.log(a.payload.doc.data().dtInclusao)
            data.dtLimiteExibicao = a.payload.doc.data().dtLimiteExibicao != null ? a.payload.doc.data().dtLimiteExibicao.toDate() : new Date('1980-01-01');
            data.data = a.payload.doc.data().data != null ? a.payload.doc.data().data.toDate() : new Date('1980-01-01');
            data.dtInclusao = a.payload.doc.data().dtInclusao != null ? a.payload.doc.data().dtInclusao.toDate() : new Date('1980-01-01');
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
    this.avisoSelecionado.grupo = this.selectedGrupo.id;
    if (this.artigoService.avisoIsValid(this.avisoSelecionado)) {
      let id = uuidv4();
      let imageid = '';
      this.avisoSelecionado.id = this.avisoSelecionado.id == '' ? id : this.avisoSelecionado.id;
      this.avisoSelecionado.dtInclusao = new Date();
      await this.firestore.collection('artigos').doc(this.avisoSelecionado.id).set(this.avisoSelecionado).then(async () => {
        console.log('IMAGEM SELECIONADA ', this.imagemSelecionada)
        if (this.imagemSelecionada != null) {
          const file: File = this.imagemSelecionada.target.files[0];
          if (this.imagemSelecionada != null) {
            const m = await this.artigoService.uploadImagem(this.avisoSelecionado.grupo, file, this.avisoSelecionado).then((imgUrl) => {
              console.log('RETORNEI COM A URL', imgUrl)
            })
            this.imagemSelecionada = null;
          }

        }
      });
      this.avisoSelecionado.imagem = imageid;
      this.firestore.collection('artigos').doc(this.avisoSelecionado.id).set(this.avisoSelecionado);
      this.fecharDialog();
      return Promise.resolve('dados salvos')
    } else {
      this.messageService.add({ severity: 'error', summary: 'Não posso Salvar', detail: 'Algum campo obrigatório não foi preenchido' });
      this.fecharDialog();
    }
    return Promise.reject("Campos obrigatórios não preenchidos");
  }

  // Método para excluir um artigo
  excluirAviso(id: string): Promise<void> {
    return this.firestore.collection('artigos').doc(id).delete();
  }

  convertTimestampToDate(timestamp: number): string {
    const momentDate = moment(timestamp);
    return momentDate.format('YYYY-MM-DD');
  }

  migrateData() {
    console.log('migrating');
    this.firestore.collection('agenda').valueChanges().subscribe((agendas: any[]) => {
      agendas.forEach(async a => {
        var aviso: AvisoInterface = this.artigoService.initAviso();
        console.log(a.atividade)
        //const data: AvisoInterface = a.payload.doc.data;
        aviso.id = a.id;
        aviso.data = new Date(a.data);
        aviso.titulo = a.atividade;
        aviso.grupo = 'agenda';
        aviso.subtitulo = a.local;
        aviso.conteudo = a.detalhes;
        console.log(aviso);
        await this.firestore.collection('artigos').doc(aviso.id).set(aviso);
      });

    });
    // return this.firestore.collection('agenda')
    //   .snapshotChanges()
    //   .pipe(
    //     map((actions: DocumentChangeAction<any>[]) => {
    //       console.log('pegando')
    //       return actions.map(async a => {
    //         var aviso: AvisoInterface = this.artigoService.initAviso();
    //         console.log(a.payload.doc.data())
    //         //const data: AvisoInterface = a.payload.doc.data;
    //         aviso.id = a.payload.doc.id;
    //         aviso.data = a.payload.doc.data().data;
    //         aviso.titulo = a.payload.doc.data().atividade;
    //         aviso.grupo = 'agenda';
    //         aviso.subtitulo = a.payload.doc.data().local;
    //         aviso.conteudo = a.payload.doc.data().detalhes;
    //         await this.firestore.collection('artigos').doc(aviso.id).set(aviso);
    //       });
    //     })
    //   );
  }

}
