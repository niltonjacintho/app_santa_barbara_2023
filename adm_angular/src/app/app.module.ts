import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';

import { DialogModule } from 'primeng/dialog';
import { InputTextModule } from 'primeng/inputtext';
import { PanelModule } from 'primeng/panel';

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


@NgModule({
  declarations: [
    AppComponent,
    LoginComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    FormsModule,
    AppRoutingModule,
    InputTextModule,
    DialogModule,
    ButtonModule,
    PanelModule,
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
    //provideFirebaseApp(() => initializeApp(environment.firebase)), 
    provideAuth(() => getAuth()),
    provideFirestore(() => getFirestore())
  ],
  providers: [AuthService],
  bootstrap: [AppComponent]
})
export class AppModule { }
