import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ImportarAgendaComponent } from './importarAgenda.component';



describe('ImportarAgendaComponent', () => {
  let component: ImportarAgendaComponent;
  let fixture: ComponentFixture<ImportarAgendaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ImportarAgendaComponent]
    });
    fixture = TestBed.createComponent(ImportarAgendaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
