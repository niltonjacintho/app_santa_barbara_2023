import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImportarParoquiasComponent } from './importar-paroquias.component';

describe('ImportarParoquiasComponent', () => {
  let component: ImportarParoquiasComponent;
  let fixture: ComponentFixture<ImportarParoquiasComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ImportarParoquiasComponent]
    });
    fixture = TestBed.createComponent(ImportarParoquiasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
