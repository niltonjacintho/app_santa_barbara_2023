import { Component } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  display: boolean = false;
  username: string = '';
  password: string = '';

  constructor(private authService: AuthService) { }

  showDialog() {
    this.display = true;
  }

  hideDialog() {
    this.display = false;
  }

  login() {
    this.authService.login(this.username, this.password)
      .then(userCredential => {
        console.log('Usuário logado:', userCredential.user);
        // Redirecionar o usuário ou fazer outras operações após o login bem-sucedido
      })
      .catch(error => {
        console.error('Erro de login:', error);
      });
  }

  cancel() {
    // Implementar a lógica de cancelamento aqui
  }
}
