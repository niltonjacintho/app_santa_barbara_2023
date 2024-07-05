import { Component } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import axios from 'axios';

@Component({
  selector: 'app-importar-paroquias',
  templateUrl: './importar-paroquias.component.html',
  styleUrls: ['./importar-paroquias.component.scss']
})

///
// Parei em 4/07/2024 devido a erros de CORS que só dao no angular
//
//


export class ImportarParoquiasComponent {
  pagina = 1;
  existPagina = true;
  paroquias = []
  p = Object();
  html = '';
  htmlDetalhes = '';
  headers = new HttpHeaders({

    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Credentials': 'true',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
    'key': 'x-api-key',
    'value': 'NNctr6Tjrw9794gFXf3fi6zWBZ78j6Gv3UCb3y0x'
  });
  constructor(private http: HttpClient) { }
  async importar() {
    console.log('vai chamar')
    while (this.existPagina) {
      await this.getPagina(this.pagina).then((o) => console.log('RETORNO DA PAGONA ', o))
      var existeItem = true;
      // while (existeItem) {
      // var currentId = this.getCurrentId();
      // var currentName = this.getObjParoquia();
      //   // console.log(currentName);
      //   await this.getPaginaDetalhes(currentId).then(function (data) { this.htmlDetalhes = data; });
      //   if (currentId == 2) {
      //     console.log(this.htmlDetalhes);
      //     this.getBaseParoquia();
      //     console.log('VALOR DE P', this.p);
      // }



      // this.p.currentId = currentId;
      // this.p.currentName = currentName;

      // // console.log(html.indexOf('"recuperaDetalhes('))
      // html = html.substring(html.indexOf('"recuperaDetalhes('));
      // // console.log(html.substring(0, 100))
      // // console.log('resultado ', parseInt(html.substring(0, html.indexOf("')") + 1).split(',')[1].replace("'", "")));
      // var id = getCurrentId(html);
      // var this.htmlDetalhes = getPaginaDetalhes(id);
      // var objParoquia = getObjParoquia(this.htmlDetalhes);
      // console.log('OBJ PAROQUIA ', objParoquia);
      // existeItem = html.indexOf('"recuperaDetalhes(') != -1
      //}
      this.existPagina = false;
    }
  }

  getCurrentId() {
    this.html = this.html.substring(this.html.indexOf('"recuperaDetalhes('));
    return parseInt(this.html.substring(0, this.html.indexOf("')") + 1).split(',')[1].replace("'", ""));
  }

  getObjParoquia() {
    this.html = this.html.substring(this.html.indexOf('"lista-link">') + 13);
    return this.html.substring(0, this.html.indexOf("</a>")).trim();
  }

  async getPagina(pagina: number): Promise<Object> {
    var resultado = 'nada';

    return axios.get('https://www.arqrio.com.br/curia/paroquias.php');

    //   , {
    //   headers: {
    //     'x-rapidapi-host': 'jokes-by-api-ninjas.p.rapidapi.com',
    //     'x-rapidapi-key': 'your-rapid-api-key'
    //   }
    // });



    return this.http.get('https://www.arqrio.com.br/curia/paroquiasssss.php').subscribe((v) => {
      console.log('NO SUBSCRIBE ==> ', v);
    });

    // .'' . subscribe(response => {
    //   console.log(response); // Print the response status code if a response was received
    // })
    // return '';
  }

  // async getPaginaDetalhes(id) {
  //   var resultado = 'nada';
  //   return new Promise(async (resolve, reject) => {
  //     await request({
  //       url: 'https://www.arqrio.com.br/curia/ajaxParoquiasRecuperarDetalhes.php?id=' + id, //URL to hit
  //       method: 'GET',
  //       headers: {
  //         'Content-Type': 'MyContentType',
  //         'Custom-Header': 'Custom Value'
  //       },
  //     }, function (error, response, body) {
  //       if (error) {
  //         resultado = error;
  //         reject(error);
  //       } else {
  //         resultado = body;
  //         resolve(body)
  //       }
  //     });
  //   })
  // }

  getBaseParoquia() {
    this.p.nome = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<b>') + 3, this.htmlDetalhes.indexOf('</b>'));
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('</b>'));
    this.p.forania = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4, this.htmlDetalhes.indexOf('<br>Data')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>Data'));
    this.p.nascimento = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf(':') + 1, this.htmlDetalhes.indexOf('<br><br')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br><br>') + 8);
    this.p.endereco2 = this.htmlDetalhes.substring(0, this.htmlDetalhes.indexOf('<br>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4);
    this.p.endereco = this.htmlDetalhes.substring(0, this.htmlDetalhes.indexOf('<br>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4);
    this.p.endereco += ' - CEP:' + this.htmlDetalhes.substring(0, this.htmlDetalhes.indexOf('<br>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4);
    this.p.telefones = this.htmlDetalhes.substring(0, this.htmlDetalhes.indexOf('<br>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4);
    this.p.email = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf(':') + 1, this.htmlDetalhes.indexOf('</p>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('</p>') + 4);




    //    return parseInt(html.substring(0, html.indexOf("')") + 1).split(',')[1].replace("'", ""));
  }



  getData() {
    this.http.get('https://www.arqrio.com.br/curia/paroquias.php', {
      headers:
        new HttpHeaders(
          {
            'Access-Control-Allow-Origin': '*',
            'X-Requested-With': 'XMLHttpRequest',
            'MyClientCert': '',        // This is empty
            'MyToken': ''              // This is empty
          }
        )
    })
      .subscribe(data => {
        console.log(data);
      });
  }

}
