import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { MessagesModule } from 'primeng/messages';
import { ToastModule } from 'primeng/toast';
import { PasswordModule } from 'primeng/password';
import { TableModule } from 'primeng/table';
import { InputTextareaModule } from 'primeng/inputtextarea';
import { CalendarModule } from 'primeng/calendar';
import { DropdownModule } from 'primeng/dropdown';
import { InputSwitchModule } from 'primeng/inputswitch';

import { DialogModule } from 'primeng/dialog';
import { InputTextModule } from 'primeng/inputtext';
import { PanelModule } from 'primeng/panel';
import { MenubarModule } from 'primeng/menubar';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { initializeApp, provideFirebaseApp } from '@angular/fire/app';
import { AngularFireMessagingModule } from '@angular/fire/compat/messaging';
import { AngularFireModule } from '@angular/fire/compat';
//import { environment } from '../environments/environment';
import { getAuth, provideAuth } from '@angular/fire/auth';
import { getFirestore, provideFirestore } from '@angular/fire/firestore';
import { LoginComponent } from './components/login/login.component';
import { AuthService } from './services/auth.service';
import { HomeComponent } from './components/home/home.component';
import { AvisosComponent } from './components/avisos/avisos.component';
import { ImportarAgendaComponent } from './components/importar/importarAgenda.component';
import { MessageService } from 'primeng/api';
import { ArtigoService } from './services/artigos.service';


import { ReactiveFormsModule } from '@angular/forms';
import { provideStorage, getStorage } from '@angular/fire/storage';
import { FIREBASE_OPTIONS } from '@angular/fire/compat';
import { ImportarParoquiasComponent } from './components/importar-paroquias/importar-paroquias.component';
import { HttpClientModule } from '@angular/common/http';


@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    AvisosComponent,
    ImportarAgendaComponent,
    ImportarParoquiasComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    FormsModule,
    ReactiveFormsModule,
    AppRoutingModule,
    InputTextModule,
    DialogModule,
    ButtonModule,
    PanelModule,
    MessagesModule,
    PasswordModule,
    MenubarModule,
    ToastModule,
    TableModule,
    DropdownModule,
    InputTextareaModule,
    InputSwitchModule,
    CalendarModule,
    HttpClientModule,
    AngularFireModule.initializeApp({
      "projectId": "project-2297216869628270192",
      "appId": "1:999243580674:web:97bcb06337ef4d04352e1b",
      "databaseURL": "https://paroquia.firebaseio.com",
      "storageBucket": "project-2297216869628270192.appspot.com",
      "apiKey": "AIzaSyDikppRvC3xGB2Jikx_u_STV5kCGUYP51M",
      "authDomain": "paroquia.firebaseapp.com",
      "messagingSenderId": "999243580674",
      "measurementId": "G-WDRBMW9B0L"
    }),
    provideFirebaseApp(() => initializeApp({
      "projectId": "project-2297216869628270192",
      "appId": "1:999243580674:web:97bcb06337ef4d04352e1b",
      "databaseURL": "https://paroquia.firebaseio.com",
      "storageBucket": "project-2297216869628270192.appspot.com",
      "apiKey": "AIzaSyDikppRvC3xGB2Jikx_u_STV5kCGUYP51M",
      "authDomain": "paroquia.firebaseapp.com",
      "messagingSenderId": "999243580674",
      "measurementId": "G-WDRBMW9B0L"
    })),
    provideAuth(() => getAuth()),
    provideFirestore(() => getFirestore()),
    provideStorage(() => getStorage())
  ],
  providers: [AuthService, MessageService, ArtigoService],
  bootstrap: [AppComponent]
})
export class AppModule { }
