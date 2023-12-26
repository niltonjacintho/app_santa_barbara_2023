// app-routing.module.ts
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { HomeComponent } from './components/home/home.component';
import { AvisosComponent } from './components/avisos/avisos.component';
import { ImportarAgendaComponent } from './components/importar/importarAgenda.component';


const routes: Routes = [
  { path: '', component: LoginComponent }, // Rota inicial
  { path: 'home', component: HomeComponent },
  { path: 'avisos', component: AvisosComponent },
  { path: 'importar', component: ImportarAgendaComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule { }
