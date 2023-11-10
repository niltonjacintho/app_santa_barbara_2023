import { Component } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  display: boolean = false;
  username: string = '';
  password: string = '';

  constructor(private authService: AuthService, private router: Router, private messageService: MessageService) { }

  showDialog() {
    this.display = true;
  }

  hideDialog() {
    this.display = false;
  }

  login(): boolean {
    this.authService.login(this.username, this.password)
      .then(userCredential => {
        console.log('Usuário logado:', userCredential.user);
        this.router.navigate(['/home']);
        // Redirecionar o usuário ou fazer outras operações após o login bem-sucedido
      })
      .catch(error => {
        console.error('Erro de login:', error);
        this.messageService.add({ severity: 'error', summary: 'Falha no login', detail: 'Usuario ou senha invalidos' });
      });
    return false;
  }

  cancel() {
    // Implementar a lógica de cancelamento aqui
  }
}
