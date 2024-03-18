import { Component } from '@angular/core';
import { AvisoInterface } from '../../interfaces/artigos.interface';
import { ArtigoService } from 'src/app/services/artigos.service';
import { v4 as uuidv4 } from 'uuid';
import { AngularFirestore } from '@angular/fire/compat/firestore';
import agenda from './../../../assets/agenda.json';

@Component({
  selector: 'app-importar',
  templateUrl: './importarAgenda.component.html',
  styleUrls: ['./importarAgenda.component.scss'],

})
export class ImportarAgendaComponent {
  constructor(private artigoService: ArtigoService, private firestore: AngularFirestore) {

  }

  async importExcelAgenda() {
    let list: AvisoInterface[] = [];
    let d = new Date();
    const meses = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro']
    let anoBase = -1;
    let mes = -1;
    let lastField1 = null;
    for (let index = 0; index < agenda.length; index++) {
      const element = agenda[index];

      var f1: string = String(element["2024 (Versão 01 - 04/03/2024)"])
      const mesEncontrado = meses.indexOf(f1!.split(' ')[0].toLowerCase());
      mesEncontrado != -1 ? mes = mesEncontrado : mes = mes;
      mesEncontrado != -1 ? anoBase = parseInt(f1!.split(' ')[1]) : anoBase = anoBase;
      if (mes > 0) {
        console.log('pause aqui')
      }
      if (element.column_2 == 'CRAS') {
        console.log('F1 ', typeof f1, f1 == 'null', f1, 'lastfield', lastField1, 'Element', element);
      }
      if (mes != -1) {
        if (f1 == 'null') {
          if (lastField1 != null) {
            f1 = lastField1;
          }

        }
        if (element.column_2 == 'CRAS') {
          console.log('APÓS TRATAR ==> F1 ', f1, f1 == null, lastField1 != null, 'lastfield', lastField1, 'Element', element);
        }
        if (this.artigoService.isNumber(f1)) {

          const aviso: AvisoInterface = this.artigoService.initAviso();
          aviso.autor = 'Importação';
          aviso.titulo = element.column_2!;
          aviso.subtitulo = 'Resposável: ' + element.column_3;
          aviso.grupo = 'agenda';
          aviso.data = new Date(anoBase, mes, Number(f1))
          aviso.dtInclusao = new Date();
          aviso.conteudo = '\nPastoral ou Movimento: ' + element.column_3 + '\n Local: ' + element.column_5 + '\n Horário: ' + element.column_4 + '\n Observação: ' + element.column_7;
          aviso.id = uuidv4();
          await this.firestore.collection('artigos').doc(aviso.id).set(aviso).then(async () => {
          });


          list.push(aviso);
          lastField1 = f1 == null ? lastField1 : f1;
        } else {
          // console.log(element.field1)
        }
        // if ((element.field1.trim().length > 0) && (meseswerCase().indexOf(element.field1.toLowerCase()) != -1)) {
        //   mes++
        //   console.log('mudou o mes', mes, element.field1)
        // }
      }
    }
    console.log(list.length, list)
  }
  // trocar field1 para

}
