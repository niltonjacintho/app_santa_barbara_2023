import { Injectable } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/compat/auth';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  constructor(private afAuth: AngularFireAuth) { }

  // Método para realizar o login
  login(email: string, password: string): Promise<any> {
    return this.afAuth.signInWithEmailAndPassword(email, password);
  }

  // Método para fazer logout
  logout(): Promise<void> {
    return this.afAuth.signOut();
  }

  // Método para registrar um novo usuário
  register(email: string, password: string): Promise<any> {
    return this.afAuth.createUserWithEmailAndPassword(email, password);
  }

  // Verificar o estado de autenticação atual
  checkAuthState(): Promise<any> {
    return this.afAuth.authState.toPromise();
  }
}
