import { Component } from '@angular/core';
import { MenuItem } from 'primeng/api';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],

})
export class HomeComponent {
  items: MenuItem[];

  constructor() {
    this.items = [
      {
        label: 'Home',
        icon: 'pi pi-fw pi-home',
        routerLink: ['/home'] // Defina a rota para a página inicial
      },
      {
        label: 'Avisos',
        icon: 'pi pi-fw pi-bookmark',
        routerLink: ['/avisos'] // Defina a rota para a página de produtos
      },
      // Adicione mais itens conforme necessário
    ];
  }
}
