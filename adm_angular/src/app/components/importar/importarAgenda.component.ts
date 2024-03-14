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
    const meses = ['janeiro', 'fevereiro', 'marco', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro']
    let anoBase = -1;
    let mes = -1;
    let lastField1 = '';
    for (let index = 0; index < agenda.length; index++) {
      const element = agenda[index];
      const mesEncontrado = meses.indexOf(element.field1.split(' ')[0].toLowerCase());
      mesEncontrado != -1 ? mes = mesEncontrado : mes = mes;
      mesEncontrado != -1 ? anoBase = parseInt(element.field1.split(' ')[1]) : anoBase = anoBase;

      if (mes != -1) {
        if (this.artigoService.isNumber(element.field1)) {
          element.field1 = element.field1 == '' ? lastField1 : element.field1;
          const aviso: AvisoInterface = this.artigoService.initAviso();
          aviso.autor = 'Importação';
          aviso.titulo = element.field3;
          aviso.subtitulo = 'Resposável: ' + element.field4;
          aviso.grupo = 'agenda';
          aviso.data = new Date(anoBase, mes, Number(element.field1))
          aviso.dtInclusao = new Date();
          aviso.conteudo = 'Pastoral ou Movimento: ' + element.field4 + '\n Local: ' + element.field6 + '\n Horário: ' + element.field5
          aviso.id = uuidv4();
          await this.firestore.collection('artigos').doc(aviso.id).set(aviso).then(async () => {
          });


          list.push(aviso);
          lastField1 = element.field1 == '' ? lastField1 : element.field1;
        } else {
          console.log(element.field1)
        }
        // if ((element.field1.trim().length > 0) && (meseswerCase().indexOf(element.field1.toLowerCase()) != -1)) {
        //   mes++
        //   console.log('mudou o mes', mes, element.field1)
        // }
      }
    }
    console.log(list)
  }
  // trocar field1 para

}
