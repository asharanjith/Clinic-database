create database clinic;

create table patients ( id int primary key not null generated always as identity,
                        name varchar(100) not null,
                        date_of_birth date not null
                        );
                       
create table medical_histories ( id int primary key not null generated always as identity,
                                 admitted_at timestamp not null ,
                                 patient_id int not null,
                                 status varchar(100) 
                                 constraint fk_patient_id foreign key(fk_patient_id) references patients(id)
                                 );
                                 
create table treatments ( id  primary key not null serial,
                          type varchar(100) not null,
                          name varchar (100) not null
                        );
                       
create table invoices ( id  primary key not null serial, 
                        total_amount decimal not null,
                        generated_at timestamp not null,
                        payed_At timestamp not null,
                        medical_history_id not null,
                        constraint fk_medical_history_id foreign key(fk_medical_history_id) references medical_histories(id)
                      );
                      
 create table invoice_items ( id  primary key not null serial,
                              unit_price decimal not null,
                              quantity int,
                              total_price decimal not null,
                              invoice_id int not null,
                              treatment_id int not null,
                              constraint fk_treatment_id foreign key(fk_treatment_id) references treatments(id),
                              constraint fk_invoice_id foreign key(fk_invoice_id) references invoices(id)
                            );
                            
  create table medical_history_and_treatments ( medical_history_id int primary key not null,
                                                treatments_id int primary key not null
                                                constraint fk_medical_history_id foreign key(fk_medical_history_id) references medical_histories(id),
                                                constraint fk_treatments_id foreign key(fk_treatments_id) references treatments(id)
                                                );
  
  create index on medical_histories(patient_id);
  create index on invoices(medical_history_id);
  create index on invoice_items(treatment_id);
  create index on invoice_items(invoice_id);
  create index on medical_history_and_treatments(medical_history_id);
  create index on medical_history_and_treatments(treatments_id);
                                
