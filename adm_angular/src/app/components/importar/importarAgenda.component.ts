import { Component } from '@angular/core';
import { AvisoInterface } from '../../interfaces/artigos.interface';
import { ArtigoService } from 'src/app/services/artigos.service';
import { v4 as uuidv4 } from 'uuid';
import { AngularFirestore } from '@angular/fire/compat/firestore';

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
    const meses = 'JANEIRO,FEVEREIRO,marco,abril,maio,junho,julho,agosto,setembro,outubro,novembro,dezembro'
    let mes = 0;
    for (let index = 0; index < this.agenda.length; index++) {
      const element = this.agenda[index];
      if (this.artigoService.isNumber(element.field1)) {
        const aviso: AvisoInterface = this.artigoService.initAviso();
        aviso.autor = 'Importação';
        aviso.titulo = element.field3;
        aviso.subtitulo = 'Resposável: ' + element.field4;
        aviso.grupo = 'agenda';
        aviso.data = new Date(2024, mes, Number(element.field1))
        aviso.dtInclusao = new Date();
        aviso.conteudo = 'Pastoral ou Movimento: ' + element.field4 + '\n Local: ' + element.field6 + '\n Horário: ' + element.field5
        aviso.id = uuidv4();
        await this.firestore.collection('artigos').doc(aviso.id).set(aviso).then(async () => {
        });

        list.push(aviso);
      } else {
        console.log(element.field1)
      }
      if ((element.field1.trim().length > 0) && (meses.toLowerCase().indexOf(element.field1.toLowerCase()) != -1)) {
        mes++
        console.log('mudou o mes', mes, element.field1)
      }
    }
    console.log(list)
  }
  // trocar field1 para
  agenda = [
    { "field1": "DIA", "field2": "SEM", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Seg", "field3": "Solenidade da Santa M�e de Deus- Maria/", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "2", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "3", "field2": "Qua", "field3": "GI/CRAS", "field4": "GI/CRAS", "field5": "7h30-9h30, 14h-16h", "field6": "Qd/S.Fran" }
    ,
    { "field1": "", "field2": "Qui", "field3": "Adoração", "field4": "Gespai", "field5": "15h às 21h", "field6": "Templo" }
    ,
    { "field1": "5", "field2": "Sex", "field3": "Missa-reunião/reunião", "field4": "Apostolado/ Músicos", "field5": "7h30/19h30", "field6": "Templo-S.Dom" }
    ,
    { "field1": "6", "field2": "S�b", "field3": "Retiro e Reunião/Confraternização Pastoral", "field4": "SSCC/Coroinhas", "field5": "9h -12h/", "field6": "S.Dom- coz/S�tio" }
    ,
    { "field1": "7", "field2": "Dom", "field3": "Solenidade da Epifania do Senhor", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "8", "field2": "Seg", "field3": "Interc e Reunião/GI/CRAS/Festa do Batismo do Senhor", "field4": "Gespai/GI/CRAS", "field5": "7h e 19h/7h30-9h30/14h-16h/8h-9h", "field6": "Templo/Qd/S.Fra" }
    ,
    { "field1": "9", "field2": "Ter", "field3": "Terço dos Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "10", "field2": "Qua", "field3": "GI/CRAS", "field4": "GI/CRAS", "field5": "7h30-9h30, 14h-16h", "field6": "Qd" }
    ,
    { "field1": "11", "field2": "Qui", "field3": "Adoração", "field4": "Gespai", "field5": "15h às 21h", "field6": "Templo" }
    ,
    { "field1": "12", "field2": "Sex", "field3": "Ensaio  Músicos", "field4": " Músicos", "field5": "19h", "field6": "Templo" }
    ,
    { "field1": "13", "field2": "S�b", "field3": "ENSAIO DE CASAMENTO", "field4": "Pastoral Familiar", "field5": "14h", "field6": "Templo" }
    ,
    { "field1": "14", "field2": "Dom", "field3": "Liga/Reunião", "field4": "Liga/ADMA", "field5": "9h-11h/16h", "field6": "S.Fam/S.Franc" }
    ,
    { "field1": "15", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "16", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "17", "field2": "Qua", "field3": "CRAS/GI/Ensaio", "field4": "CRAS/GI/ Músicos", "field5": "9h-11h/8h-9h/19h", "field6": "S.Franc/Qd/Templo" }
    ,
    { "field1": "18", "field2": "Qui", "field3": "Adoração", "field4": "Gespai", "field5": "18h às 19h", "field6": "Templo" }
    ,
    { "field1": "19", "field2": "Sex", "field3": "Aula Violão/Reunião/Adoração", "field4": "Violão/Forania/jovens", "field5": "14h/10h-12h/19h", "field6": "S.Dom/??/Templo" }
    ,
    { "field1": "20", "field2": "Sab", "field3": "Solenidade de São Sebastião", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "21", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "22", "field2": "Seg", "field3": "Memória N. Sra Auxiliadora/", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "23", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "24", "field2": "Quar", "field3": "CRAS/GI/São Francisco de Salles", "field4": "CRAS/GI", "field5": "9h-11h/8h-9h", "field6": "S.Franc/Qd" }
    ,
    { "field1": "25", "field2": "Qui", "field3": "Adoração/Festa da ConverSão de São Paulo", "field4": "Gespai", "field5": "15h às 21h", "field6": "Templo" }
    ,
    { "field1": "26", "field2": "Sex", "field3": "Aula Violão", "field4": "Violão", "field5": "14h", "field6": "S.Dom" }
    ,
    { "field1": "27", "field2": "S�b", "field3": "CASAMENTO /Festival Sorvete", "field4": "Past. Familiar/SSCC e JMS", "field5": "19h /14h-17h", "field6": "Templo/Cantna.coz,Qd e S.Dom" }
    ,
    { "field1": "28", "field2": "Dom", "field3": "Tríduo de Dom Bosco", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Seg", "field3": "Tríduo de Dom Bosco/Interc. E Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "30", "field2": "Ter", "field3": "Tríduo de Dom Bosco/ Terço dos Hpmens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "31", "field2": "Qua", "field3": "Festa Dom Bosco", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "FEVEREIRO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Qui", "field3": "Adoração e grupo", "field4": "Gespai", "field5": "15h às 21h", "field6": "Templo" }
    ,
    { "field1": "2", "field2": "Sex", "field3": "Aula Violão/ Missa- reunião/reunião", "field4": "Violão/Apostolado/ Músicos", "field5": "14h/7h30/19h30", "field6": "S.Dom/Templo -S.Franc/S.Dom" }
    ,
    { "field1": "3", "field2": "Sab", "field3": "Reunião/Reunião/Reunião/Reunião", "field4": "SSCC/JMS/Coroinhas", "field5": "9h/15h/15h-17h30", "field6": "S.Dom/S.Dom/Col�gio" }
    ,
    { "field1": "4", "field2": "Dom", "field3": "Encontro/Formação", "field4": "JMS/Coroinhas", "field5": "15h/15h-17h30", "field6": "S.Dom/S.Franc" }
    ,
    { "field1": "5", "field2": "Seg", "field3": "Interc. e Reunião/CRAS/GI", "field4": "Gespai/CRAS/GI", "field5": "7h e 19h/9h-11h/8h- 9h", "field6": "Templo/S.Franc/Qd" }
    ,
    { "field1": "6", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "7", "field2": "Qua", "field3": "CRAS/GI/CA", "field4": "CRAS/GI/CA", "field5": "9h-11h/8h-9h/19h", "field6": "S.Franc/Qd/S.Dom" }
    ,
    { "field1": "8", "field2": "Qui", "field3": "Adoração e Grupo", "field4": "Gespai", "field5": "15h às 21h", "field6": "Templo" }
    ,
    { "field1": "9", "field2": "Sex", "field3": "Aula Violão", "field4": "Violão", "field5": "14h", "field6": "S.Dom" }
    ,
    { "field1": "10", "field2": "Sab", "field3": "CARNAVAL", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "11", "field2": "Dom", "field3": "CARNAVAL", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "12", "field2": "Seg", "field3": "CARNAVAL", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "13", "field2": "Ter", "field3": "CARNAVAL", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "14", "field2": "Qua", "field3": "QUARTA - FEIRA DE CINZAS", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "15", "field2": "Qui", "field3": "Adoração", "field4": "Gespai", "field5": "15h às 21h", "field6": "Templo" }
    ,
    { "field1": "16", "field2": "Sex", "field3": "Aula Violão", "field4": "Violão", "field5": "14h", "field6": "S.Dom" }
    ,
    { "field1": "17", "field2": "Sab", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "18", "field2": "Dom", "field3": "Formação", "field4": "Coroinhas", "field5": "15h-17h30", "field6": "S.Dom" }
    ,
    { "field1": "19", "field2": "Seg", "field3": "Interc. e Reunião/CRAS/GI", "field4": "Gespai/CRAS/GI", "field5": "7h e 19h/9h-11h/8h-9h", "field6": "Templo/S.Franc/Qd" }
    ,
    { "field1": "20", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "21", "field2": "Qua", "field3": "CRAS/GI/CA/ Reunião", "field4": "CRAS/GI/CA/Vicariato", "field5": "9h-11h/8h-9h/19h/9h-12h", "field6": "S.Franc/Qd/S.Dom/??" }
    ,
    { "field1": "22", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "23", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "24", "field2": "Sab", "field3": "Memória N. Sra Aux. /Terço(Todo �ltimo s�bado)/Reunião/Formação", "field4": "C�rculo B�blico/JMS/Coroinhas", "field5": "9h/15h/15h-17h30", "field6": "Pra�a RM/S.Dom/S.Fam" }
    ,
    { "field1": "25", "field2": "Dom", "field3": "Encontro", "field4": "JMS", "field5": "15h", "field6": "S.Dom" }
    ,
    { "field1": "26", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "27", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "28", "field2": "Qua", "field3": "Memória D. Bosco", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "MARCO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Sex", "field3": "Missa e reunião/reunião/Inicio formação", "field4": "Apostolado/ Músicos/coroinhas", "field5": "7h30/19h30", "field6": "Templo-S.Franc/S.Dom" }
    ,
    { "field1": "2", "field2": "Sab", "field3": "Reunião/Grupão/Aula/Reunião/Reunião", "field4": "SSCC/ECC/D�/JMS/coroinhas", "field5": "9h/19h30/14h/15h/15h-17h30", "field6": "S.Dom/S.Dom/Qd/S.Dom/S.Fam" }
    ,
    { "field1": "3", "field2": "Dom", "field3": "Inscrição para Casamento Comunit�rio/Encontro/Formação", "field4": "Past. Fam/JMS/Coroinhas", "field5": "8h/15h/15h-17h30", "field6": "Templo/S.Dom/S.fam" }
    ,
    { "field1": "", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "5", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "6", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "7", "field2": "Qui", "field3": "Dia Inter. da mulher", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "8", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "9", "field2": "Sab", "field3": "Reunião/Aula/Formação", "field4": "SSCC/Dança/coroinhas", "field5": "9h/14h/15h-17h30", "field6": "S.Dom/Qd/S.Dom" }
    ,
    { "field1": "10", "field2": "Dom", "field3": "Liga/Reunião", "field4": "Liga/ADMA", "field5": "9h-11h/ 16h", "field6": "S.Fam/S.Franc" }
    ,
    { "field1": "11", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "12", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "13", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "14", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "15", "field2": "Sex", "field3": "Reunião", "field4": "Forania", "field5": "10h-12h", "field6": "??" }
    ,
    { "field1": "16", "field2": "Sab", "field3": "Aula/Reunião", "field4": "Dança/JMS", "field5": "14h/15h", "field6": "Qd/S.Dom" }
    ,
    { "field1": "17", "field2": "Dom", "field3": "Reunião/Formação", "field4": "JMS/Coroinhas", "field5": "15h/15h-17h30", "field6": "S.Dom/S.fam" }
    ,
    { "field1": "18", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "19", "field2": "Ter", "field3": "Solenidade São José/CA/CJ/Terço dos homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "20", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "21", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "22", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "23", "field2": "Sab", "field3": "Aula/CPP", "field4": "Dança/CPP", "field5": "14h/9h", "field6": "Qd/S.Dom" }
    ,
    { "field1": "24", "field2": "Dom", "field3": "DOMINGO DE RAMOS", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "25", "field2": "Seg", "field3": "Anunciação do Senhor/Interc e reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "26", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "27", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "28", "field2": "Qui", "field3": "QUINTA-FEIRA SANTA/Lava p�s", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Sex", "field3": "PAIX�O DO SENHOR", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "30", "field2": "Sab", "field3": "S�BADO SANTO", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "31", "field2": "Dom", "field3": "Memória D. Bosco/DOMINGO DA P�SCOA", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "ABRIL", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "2", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "3", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "4", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "5", "field2": "Sex", "field3": "Missa e reunião/reunião", "field4": "Apostolado/ Músicos", "field5": "7h30/19h30", "field6": "Templo-S.Franc/S.Dom" }
    ,
    { "field1": "6", "field2": "Sab", "field3": "Rod. Pastel/ Prep. Cas.Com/Reunião/Grupão/Aula/Reunião", "field4": "EAC/Fam/SSCC/ECC/Dança/Coroinha", "field5": "Dia todo/15h/9h/19h30/14h/15h-17h30", "field6": "Qd, coz. Jov. e S. Fr/S.Fam/S.Dom/S.Dom/Qd/Colg" }
    ,
    { "field1": "7", "field2": "Dom", "field3": "Encerramento Formação", "field4": "coroinha", "field5": "15h-17h30", "field6": "S.Dom" }
    ,
    { "field1": "8", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "9", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "10", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "11", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "12", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "13", "field2": "Sab", "field3": "Aula/Encontro/Retiro Cerimonialista", "field4": "Dança/JMS/Coroinha", "field5": "14h/15h/15h-17h30", "field6": "Qd/S.Dom/col�gio" }
    ,
    { "field1": "14", "field2": "Dom", "field3": "Liga/Reunião/Investidura", "field4": "Liga/ADMA/Coroinha", "field5": "9h-11h/ 16h/9h", "field6": "S.Fam/S.Franc/Templo" }
    ,
    { "field1": "15", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "16", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "17", "field2": "Qua", "field3": "Reunião", "field4": "Vicariato", "field5": "9h-12h", "field6": "??" }
    ,
    { "field1": "18", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "19", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "20", "field2": "Sab", "field3": "Aula", "field4": "Dança", "field5": "14h", "field6": "Qd" }
    ,
    { "field1": "21", "field2": "Dom", "field3": "Tiradentes", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "22", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "23", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "24", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "25", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "26", "field2": "Sex", "field3": "Reunião", "field4": "ECC", "field5": "19h30", "field6": "S.Dom" }
    ,
    { "field1": "27", "field2": "Sab", "field3": "Curso Leitores/Aula/CPP", "field4": "Leitores/Dança/CPP", "field5": "15h-16h30/14h/9h", "field6": "S.Dom/Qd/S.Dom" }
    ,
    { "field1": "28", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "30", "field2": "Ter", "field3": "Terço Homens/Encerramento Inscrição", "field4": "Terço Homens/Coroinha", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "MAIO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Qua", "field3": "FERIADO DIA DO TRABALHADOR", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "2", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "3", "field2": "Sex", "field3": "Missa e reunião/reunião", "field4": "Apostolado/ Músicos", "field5": "7h30/19h30", "field6": "Templo-S.Franc/S.Dom" }
    ,
    { "field1": "", "field2": "Sab", "field3": "Curso Leitores/ Reunião/Aula/Reunião/Reunião", "field4": "Leitrs/SSCC/Dança/JMS/Coroinhas", "field5": "15h-16h30/9h/14h/15h/15h-17h30", "field6": "S.Dom/S.Dom/Qd/S.Fran/S.Fam" }
    ,
    { "field1": "5", "field2": "Dom", "field3": "Inicio formação", "field4": "coroinhas", "field5": "15h-17h30", "field6": "S.Dom" }
    ,
    { "field1": "6", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "7", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "8", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "9", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "10", "field2": "Sex", "field3": "Reunião", "field4": "ECC", "field5": "19h30", "field6": "S.Dom" }
    ,
    { "field1": "11", "field2": "Sab", "field3": "Curso Leitores/ Chá Família/Aula/Formação", "field4": "Leitores/SSCC/Dança/Coro", "field5": "15h-16h30/15h/14h/", "field6": "S.Dom/Cant,coz,Qd e S.Fra/Qd" }
    ,
    { "field1": "12", "field2": "Dom", "field3": "Liga/ DIAS DAS MÃES", "field4": "Liga", "field5": "9h-11h", "field6": "S.Fam" }
    ,
    { "field1": "13", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "14", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "15", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "16", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "17", "field2": "Sex", "field3": "Reunião", "field4": "Forania", "field5": "10h-12h", "field6": "??" }
    ,
    { "field1": "18", "field2": "Sab", "field3": "Vig�lia Pentecoste/Curso Leitores/Aula", "field4": "Gespai/Leitores/Dança", "field5": "A partir de /15h-16h30/14h", "field6": "Templo/S.Dom/Qd" }
    ,
    { "field1": "19", "field2": "Dom", "field3": "PENTECOSTES", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "20", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "21", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "22", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "23", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "24", "field2": "Sex", "field3": "Dia de Nossa Senhora Auxiliadora/Reunião", "field4": "ECC", "field5": "19h30", "field6": "S.Dom" }
    ,
    { "field1": "25", "field2": "Sab", "field3": "Curso Leitores/Aula/CPP", "field4": "Leitores/Dança/CPP", "field5": "15h-16h30/14h/9h", "field6": "S.Dom/Qd/S.Dom" }
    ,
    { "field1": "26", "field2": "Dom", "field3": "Retiro", "field4": "SSCC e JMS", "field5": "7h-17h", "field6": "S.Dom.S.Fran.coz e Templo" }
    ,
    { "field1": "27", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "28", "field2": "Ter", "field3": "PENTECOSTES/Vig�lia de Pentecoste/Terço dos Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "29", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "30", "field2": "Qui", "field3": "CORPUS CRISTI", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "31", "field2": "Sex", "field3": "Memória D. Bosco /1� Dia Trezena Sto Antonio", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "JUNHO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Sab", "field3": "Reunião/Aula/2a Dia Trezena Sto Antonio", "field4": "SSCC/ Dança", "field5": "9h/ 14h", "field6": "S.Dom/Qd" }
    ,
    { "field1": "2", "field2": "Dom", "field3": "3a Dia Trezena Sto Antonio", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "3", "field2": "Seg", "field3": "Interc. e Reunião/4a Trezena Sto Antonio", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "", "field2": "Ter", "field3": "Terço Homens/ 5a Trezena Sto Antonio", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "5", "field2": "Qua", "field3": "6a Trezena Sto Antonio", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "6", "field2": "Qui", "field3": "7a Trezena Sto Antonio", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "7", "field2": "Sex", "field3": "Missa - entrg das meda. aos novos membros/reunião/reunião/8�Trezena", "field4": "Apostolado/ECC/ Músicos", "field5": "7h30/19h30/19h30", "field6": "Templo-S.Franc/S.Dom/Mazarello" }
    ,
    { "field1": "08", "field2": "Sab", "field3": "Curso Leitores/Aula/9� Trezena Sto Antonio", "field4": "Leitores/Dança", "field5": "15h-16h30/14h", "field6": "S.Dom/Qd" }
    ,
    { "field1": "09", "field2": "Dom", "field3": "Liga/Reunião/10� Trezena Sto Antonio", "field4": "Liga/ADMA", "field5": "9h-11h/16h", "field6": "S.Fam/S.Franc" }
    ,
    { "field1": "10", "field2": "Seg", "field3": "Interc e Reunião/11a Trezena Sto Antonio", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "11", "field2": "Ter", "field3": "Terço dos Homens/12a Trezena Sto Antonio", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "12", "field2": "Qua", "field3": "13a Trezena Sto Antonio", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "13", "field2": "Qui", "field3": "DIA SANTO ANTONIO -Missa/ ProcisSão", "field4": "Capela/Capela", "field5": "9h/15h", "field6": "Capela" }
    ,
    { "field1": "14", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "15", "field2": "Sab", "field3": "Curso Leitores/Aula/Reunião", "field4": "Leitores/Dança/JMS", "field5": "15h-16h30/14h/15h", "field6": "S.Dom/S.Franc" }
    ,
    { "field1": "16", "field2": "Dom", "field3": "Festa Junina", "field4": "Capela", "field5": "11h", "field6": "Capela" }
    ,
    { "field1": "17", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "18", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "19", "field2": "Qua", "field3": "Sag. Coração de Jesus/Reunião", "field4": "Vicariato", "field5": "9h-12h", "field6": "??" }
    ,
    { "field1": "20", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "21", "field2": "Sex", "field3": "Reunião", "field4": "ECC", "field5": "19h30", "field6": "S.Dom" }
    ,
    { "field1": "22", "field2": "Sab", "field3": "Curso Leitores/ Aula", "field4": "Leitores/ Dança", "field5": "15h-16h30/ 14h", "field6": "S.Dom/ Qd" }
    ,
    { "field1": "23", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "24", "field2": "Seg", "field3": "Memória Nossa Senhora Auxiliadora/Interc e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "25", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "26", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "27", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "28", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Sab", "field3": "Curso Leitores/ CPP", "field4": "Leitores/CPP", "field5": "15h-16h30/14h", "field6": "S.Dom/ Qd" }
    ,
    { "field1": "30", "field2": "Dom", "field3": "Memória D. Bosco /Almo�o da Capela", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "JULHO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "2", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "3", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "5", "field2": "sex", "field3": "Missa e reunião/reunião", "field4": "Apostolado/ Músicos", "field5": "7h30/19h30", "field6": "Templo-S.Franc/S.Dom" }
    ,
    { "field1": "6", "field2": "Sab", "field3": "Ensaio do rito de investidura/Reunião/Encontro", "field4": "Leitores/SSCC/JMS", "field5": "15-16h30/9h/15h", "field6": "Templo/S.Dom/S.Franc" }
    ,
    { "field1": "7", "field2": "Dom", "field3": "Rito de Investidura dos Novos Leitores/Aprofundamneto", "field4": "ECC", "field5": "Ap�s missa 7h", "field6": "Col�gio" }
    ,
    { "field1": "8", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "9", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "10", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "11", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "12", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "13", "field2": "Sab", "field3": "Chá/ Aula", "field4": "Gespai/ Dança", "field5": "15h-18h/14h", "field6": "S.Dom/Qd" }
    ,
    { "field1": "14", "field2": "Dom", "field3": "Liga/Reunião/", "field4": "Liga/ADMA", "field5": "9h-11h/16h", "field6": "S.Fam/S.Franc" }
    ,
    { "field1": "15", "field2": "Seg", "field3": "Interc. e Reunião/Missa de entrega", "field4": "Jespai/ECC", "field5": "7h e 19h/20h", "field6": "Templo/Templo- Qd" }
    ,
    { "field1": "16", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "17", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "18", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "19", "field2": "Sex", "field3": "Retiro ECC/Reunião", "field4": "ECC/Forania", "field5": "Dia todo/10h-12h", "field6": "??" }
    ,
    { "field1": "20", "field2": "Sab", "field3": "Retiro ECC", "field4": "ECC", "field5": "", "field6": "" }
    ,
    { "field1": "21", "field2": "Dom", "field3": "Retiro ECC", "field4": "ECC", "field5": "", "field6": "" }
    ,
    { "field1": "22", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "23", "field2": "Ter", "field3": "P�s ECC/Terço dos Homens", "field4": "ECC/Terço", "field5": "19h30", "field6": "Templo- Qd" }
    ,
    { "field1": "24", "field2": "Qua", "field3": "Mem.N� Sra Aux/", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "25", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "26", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "27", "field2": "Sab", "field3": "Aula/CPP", "field4": "Dança/CPP", "field5": "14h /9h", "field6": "Qd /S.Dom" }
    ,
    { "field1": "28", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "30", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "31", "field2": "Qua", "field3": "Memória D. Bosco", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "AGOSTO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "2", "field2": "Sex", "field3": "Missa e reunião/reunião", "field4": "Apostolado/ Músicos", "field5": "7h30/19h30", "field6": "Templo-S.Franc/S.Dom" }
    ,
    { "field1": "3", "field2": "Sab", "field3": "Reunião/Aula/Encontro", "field4": "SSCC/Dança/JMS", "field5": "9h/14h/15h", "field6": "S.Dom/Qd/S.Dom" }
    ,
    { "field1": "", "field2": "Dom", "field3": "Encontro", "field4": "JMS", "field5": "15h", "field6": "S.Dom" }
    ,
    { "field1": "5", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "6", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "7", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "8", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "9", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "10", "field2": "Sab", "field3": "Aula", "field4": "Dança", "field5": "14h", "field6": "Qd" }
    ,
    { "field1": "11", "field2": "Dom", "field3": "Liga/ DIA DOS PAIS/ Semana Nacional da Família", "field4": "Liga", "field5": "9h-11h", "field6": "S.Fam" }
    ,
    { "field1": "12", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "13", "field2": "Ter", "field3": "CA/Reunião/Dia dos Pais/Liga", "field4": "CA/Batismo/Liga", "field5": "7h30- 9h30/9h-11h30/9h-11h", "field6": "S.Franc/S.Dom/S.Fam." }
    ,
    { "field1": "14", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "15", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "16", "field2": "Sex", "field3": "Aniversário DOM BOSCO", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "17", "field2": "Sab", "field3": "Tarde Valdocco/Aula", "field4": "SSCC/Dança", "field5": "14h-17h/14h", "field6": "Cantiana,coz,qd e S.Dom/Qd" }
    ,
    { "field1": "18", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "19", "field2": "Seg", "field3": "Tarde Valdocco", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "20", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "21", "field2": "Qua", "field3": "Reunião", "field4": "Vicariato", "field5": "9h-12h", "field6": "??" }
    ,
    { "field1": "22", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "23", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "24", "field2": "Sab", "field3": "Memória Nossa Senhora Auxiliadora/Aula/CPP", "field4": "Gespai/ Dança/CPP", "field5": "15h às 21h/14h/ 9h", "field6": "Templo/Qd/S.Dom" }
    ,
    { "field1": "25", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "26", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "27", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "28", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "30", "field2": "Sex", "field3": "ROMARIA APARECIDA???/Reunião", "field4": "JMS", "field5": "15h", "field6": "S.Franc" }
    ,
    { "field1": "31", "field2": "Sab", "field3": "Memória D. Bosco/ROMARIA APARECIDA/Aula/Encontro", "field4": "Dança/JMS", "field5": "14h/15h", "field6": "Qd/S.Dom" }
    ,
    { "field1": "", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "SETEMBRO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "2", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "3", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "5", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "6", "field2": "Sex", "field3": "Missa e reunião/reunião/Encontro", "field4": "Apostolado/ Músicos/JMS", "field5": "7h30/19h30/15h", "field6": "Templo-S.Franc/S.Dom/S.Franc" }
    ,
    { "field1": "7", "field2": "Sab", "field3": "Aula/Reunião", "field4": "Dança/JMS", "field5": "14h/15h", "field6": "Qd/S.Dom" }
    ,
    { "field1": "8", "field2": "Dom", "field3": "Liga/Encontro", "field4": "Liga/JMS", "field5": "9h-11h/15h", "field6": "S.Fam/S.Dom" }
    ,
    { "field1": "9", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "10", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "11", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "12", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "13", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "14", "field2": "Sab", "field3": "Aprofundamento EAC/Reunião/Aula", "field4": "EAC/SSCC/Dança", "field5": "/9h/14h", "field6": "Qd, S.Fam, Jovens e S.Dom/S.Dom/Qd" }
    ,
    { "field1": "15", "field2": "Dom", "field3": "10� Mostra de Dança do grupo Dom Bosco", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "16", "field2": "Seg", "field3": "Semana Formação B�blica", "field4": "C�rculo B�blico", "field5": "15h", "field6": "S.Dom" }
    ,
    { "field1": "17", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "18", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "19", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "20", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "21", "field2": "Sab", "field3": "RETIRO EAC", "field4": "", "field5": "", "field6": "PARÓQUIA e Col�gio" }
    ,
    { "field1": "22", "field2": "Dom", "field3": "RETIRO EAC", "field4": "", "field5": "", "field6": "PARÓQUIA e Col�gio" }
    ,
    { "field1": "23", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "24", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "25", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "26", "field2": "Qui", "field3": "Aniversário Gespai", "field4": "Gespai", "field5": "19h", "field6": "Templo" }
    ,
    { "field1": "27", "field2": "Sex", "field3": "67a ANIV. PARÓQUIA/CA", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "28", "field2": "Sab", "field3": "Aula/CPP", "field4": "Dança/CPP", "field5": "14h/9h", "field6": "Qd/S.Dom" }
    ,
    { "field1": "29", "field2": "Dom", "field3": "67a ANIV. PARÓQUIA", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "30", "field2": "Seg", "field3": "Memória D. Bosco/IntercesSão e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "OUTUBRO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "2", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "3", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "4", "field2": "Sex", "field3": "Missa e reunião/reunião", "field4": "Apostolado/ Músicos", "field5": "7h30/19h30", "field6": "Templo-S.Franc/S.Dom" }
    ,
    { "field1": "5", "field2": "Sab", "field3": "Reunião/Aula/Encontro", "field4": "SSCC/Dança/JMS", "field5": "9h/14h/15h", "field6": "S.Dom/Qd/S.Dom" }
    ,
    { "field1": "6", "field2": "Dom", "field3": "Encontro", "field4": "JMS", "field5": "15h", "field6": "S.Dom" }
    ,
    { "field1": "7", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "8", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "9", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "10", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "11", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "12", "field2": "Sab", "field3": "Feriado de N.Sra. Da Conceição Aparecida/Festividade Dança", "field4": "Dança", "field5": "", "field6": "" }
    ,
    { "field1": "13", "field2": "Dom", "field3": "Festa das crianças/ Liga/Reunião/Recreação c/crianças", "field4": "Vicentinos/Liga/ADMA/SSCC", "field5": "9h-11h/9h-11h/16h/14h", "field6": "Qd/Liga/S;Fran/Cantina,coz,Qd, S.Dom" }
    ,
    { "field1": "14", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "15", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "16", "field2": "Qua", "field3": "Reunião", "field4": "Vicariato", "field5": "9h-12h", "field6": "??" }
    ,
    { "field1": "17", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "18", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "19", "field2": "Sab", "field3": "Aula/Comemoração Dia crianças", "field4": "Dança/Capela", "field5": "14h/15h", "field6": "Qd /Capela" }
    ,
    { "field1": "20", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "21", "field2": "Seg", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "22", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "23", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "24", "field2": "Qui", "field3": "Memória N. Sra Aux.", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "25", "field2": "Sex", "field3": "Encontro", "field4": "JMS", "field5": "15h", "field6": "S.Franc" }
    ,
    { "field1": "26", "field2": "Sab", "field3": "Aula/CPP/Reunião", "field4": "Dança/CPP/JMS", "field5": "14h/9h/15h", "field6": "Qd/S.Dom/S.Dom" }
    ,
    { "field1": "27", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "28", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "29", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "30", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "31", "field2": "Qui", "field3": "Mem. D. Bosco", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "NOVEMBRO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Sex", "field3": "Missa e reunião/reunião", "field4": "Apostolado/ Músicos", "field5": "7h30/19h30", "field6": "Templo-S.Franc/S.Dom" }
    ,
    { "field1": "2", "field2": "Sab", "field3": "FINADOS", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "3", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "5", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "6", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "7", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "8", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "9", "field2": "Sab", "field3": "Reunião/Aula", "field4": "SSCC/Dança", "field5": "9h/14h", "field6": "S.Dom/Qd" }
    ,
    { "field1": "10", "field2": "Dom", "field3": "Liga/Reunião", "field4": "Liga/ADMA", "field5": "9h-11h/16h", "field6": "S.Fam/S.Franc" }
    ,
    { "field1": "11", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "12", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "13", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "14", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "15", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "16", "field2": "Sab", "field3": "Aula", "field4": "Dança", "field5": "14h", "field6": "Qd" }
    ,
    { "field1": "17", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "18", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "19", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "20", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "21", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "22", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "23", "field2": "Sab", "field3": "Reunião CPP/Aula/Reunião", "field4": "CPP/Dança/JMS", "field5": "9h/14h/15h", "field6": "S.Dom/Qd/S.Dom" }
    ,
    { "field1": "24", "field2": "Dom", "field3": "Memória N. Sra Aux", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "25", "field2": "Seg", "field3": "Inic. Nov. Sta Bárbara/IntercesSão e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "26", "field2": "Ter", "field3": "Nov.Perpétua Sta Bárbara/Terço com missa", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "27", "field2": "Qua", "field3": "Nov.Sto Bárbara", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "28", "field2": "Qui", "field3": "Nov.Sto Bárbara", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Sex", "field3": "Nov. Sto Bárbara", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "30", "field2": "Sab", "field3": "Memória D. Bosco/Nov.Sto Bárbara", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DEZEMBRO", "field2": "", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "DIA", "field2": "", "field3": "ATIVIDADE", "field4": "PASTORAL", "field5": "HORA", "field6": "LOCAL" }
    ,
    { "field1": "1", "field2": "Dom", "field3": "Nov.Sto Bárbara", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "2", "field2": "Seg", "field3": "Nov.Perpétua Sta Bárbara/IntercesSão e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "3", "field2": "Ter", "field3": "Nov.Perpétua Sta Bárbara/Terço dos Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "4", "field2": "Qua", "field3": "FESTA SANTA Bárbara/ Apresentação Ofic.Dança", "field4": "Dança", "field5": "", "field6": "" }
    ,
    { "field1": "5", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "6", "field2": "Sex", "field3": "Missa e reunião", "field4": "Apostolado", "field5": "7h30", "field6": "Templo-S.Franc" }
    ,
    { "field1": "7", "field2": "Sab", "field3": "Reunião/Confraternização Dança", "field4": "SSCC/Dança", "field5": "9h/14h", "field6": "S.Dom/Qd" }
    ,
    { "field1": "8", "field2": "Dom", "field3": "Liga", "field4": "Liga", "field5": "9h-11h", "field6": "S.Fam" }
    ,
    { "field1": "9", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "10", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "11", "field2": "Qua", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "12", "field2": "Qui", "field3": "Confraternização Gespai", "field4": "Gespai", "field5": "20h", "field6": "S.Dom" }
    ,
    { "field1": "13", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "14", "field2": "Sab", "field3": "Festa dos famliares/Encontro Natal", "field4": "Vicentinos/JMS", "field5": "9h-11h/??", "field6": "Qd/??" }
    ,
    { "field1": "15", "field2": "Dom", "field3": "Reunião/Apadrinhamento", "field4": "ADMA/Capela", "field5": "16h/11h", "field6": "S.Franc/Capela" }
    ,
    { "field1": "16", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "17", "field2": "Ter", "field3": "Terço Homens", "field4": "Terço Homens", "field5": "19h30", "field6": "Templo" }
    ,
    { "field1": "18", "field2": "Qua", "field3": "Reunião", "field4": "Vicariato", "field5": "9h-12h", "field6": "??" }
    ,
    { "field1": "19", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "20", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "21", "field2": "Sab", "field3": "Reunião CPP", "field4": "CPP", "field5": "9h", "field6": "S.Dom" }
    ,
    { "field1": "22", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "23", "field2": "Seg", "field3": "Interc. e Reunião", "field4": "Gespai", "field5": "7h e 19h", "field6": "Templo" }
    ,
    { "field1": "24", "field2": "Ter", "field3": "Memória N. Sra Aux", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "25", "field2": "Qua", "field3": "NATAL DO SENHOR", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "26", "field2": "Qui", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "27", "field2": "Sex", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "28", "field2": "Sab", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "29", "field2": "Dom", "field3": "", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "30", "field2": "Seg", "field3": "Memória D. Bosco", "field4": "", "field5": "", "field6": "" }
    ,
    { "field1": "31", "field2": "Ter", "field3": "", "field4": "", "field5": "", "field6": "" }
  ]

}
