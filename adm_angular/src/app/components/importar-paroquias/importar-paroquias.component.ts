import { Component } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';


@Component({
  selector: 'app-importar-paroquias',
  templateUrl: './importar-paroquias.component.html',
  styleUrls: ['./importar-paroquias.component.scss']
})
export class ImportarParoquiasComponent {
  constructor(private http: HttpClient) { }

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
