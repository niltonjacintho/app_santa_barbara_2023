// app-routing.module.ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { HomeComponent } from './components/home/home.component';


const routes: Routes = [
  { path: '', component: LoginComponent }, // Rota inicial
  { path: 'home', component: HomeComponent },
  // Outras rotas podem ser adicionadas aqui
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule { }
