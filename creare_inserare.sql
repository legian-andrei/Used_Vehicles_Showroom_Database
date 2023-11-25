                        -- CREARE TABELE

create table marci (id_marca NUMBER(3, 0),
                    denumire varchar2(30) not null,
                    grup varchar2(30), 
                    constraint brand_pk primary key (id_marca),
                    CONSTRAINT unq_brand UNIQUE (denumire)
                    ); 
describe marci;
         
create table categ_auto (id_categ number(2, 0), 
                        denumire VARCHAR2(30) not null,
                        constraint cat_auto_pk primary key(id_categ),
                        constraint unq_categ_auto unique (denumire)
                        );
describe categ_auto;

create table categ_moto (id_categ number(2, 0), 
                        denumire VARCHAR2(30) not null,
                        constraint cat_moto_pk primary key(id_categ),
                        constraint unq_categ_moto unique (denumire)
                        );
describe categ_moto;

create table motor_auto (id_motor varchar2(20),
                        denumire varchar2(30),
                        combustibil varchar2(20) not null,
                        hybrid varchar2(20),
                        capac_cil NUMBER(5, 0),
                        nr_cil NUMBER(2, 0),
                        putere NUMBER(5, 0) not null,
                        cuplu_max NUMBER(5, 0) not null, 
                        constraint eng_auto_pk primary key(id_motor)
                        );
describe motor_auto;
                        
create table tari (id_tara varchar2(3),
                    denumire varchar2(30) not null,
                    constraint tara_pk primary key(id_tara)
                    );
describe tari;

create table judete (id_judet varchar(2),
                    denumire varchar2(30) not null,
                    id_tara varchar2(3),
                    constraint judet_pk primary key(id_judet),
                    constraint judet_tara_fk FOREIGN key (id_tara) references tari(id_tara)
                    );
describe judete;
                    
create table locatii (id_locatie number(4,0),
                        strada varchar2(30),
                        localitate varchar2(30),
                        id_judet varchar(2),
                        constraint locatie_pk primary key(id_locatie),
                        constraint locatie_judet_fk foreign key (id_judet) references judete(id_judet)
                        );
describe locatii;
                    
create table motociclete ( id_moto number(5, 0),
                            id_marca number(3, 0),
                            model varchar2(30) not null,
                            id_categ number(2, 0),
                            data_fabricatie date,
                            nr_km number(8, 2) not null,
                            pret number(6, 0) not null,
                            id_tara_provenienta varchar2(3),
                            capac_cil NUMBER(5, 0) not null,
                            nr_cil NUMBER(2, 0),
                            putere NUMBER(5, 0) not null,
                            cuplu_max NUMBER(6, 2),
                            cutie_vit varchar2(50),
                            nr_trepte number(2, 0),
                            masa number(3, 2),
                            capac_rezervor number(3),
                            inaltime_sa number(3, 0),
                            constraint moto_pk primary key(id_moto),
                            constraint moto_marca_fk foreign key(id_marca) references marci(id_marca),
                            constraint moto_categ_moto_fk foreign key(id_categ) references categ_moto(id_categ),
                            constraint moto_tara_fk foreign key(id_tara_provenienta) references tari(id_tara)
                            );
describe motociclete;
                            
create table masini ( id_auto number(5, 0),
                    id_marca number(3, 0),
                    model varchar2(30) not null,
                    id_categ number(2, 0),
                    data_fabricatie date,
                    nr_km number(8, 2) not null,
                    pret number(7, 0) not null,
                    id_tara_provenienta varchar2(3),
                    id_motor varchar2(20) not null,
                    cutie_vit varchar2(20),
                    nr_trepte number(2, 0),
                    tractiune varchar2(20),
                    masa number(6),
                    norma_poluare varchar2(7),
                    constraint auto_pk primary key(id_auto),
                    constraint auto_marca_fk foreign key(id_marca) references marci(id_marca),
                    constraint auto_categ_auto_fk foreign key(id_categ) references categ_auto(id_categ),
                    constraint auto_tara_fk foreign key(id_tara_provenienta) references tari(id_tara),
                    constraint auto_motor_fk foreign key(id_motor) references motor_auto(id_motor)
                    );
describe masini;
                            
create table accesorii_auto(id_accesoriu number(10, 0),
                            id_auto number(5, 0),
                            denumire varchar2(100),
                            pret number(6, 2) not null,
                            constraint acc_a_pk primary key(id_accesoriu),
                            constraint acc_a_auto_fk foreign key(id_auto) REFERENCES masini(id_auto)
                            );
describe accesorii_auto;
                            
create table inreg_service_auto (id_service number(5, 0),
                                id_auto number(5, 0),
                                data_service date,
                                descriere varchar2(300),
                                constraint isa_pk primary key(id_service),
                                constraint isa_auto_fk foreign key(id_auto) references masini(id_auto)
                                );
describe inreg_service_auto;
                                
create table accesorii_moto(id_accesoriu number(10, 0),
                            id_moto number(5, 0),
                            denumire varchar2(100),
                            pret number(6, 2) not null,
                            constraint acc_m_pk primary key(id_accesoriu),
                            constraint acc_m_moto_fk foreign key(id_moto) REFERENCES motociclete(id_moto)
                            );
describe accesorii_moto;
                            
create table inreg_service_moto (id_service number(5, 0),
                                id_moto number(5, 0),
                                data_service date,
                                descriere varchar2(300),
                                constraint ism_pk primary key(id_service),
                                constraint ism_auto_fk foreign key(id_moto) references motociclete(id_moto)
                                );
describe inreg_service_moto;
                                
create table login_info (id_login number(10, 0),
                        email varchar2(50) not null,
                        username varchar2(25) not null,
                        parola varchar2(50) not null,
                        constraint li_pk primary key(id_login)
                        );
describe login_info;
                        
create table clienti (id_client number(7, 0),
                        nume varchar2(20) not null,
                        prenume varchar2(25) not null,
                        telefon varchar2(20),
                        id_login number(10, 0),
                        id_locatie number(4, 0),
                        constraint cl_pk primary key(id_client),
                        constraint cl_li_fk foreign key(id_login) references login_info(id_login),
                        constraint cl_loc_fk foreign key(id_locatie) references locatii(id_locatie)
                        );
describe clienti;
                        
create table angajati (id_angajat number(7, 0),
                        nume varchar2(20) not null,
                        prenume varchar2(25) not null,
                        telefon varchar2(20),
                        salariu number(7, 0) not null,
                        id_login number(10, 0),
                        id_locatie number(4, 0),
                        constraint ang_pk primary key(id_angajat),
                        constraint ang_li_fk foreign key(id_login) references login_info(id_login),
                        constraint ang_loc_fk foreign key(id_locatie) references locatii(id_locatie)
                        );
describe angajati;
                        
create table vanzari (id_vanzare number(7, 0),
                        id_client number(7, 0),
                        id_angajat number(7, 0),
                        data_vanzare date not null,
                        suma_totala number(10, 0) not null,
                        constraint vnz_pk primary key(id_vanzare),
                        constraint vnz_cl_fk foreign key(id_client) references clienti(id_client),
                        constraint vnz_ang_fk foreign key(id_angajat) references angajati(id_angajat)
                        );
describe vanzari;
                        
create table v_auto (id_vanzare number(7, 0),
                        id_auto number(5, 0),
                        constraint v_a_vnz_fk foreign key(id_vanzare) references vanzari(id_vanzare),
                        constraint v_a_auto_fk foreign key(id_auto) references masini(id_auto),
                        constraint v_a_pk primary key(id_vanzare, id_auto)
                        ); 
describe v_auto;
                        
create table v_moto (id_vanzare number(7, 0),
                        id_moto number(5, 0),
                        constraint v_m_vnz_fk foreign key(id_vanzare) references vanzari(id_vanzare),
                        constraint v_m_moto_fk foreign key(id_moto) references motociclete(id_moto),
                        constraint v_m_pk primary key(id_vanzare, id_moto)
                        );
describe v_moto;                                             


                            -- INSERARE DATE

-- INSERARE MARCI
create sequence marci_seq start with 1 increment by 1;
insert into marci values (marci_seq.nextval, 'Honda', 'Honda');
insert into marci values (marci_seq.nextval, 'Acura', 'Honda');
insert into marci values (marci_seq.nextval, 'Citroen', 'PSA');
insert into marci values (marci_seq.nextval, 'Peugeot', 'PSA');
insert into marci values (marci_seq.nextval, 'DS Automobiles', 'PSA');
insert into marci values (marci_seq.nextval, 'Rolls-Royce', 'BMW Group');
insert into marci values (marci_seq.nextval, 'BMW', 'BMW Group');
insert into marci values (marci_seq.nextval, 'MINI', 'BMW Group');
insert into marci values (marci_seq.nextval, 'Geely', 'Geely');
insert into marci values (marci_seq.nextval, 'Volvo', 'Geely');
insert into marci values (marci_seq.nextval, 'The London Taxi Company', 'Geely');
insert into marci values (marci_seq.nextval, 'Infiniti', 'Nissan');
insert into marci values (marci_seq.nextval, 'Datsun', 'Nissan');
insert into marci values (marci_seq.nextval, 'Nissan', 'Nissan');
insert into marci values (marci_seq.nextval, 'Volkswagen', 'Volkswagen');
insert into marci values (marci_seq.nextval, 'Lamborghini', 'Volkswagen');
insert into marci values (marci_seq.nextval, 'Porsche', 'Volkswagen');
insert into marci values (marci_seq.nextval, 'Bentley', 'Volkswagen');
insert into marci values (marci_seq.nextval, 'Bugatti', 'Volkswagen');
insert into marci values (marci_seq.nextval, 'Skoda', 'Volkswagen');
insert into marci values (marci_seq.nextval, 'Seat', 'Volkswagen');
insert into marci values (marci_seq.nextval, 'Audi', 'Volkswagen');
insert into marci values (marci_seq.nextval, 'Hyundai', 'Hyundai');
insert into marci values (marci_seq.nextval, 'KIA', 'Hyundai');
insert into marci values (marci_seq.nextval, 'Buick', 'General Motors');
insert into marci values (marci_seq.nextval, 'Baojun', 'General Motors');
insert into marci values (marci_seq.nextval, 'Wuling Motors', 'General Motors');
insert into marci values (marci_seq.nextval, 'GMC', 'General Motors');
insert into marci values (marci_seq.nextval, 'Opel', 'General Motors');
insert into marci values (marci_seq.nextval, 'Cadillac', 'General Motors');
insert into marci values (marci_seq.nextval, 'Vauxhall', 'General Motors');
insert into marci values (marci_seq.nextval, 'Holden', 'General Motors');
insert into marci values (marci_seq.nextval, 'Chevrolet', 'General Motors');
insert into marci values (marci_seq.nextval, 'Renault', 'Renault');
insert into marci values (marci_seq.nextval, 'Dacia', 'Renault');
insert into marci values (marci_seq.nextval, 'Samsung', 'Renault');
insert into marci values (marci_seq.nextval, 'Jaguar', 'TATA');
insert into marci values (marci_seq.nextval, 'Land Rover', 'TATA');
insert into marci values (marci_seq.nextval, 'TATA Motors', 'TATA');
insert into marci values (marci_seq.nextval, 'Toyota', 'Toyota');
insert into marci values (marci_seq.nextval, 'Lexus', 'Toyota');
insert into marci values (marci_seq.nextval, 'Daihatsu', 'Toyota');
insert into marci values (marci_seq.nextval, 'Ford', 'Ford');
insert into marci values (marci_seq.nextval, 'The Lincoln Motor Company', 'Ford');
insert into marci values (marci_seq.nextval, 'Mercedes-Benz', 'Daimler');
insert into marci values (marci_seq.nextval, 'Smart', 'Daimler');
insert into marci values (marci_seq.nextval, 'FIAT', 'FCA');
insert into marci values (marci_seq.nextval, 'Maserati', 'FCA');
insert into marci values (marci_seq.nextval, 'Alfa Romeo', 'FCA');
insert into marci values (marci_seq.nextval, 'Lancia', 'FCA');
insert into marci values (marci_seq.nextval, 'Chrysler', 'FCA');
insert into marci values (marci_seq.nextval, 'RAM', 'FCA');
insert into marci values (marci_seq.nextval, 'Jeep', 'FCA');
insert into marci values (marci_seq.nextval, 'Dodge', 'FCA');
insert into marci values (marci_seq.nextval, 'Suzuki', NULL);
insert into marci values (marci_seq.nextval, 'Kawasaki', 'Kawasaki Heavy Industries');
insert into marci values (marci_seq.nextval, 'KTM', 'KTM Group');
insert into marci values (marci_seq.nextval, 'Yamaha', 'Yamaha Corporation');
select * from marci;

-- INSERARE CATEGORII MOTO
create sequence cat_moto_seq start with 1 increment by 1;
insert into categ_moto values (cat_moto_seq.nextval, 'Naked');
insert into categ_moto values (cat_moto_seq.nextval, 'Cruiser');
insert into categ_moto values (cat_moto_seq.nextval, 'Chopper');
insert into categ_moto values (cat_moto_seq.nextval, 'Sport');
insert into categ_moto values (cat_moto_seq.nextval, 'Touring');
insert into categ_moto values (cat_moto_seq.nextval, 'Enduro');
insert into categ_moto values (cat_moto_seq.nextval, 'Enduro-touring');
insert into categ_moto values (cat_moto_seq.nextval, 'Cross');
insert into categ_moto values (cat_moto_seq.nextval, 'Dirt-track');
insert into categ_moto values (cat_moto_seq.nextval, 'Superbike');
insert into categ_moto values (cat_moto_seq.nextval, 'Supersport');
insert into categ_moto values (cat_moto_seq.nextval, 'Supermoto');
insert into categ_moto values (cat_moto_seq.nextval, 'Scuter');
insert into categ_moto values (cat_moto_seq.nextval, 'Moped');
select * from categ_moto;

-- INSERARE CATEGORII AUTO
create sequence cat_auto_seq start with 1 increment by 1;
insert into categ_auto values (cat_auto_seq.nextval, 'Masina de oras');
insert into categ_auto values (cat_auto_seq.nextval, 'Supermini');
insert into categ_auto values (cat_auto_seq.nextval, 'Hatchback');
insert into categ_auto values (cat_auto_seq.nextval, 'MPV');
insert into categ_auto values (cat_auto_seq.nextval, 'Sedan');
insert into categ_auto values (cat_auto_seq.nextval, 'Break');
insert into categ_auto values (cat_auto_seq.nextval, 'Coupe');
insert into categ_auto values (cat_auto_seq.nextval, 'Crossover');
insert into categ_auto values (cat_auto_seq.nextval, 'SUV');
insert into categ_auto values (cat_auto_seq.nextval, 'Cabriolet');
insert into categ_auto values (cat_auto_seq.nextval, 'Roadster');
insert into categ_auto values (cat_auto_seq.nextval, 'Limuzina');
insert into categ_auto values (cat_auto_seq.nextval, 'Pick-up');
select * from categ_auto;

-- INSERARE TARI
insert into tari values ('A', 'Austria');
insert into tari values ('B', 'Belgia');
insert into tari values ('BG', 'Bulgaria');
insert into tari values ('CY', 'Cipru');
insert into tari values ('DK', 'Danemarca');
insert into tari values ('EST', 'Estonia');
insert into tari values ('FIN', 'Finlanda');
insert into tari values ('F', 'Franta');
insert into tari values ('D', 'Germania');
insert into tari values ('HR', 'Croatia');
insert into tari values ('GR', 'Grecia');
insert into tari values ('IRL', 'Irlanda');
insert into tari values ('I', 'Italia');
insert into tari values ('LV', 'Letonia');
insert into tari values ('LT', 'Lituania');
insert into tari values ('L', 'Luxemburg');
insert into tari values ('M', 'Malta');
insert into tari values ('GB', 'Marea Britanie');
insert into tari values ('NL', 'Olanda');
insert into tari values ('PL', 'Polonia');
insert into tari values ('P', 'Portugalia');
insert into tari values ('CZ', 'Republica Ceha');
insert into tari values ('RO', 'Romania');
insert into tari values ('SK', 'Slovacia');
insert into tari values ('SLO', 'Slovenia');
insert into tari values ('E', 'Spania');
insert into tari values ('S', 'Suedia');
insert into tari values ('H', 'Ungaria');
insert into tari values ('USA', 'Statele Unite ale Americii');
select * from tari;

-- INSERARE JUDETE
insert into judete values ('AB', 'Alba', 'RO');
insert into judete values ('AR', 'Arad', 'RO');
insert into judete values ('AG', 'Arges', 'RO');
insert into judete values ('BC', 'Bacau', 'RO');
insert into judete values ('BH', 'Bihor', 'RO');
insert into judete values ('BN', 'Bistrita-Nasaud', 'RO');
insert into judete values ('BT', 'Botosani', 'RO');
insert into judete values ('BR', 'Braila', 'RO');
insert into judete values ('BV', 'Brasov', 'RO');
insert into judete values ('BZ', 'Buzau', 'RO');
insert into judete values ('CL', 'Calarasi', 'RO');
insert into judete values ('CS', 'Caras-Severin', 'RO');
insert into judete values ('CJ', 'Cluj', 'RO');
insert into judete values ('CT', 'Constanta', 'RO');
insert into judete values ('CV', 'Covasna', 'RO');
insert into judete values ('DB', 'Dambovita', 'RO');
insert into judete values ('DJ', 'Dolj', 'RO');
insert into judete values ('GL', 'Galati', 'RO');
insert into judete values ('GR', 'Giurgiu', 'RO');
insert into judete values ('GJ', 'Gorj', 'RO');
insert into judete values ('HR', 'Harghita', 'RO');
insert into judete values ('HD', 'Hunedoara', 'RO');
insert into judete values ('IL', 'Ialomita', 'RO');
insert into judete values ('IS', 'Iasi', 'RO');
insert into judete values ('IF', 'Ilfov', 'RO');
insert into judete values ('MM', 'Maramures', 'RO');
insert into judete values ('MH', 'Mehedinti', 'RO');
insert into judete values ('MS', 'Mures', 'RO');
insert into judete values ('NT', 'Neamt', 'RO');
insert into judete values ('OT', 'Olt', 'RO');
insert into judete values ('PH', 'Prahova', 'RO');
insert into judete values ('SJ', 'Salaj', 'RO');
insert into judete values ('SM', 'Satu Mare', 'RO');
insert into judete values ('SB', 'Sibiu', 'RO');
insert into judete values ('SV', 'Suceava', 'RO');
insert into judete values ('TR', 'Teleorman', 'RO');
insert into judete values ('TM', 'Timis', 'RO');
insert into judete values ('TL', 'Tulcea', 'RO');
insert into judete values ('VL', 'Valcea', 'RO');
insert into judete values ('VS', 'Vaslui', 'RO');
insert into judete values ('VN', 'Vrancea', 'RO');
insert into judete values ('B', 'Bucuresti', 'RO');
select * from judete;

-- INSERARE LOCATII
create sequence loc_seq start with 1 increment by 1;
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'AB', 'Alba Iulia', 'Strada Mihai Viteazu');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'AR', 'Arad', 'Bulevardul Revolu?iei');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'AG', 'Pite?ti', 'Bulevardul Republicii');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BC', 'Bac?u', 'Strada Mihail Kog?lniceanu');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BH', 'Oradea', 'Bulevardul Decebal');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BN', 'Bistri?a', 'Strada Nicolae Titulescu');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BR', 'Br?ila', 'Bulevardul Independen?ei');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BT', 'Boto?ani', 'Strada Mihai Eminescu');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BV', 'Bra?ov', 'Bulevardul Eroilor');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BZ', 'Buz?u', 'Strada Alexandru Vlahu??');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CS', 'Cara?-Severin', 'Bulevardul Revolu?iei');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CL', 'C?l?ra?i', 'Strada Mihai Eminescu');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CJ', 'Cluj-Napoca', 'Bulevardul 21 Decembrie 1989');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CT', 'Constan?a', 'Bulevardul Tomis');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CV', 'Covasna', 'Strada Libert??ii');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'DB', 'Dâmbovi?a', 'Bulevardul Regele Carol I');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'DJ', 'Dolj', 'Bulevardul Victoriei');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'GL', 'Gala?i', 'Bulevardul Dun?rii');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'GR', 'Giurgiu', 'Strada Alexandru Ioan Cuza');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'GJ', 'Gorj', 'Bulevardul 1 Decembrie 1918');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'HR', 'Harghita', 'Strada Libert??ii');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'HD', 'Hunedoara', 'Bulevardul Revolu?iei');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'IL', 'Ialomi?a', 'Bulevardul Independen?ei');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'IS', 'Ia?i', 'Bulevardul ?tefan cel Mare ?i Sfânt');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'IF', 'Ilfov', 'Bulevardul Eroilor');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'MM', 'Maramure?', 'Bulevardul Independen?ei');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'MH', 'Mehedin?i', 'Bulevardul Revolu?iei');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'MS', 'Mure?', 'Bulevardul 1 Decembrie 1918');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'NT', 'Neam?', 'Bulevardul Republicii');
insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'OT', 'Olt', 'Bulevardul Nicolae B?lcescu');
select * from locatii;

--              GAMA SUZUKI
-- INSERARE MOTOCICLETE
create SEQUENCE moto_seq start with 1 increment by 1;
insert into motociclete values(moto_seq.nextval, 56, 'Hayabusa', 11, to_date('2023-02-15', 'yyyy-mm-dd'), 87, 16990, 'RO', 1340, 4, 190, 150, 'constant mesh', 6, 264, 20, 800);
insert into motociclete values(moto_seq.nextval, 56, 'Katana', 11, to_date('2023-03-25', 'yyyy-mm-dd'), 71, 12290, 'RO', 999, 4, 152, 106, 'mecanic', 6, 215, 12, 825);
insert into motociclete values(moto_seq.nextval, 56, 'GSX-R125', 11, to_date('2023-01-30', 'yyyy-mm-dd'), 107, 4690, 'RO', 124, 1, 15, 11.5, 'mecanic', 6, 134, 11, 785);
insert into motociclete values(moto_seq.nextval, 56, 'GSX-S1000GT', 1, to_date('2022-12-21', 'yyyy-mm-dd'), 230, 12990, 'RO', 999, 4, 152, 106, 'constant mesh', 6, 226, 19, 810);
insert into motociclete values(moto_seq.nextval, 56, 'GSX-S1000', 1, to_date('2023-04-11', 'yyyy-mm-dd'), 190, 11590, 'RO', 999, 4, 152, 106, 'mecanic', 6, 214, 19, 810);
insert into motociclete values(moto_seq.nextval, 56, 'GSX-S950', 1, to_date('2023-05-01', 'yyyy-mm-dd'), 29, 9990, 'RO', 999, 4, 94, 92, 'mecanic', 6, 214, 19, 810);
insert into motociclete values(moto_seq.nextval, 56, 'GSX-8S', 1, to_date('2022-11-03', 'yyyy-mm-dd'), 528, 8890, 'RO', 776, 2, 83, 78, 'mecanic', 6, 202, 14, 810);
insert into motociclete values(moto_seq.nextval, 56, 'SV650X', 1, to_date('2023-01-16', 'yyyy-mm-dd'), 114, 7590, 'RO', 645, 2, 75, 64, 'mecanic', 6, 198, 15, 790);
insert into motociclete values(moto_seq.nextval, 56, 'SV650', 1, to_date('2021-06-09', 'yyyy-mm-dd'), 794, 6990, 'RO', 645, 2, 73, 64, 'mecanic', 6, 198, 15, 785);
insert into motociclete values(moto_seq.nextval, 56, 'GSX-S125', 1, to_date('2023-02-23', 'yyyy-mm-dd'), 79, 4390, 'RO', 124, 1, 15, 12, 'mecanic', 6, 133, 11, 785);
insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 1050DE', 7, to_date('2023-03-17', 'yyyy-mm-dd'), 538, 14990, 'RO', 1037, 2, 106, 101, 'mecanic', 6, 252, 20, 880);
insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 1050', 7, to_date('2023-01-29', 'yyyy-mm-dd'), 1078, 13990, 'RO', 1037, 2, 106, 101, 'mecanic', 6, 242, 20, 855);
insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 800DE', 7, to_date('2022-11-07', 'yyyy-mm-dd'), 472, 10990, 'RO', 776, 2, 83, 78, 'mecanic', 6, 230, 20, 855);
insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 650XT', 7, to_date('2022-08-23', 'yyyy-mm-dd'), 1108, 8890, 'RO', 645, 2, 70, 62, 'mecanic', 6, 216, 20, 835);
insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 650', 7, to_date('2021-05-30', 'yyyy-mm-dd'), 2890, 7990, 'RO', 645, 2, 70, 62, 'mecanic', 6, 213, 20, 835);
insert into motociclete values(moto_seq.nextval, 56, 'RM-Z450', 8, to_date('2023-03-26', 'yyyy-mm-dd'), 291, 7790, 'RO', 449, 1, 58, 50, 'mecanic', 5, 112, 6, 960);
insert into motociclete values(moto_seq.nextval, 56, 'RM-Z250', 8, to_date('2023-04-16', 'yyyy-mm-dd'), 320, 7290, 'RO', 249, 1, 42, 29, 'mecanic', 5, 106, 6, 955);
insert into motociclete values(moto_seq.nextval, 56, 'BURGMAN 400', 13, to_date('2021-09-30', 'yyyy-mm-dd'), 1004, 7990, 'RO', 400, 1, 31, 36, 'CVT', 1, 215, 14, 755);
insert into motociclete values(moto_seq.nextval, 56, 'BURGMAN 125', 13, to_date('2023-01-22', 'yyyy-mm-dd'), 152, 3290, 'RO', 124, 1, 8, 10, 'CVT', 1, 112, 6, 780);
insert into motociclete values(moto_seq.nextval, 56, 'AVENIS 125', 13, to_date('2023-04-16', 'yyyy-mm-dd'), 201, 2990, 'RO', 124, 1, 9, 10, 'CVT', 1, 107, 5, 780);
insert into motociclete values(moto_seq.nextval, 56, 'ADDRESS 125', 13, to_date('2022-09-23', 'yyyy-mm-dd'), 740, 2890, 'RO', 124, 1, 9, 10, 'CVT', 1, 105, 5, 770);
select * from motociclete;

-- INSERARE ACCESORII MOTO
create sequence acc_moto_seq start with 1 increment by 1;
insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);

insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);

insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'PLASA SUPORT OBIECTE', 23);
insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'PLASA SUPORT OBIECTE', 23);

insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);

insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
select * from accesorii_moto;

-- INSERARE MOTOARE AUTO
insert into motor_auto values('K6A', NULL, 'benzina', NULL, 658, 3, 63, 108);
insert into motor_auto values('K10B', NULL, 'benzina', NULL, 996, 3, 67, 90);
insert into motor_auto values('K10C', 'Boosterjet', 'benzina', NULL, 998, 3, 109, 170);
insert into motor_auto values('K10A', NULL, 'benzina', NULL, 996, 4, 99, 118);
insert into motor_auto values('K12A', NULL, 'benzina', NULL, 1172, 4, 68, 95);
insert into motor_auto values('K12B', 'Dualjet', 'benzina', NULL, 1242, 4, 91, 118);
insert into motor_auto values('K12C', 'Dualjet', 'benzina', NULL, 1242, 4, 90, 120);
insert into motor_auto values('K12D', 'Dualjet', 'benzina', 'Mild Hybrid 12V', 1197, 4, 83, 107);
insert into motor_auto values('K12M', 'Dualjet', 'benzina', NULL, 1197, 4, 86, 113);
insert into motor_auto values('K12N', 'Dualjet', 'benzina', NULL, 1197, 4, 89, 113);
insert into motor_auto values('K14B', 'E-Power EA14', 'benzina', NULL, 1372, 4, 95, 134);
insert into motor_auto values('K14C', 'Boosterjet', 'benzina', NULL, 1372, 4, 144, 230);
insert into motor_auto values('K14D', 'Boosterjet', 'benzina', 'Mild Hybrid 48V', 1372, 4, 127, 235);
insert into motor_auto values('K15B', NULL, 'benzina', NULL, 1462, 4, 105, 138);
insert into motor_auto values('K15B-C', NULL, 'benzina', NULL, 1462, 4, 96, 134);
insert into motor_auto values('K15C', NULL, 'benzina', 'Strong Hybrid 140V', 1462, 4, 102, 138);
insert into motor_auto values('2ZR-FXE', NULL, 'benzina', 'Full Hybrid', 1798, 4, 98, 142);
insert into motor_auto values('A25A-FXS', NULL, 'benzina', 'Plug-In Hybrid', 2487, 4, 136, 227);
select * from motor_auto;

-- INSERARE MASINI
create SEQUENCE auto_seq start with 1 increment by 1;
insert into masini values (auto_seq.nextval, 56, 'Ignis Cool', 9, to_date('2023-05-10', 'yyyy-mm-dd'), 1025, 14385, 'RO', 'K12D', 'manuala', 5, '2WD', 1330, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Ignis Passion', 9, to_date('2023-02-28', 'yyyy-mm-dd'), 908, 16070, 'DK', 'K12D', 'manuala', 5, '2WD', 1330, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Ignis Passion', 9, to_date('2022-09-29', 'yyyy-mm-dd'), 15067, 17410, 'HR', 'K12D', 'CVT', 1, '2WD', 1330, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Ignis Spirit', 9, to_date('2023-01-07', 'yyyy-mm-dd'), 7942, 17135, 'RO', 'K12D', 'manuala', 5, '2WD', 1330, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Ignis Spirit', 9, to_date('2023-03-17', 'yyyy-mm-dd'), 2345, 18424, 'F', 'K12D', 'CVT', 1, '2WD', 1330, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Ignis Passion', 9, to_date('2022-12-25', 'yyyy-mm-dd'), 1932, 17610, 'BG', 'K12D', 'manuala', 5, 'ALLGRIP', 1330, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Ignis Spirit', 9, to_date('2023-04-23', 'yyyy-mm-dd'), 509, 18410, 'RO', 'K12D', 'manuala', 5, 'ALLGRIP', 1330, 'Euro 6');

insert into masini values (auto_seq.nextval, 56, 'Swift Cool', 2, to_date('2023-05-04', 'yyyy-mm-dd'), 598, 14860, 'BG', 'K12D', 'manuala', 5, '2WB', 991, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Swift Passion', 2, to_date('2022-07-14', 'yyyy-mm-dd'), 23900, 16700, 'GB', 'K12D', 'CVT', 1, '2WB', 991, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Swift Spirit', 2, to_date('2023-01-31', 'yyyy-mm-dd'), 1191, 17540, 'S', 'K12D', 'manuala', 5, '2WB', 991, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Swift Spirit', 2, to_date('2021-02-15', 'yyyy-mm-dd'), 12155, 18435, 'RO', 'K12D', 'CVT', 1, '2WB', 991, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Swift Passion', 2, to_date('2018-10-22', 'yyyy-mm-dd'), 41519, 17540, 'SK', 'K12D', 'manuala', 5, '2WB', 991, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Swift Spirit', 2, to_date('2020-05-19', 'yyyy-mm-dd'), 26287, 19280, 'RO', 'K12D', 'manuala', 5, 'ALLGRIP', 991, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Swift Passion', 2, to_date('2021-01-11', 'yyyy-mm-dd'), 47637, 15890, 'RO', 'K12D', 'manuala', 5, '2WB', 991, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Swift Sport', 2, to_date('2022-03-29', 'yyyy-mm-dd'), 19971, 15890, 'SLO', 'K14D', 'manuala', 6, '2WB', 1021, 'Euro 6');

insert into masini values (auto_seq.nextval, 56, 'Vitara Cool', 9, to_date('2023-05-04', 'yyyy-mm-dd'), 7342, 19310, 'SLO', 'K14D', 'manuala', 6, '2WB', 1275, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Passion', 9, to_date('2022-09-06', 'yyyy-mm-dd'), 9927, 20970, 'P', 'K14D', 'manuala', 6, '2WB', 1275, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Spirit', 9, to_date('2020-03-15', 'yyyy-mm-dd'), 36643, 23630, 'I', 'K14D', 'manuala', 6, '2WB', 1275, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Luxus', 9, to_date('2021-03-31', 'yyyy-mm-dd'), 23601, 24330, 'S', 'K14D', 'manuala', 6, '2WB', 1275, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Passion', 9, to_date('2020-08-06', 'yyyy-mm-dd'), 44768, 23300, 'RO', 'K14D', 'manuala', 6, 'ALLGRIP', 1326, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Spirit', 9, to_date('2022-11-04', 'yyyy-mm-dd'), 3146, 25230, 'NL', 'K14D', 'manuala', 6, 'ALLGRIP', 1326, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Luxus', 9, to_date('2021-04-15', 'yyyy-mm-dd'), 25523, 25990, 'BG', 'K14D', 'manuala', 6, 'ALLGRIP', 1326, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Passion', 9, to_date('2023-02-26', 'yyyy-mm-dd'), 12922, 23630, 'D', 'K15C', 'AGS', 6, '2WB', 1268, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Luxus', 9, to_date('2021-07-04', 'yyyy-mm-dd'), 34577, 24330, 'CZ', 'K15C', 'AGS', 6, '2WB', 1268, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Passion', 9, to_date('2020-07-18', 'yyyy-mm-dd'), 41527, 23300, 'M', 'K15C', 'AGS', 6, 'ALLGRIP', 1338, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Vitara Luxus', 9, to_date('2022-06-06', 'yyyy-mm-dd'), 4530, 25230, 'RO', 'K15C', 'AGS', 6, 'ALLGRIP', 1338, 'Euro 6');
                  
insert into masini values (auto_seq.nextval, 56, 'S-Cross Cool', 9, to_date('2020-01-23', 'yyyy-mm-dd'), 40482, 21420, 'B', 'K14D', 'manuala', 6, '2WB', 1235, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Passion', 9, to_date('2020-09-30', 'yyyy-mm-dd'), 27449, 23830, 'A', 'K14D', 'manuala', 6, '2WB', 1235, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Spirit', 9, to_date('2020-11-28', 'yyyy-mm-dd'), 8907, 25920, 'BG', 'K14D', 'manuala', 6, '2WB', 1235, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Luxus', 9, to_date('2020-12-30', 'yyyy-mm-dd'), 23601, 26320, 'IRL', 'K14D', 'manuala', 6, '2WB', 1235, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Passion', 9, to_date('2021-10-02', 'yyyy-mm-dd'), 16993, 25130, 'RO', 'K14D', 'manuala', 6, 'ALLGRIP', 1305, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Spirit', 9, to_date('2022-10-08', 'yyyy-mm-dd'), 11233, 27330, 'H', 'K14D', 'manuala', 6, 'ALLGRIP', 1305, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Luxus', 9, to_date('2023-02-11', 'yyyy-mm-dd'), 7739, 27620, 'GR', 'K14D', 'manuala', 6, 'ALLGRIP', 1305, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Passion', 9, to_date('2022-12-29', 'yyyy-mm-dd'), 2027, 23630, 'HR', 'K15C', 'AGS', 6, '2WB', 1308, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Spirit', 9, to_date('2021-10-20', 'yyyy-mm-dd'), 17886, 24330, 'RO', 'K15C', 'AGS', 6, '2WB', 1308, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Luxus', 9, to_date('2021-01-19', 'yyyy-mm-dd'), 27475, 24330, 'F', 'K15C', 'AGS', 6, '2WB', 1308, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Passion', 9, to_date('2020-08-13', 'yyyy-mm-dd'), 20284, 23300, 'HR', 'K15C', 'AGS', 6, 'ALLGRIP', 1378, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Spirit', 9, to_date('2020-04-26', 'yyyy-mm-dd'), 32382, 23300, 'I', 'K15C', 'AGS', 6, 'ALLGRIP', 1378, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'S-Cross Luxus', 9, to_date('2020-03-01', 'yyyy-mm-dd'), 36080, 25230, 'FIN', 'K15C', 'AGS', 6, 'ALLGRIP', 1378, 'Euro 6');

insert into masini values (auto_seq.nextval, 56, 'Swace Passion', 6, to_date('2020-09-19', 'yyyy-mm-dd'), 39485, 26850, 'NL', '2ZR-FXE', 'CVT', 1, '2WB', 1420, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Swace Spirit', 6, to_date('2022-05-16', 'yyyy-mm-dd'), 9356, 30220, 'D', '2ZR-FXE', 'CVT', 1, '2WB', 1420, 'Euro 6');
insert into masini values (auto_seq.nextval, 56, 'Across Luxus', 9, to_date('2023-02-11', 'yyyy-mm-dd'), 2027, 56540, 'RO', 'A25A-FXS', 'E-CVT', 1, 'E-FOUR', 1420, 'Euro 6');
update masini set masa = 1940 where id_auto = 43;
select * from masini;

-- INSERARE ACCESORII AUTO
create sequence acc_auto_seq start with 1 increment by 1;
insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'SET FUMATORI', 125);
insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'SET FUMATORI', 125);

insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'ORNAMENT PRAGURI', 540);
insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'ORNAMENT PRAGURI', 540);

insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);

insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);

insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'SET PRIM AJUTOR', 104);
insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'SET PRIM AJUTOR', 104);

insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'SET COVORASE CAUCIUC', 365);
insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'SET COVORASE CAUCIUC', 365);
select * from accesorii_auto;


--              GAMA HONDA
-- INSERARE MOTOCICLETE
insert into motociclete values(moto_seq.nextval, 1, 'Africa Twin', 7, to_date('2023-02-15', 'yyyy-mm-dd'), 108, 15450, 'RO', 1084, 2, 102, 105, 'Multi-disc, umed cu slipper clutch', 6, 226, 19, 870);
insert into motociclete values(moto_seq.nextval, 1, 'CB 1000R', 1, to_date('2022-03-27', 'yyyy-mm-dd'), 709, 14250, 'RO', 998, 4, 146, 104, 'Multi-disc, umed', 6, 212, 16, 830);
insert into motociclete values(moto_seq.nextval, 1, 'CB 750(Hornet)', 1, to_date('2023-01-09', 'yyyy-mm-dd'), 358, 8550, 'RO', 755, 2, 92, 75, 'Multi-disc, umed, slipper clutch', 6, 190, 15, 795);
insert into motociclete values(moto_seq.nextval, 1, 'CB 650R(23YM)', 1, to_date('2021-11-15', 'yyyy-mm-dd'), 2714, 9150, 'RO', 649, 4, 95, 63, 'Multi-disc, umed', 6, 202, 15, 810);
insert into motociclete values(moto_seq.nextval, 1, 'CB 650R(23YM) - Black Edition', 1, to_date('2023-04-10', 'yyyy-mm-dd'), 235, 9450, 'RO', 649, 4, 95, 63, 'Multi-disc, umed', 6, 202, 15, 810);
insert into motociclete values(moto_seq.nextval, 1, 'CB 125F', 1, to_date('2022-11-23', 'yyyy-mm-dd'), 1006, 3650, 'RO', 124, 1, 11, 11, 'Multi-disc, umed', 5, 117, 11, 790);
insert into motociclete values(moto_seq.nextval, 1, 'Rebel 1100 T-MT', 3, to_date('2021-06-17', 'yyyy-mm-dd'), 3902, 12650, 'RO', 1084, 2, 87, 98, 'Multi-disc, umed', 6, 223, 14, 700);
insert into motociclete values(moto_seq.nextval, 1, 'Rebel 1100 MT', 3, to_date('2022-05-29', 'yyyy-mm-dd'), 1872, 11450, 'RO', 1084, 2, 87, 98, 'Multi-disc, umed', 6, 223, 14, 700);
insert into motociclete values(moto_seq.nextval, 1, 'Rebel 500(23YM)', 3, to_date('2023-05-20', 'yyyy-mm-dd'), 97, 7650, 'RO', 471, 2, 46, 43, 'Multi-disc, umed', 6, 191, 11, 690);
insert into motociclete values(moto_seq.nextval, 1, 'Rebel 500', 3, to_date('2021-01-13', 'yyyy-mm-dd'), 2904, 7350, 'RO', 471, 2, 46, 43, 'Multi-disc, umed', 6, 191, 11, 690);
insert into motociclete values(moto_seq.nextval, 1, 'CBR 1000RR-R Fireblade SP', 11, to_date('2022-05-18', 'yyyy-mm-dd'), 82510, 27250, 'RO', 999, 4, 218, 113, 'Multi-disc, umed, arc diafragma', 6, 201, 16, 830);
insert into motociclete values(moto_seq.nextval, 1, 'CBR 650R', 11, to_date('2021-12-10', 'yyyy-mm-dd'), 54230, 9750, 'RO', 649, 4, 96, 63, 'Multi-disc, umed', 6, 207, 15, 810);
insert into motociclete values(moto_seq.nextval, 1, 'CBR 500R', 11, to_date('2022-03-29', 'yyyy-mm-dd'), 23230, 7950, 'RO', 471, 2, 48, 43, 'Multi-disc, umed, cu alunecare asistata', 6, 192, 17, 785);
insert into motociclete values(moto_seq.nextval, 1, 'NT 1100 - MT', 5, to_date('2021-02-09', 'yyyy-mm-dd'), 40482, 14650, 'RO', 1084, 2, 102, 104, 'Automatic, multi-disc, umed, dublu ambreiaj', 6, 238, 20, 820);
insert into motociclete values(moto_seq.nextval, 1, 'Gold Wing (DCT)', 5, to_date('2020-04-17', 'yyyy-mm-dd'), 132830, 28850, 'RO', 1833, 6, 127, 170, 'Automatic, multi-disc, umed, dublu ambreiaj', 7, 367, 21, 745);
insert into motociclete values(moto_seq.nextval, 1, 'GL 1800 GoldWing', 5, to_date('2021-06-22', 'yyyy-mm-dd'), 99230, 36850, 'RO', 1833, 6, 127, 170, 'Automatic, multi-disc, umed, dublu ambreiaj', 7, 383, 21, 745);
insert into motociclete values(moto_seq.nextval, 1, 'SH Mode 125', 13, to_date('2023-02-26', 'yyyy-mm-dd'), 99230, 1056, 'RO', 125, 1, 11, 12, 'Automatic, centrifugal', 1, 118, 6, 765);
insert into motociclete values(moto_seq.nextval, 1, 'Forza 350', 13, to_date('2020-08-30', 'yyyy-mm-dd'), 101890, 7150, 'RO', 330, 1, 29, 32, 'Automatic, centrifugal', 1, 184, 12, 780);
insert into motociclete values(moto_seq.nextval, 1, 'Forza 750', 13, to_date('2021-08-30', 'yyyy-mm-dd'), 57025, 11950, 'RO', 745, 2, 59, 69, 'Automatic, dublu disc, umed, hidraulic', 6, 235, 13, 790);

-- INSERARE ACCESORII MOTO
insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'SEZUT PIELE NEAGRA CUSTOM', 430);
insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'SET TANK PADS', 270);
insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'SET GENTI PIELE', 2535);
insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'PORTBAGAJ', 1378);
insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'SPATAR PASAGER', 776);
insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'SPATAR PASAGER', 776);

-- INSERARE MOTOARE AUTO
insert into motor_auto values('K20C', 'Earth Dreams VTEC Turbo', 'benzina', NULL, 1996, 4, 320, 420);
insert into motor_auto values('LFC-H4', NULL, 'benzina', 'Full Hybrid - e:HEV', 1993, 4, 184, 315);
insert into motor_auto values('L15C1', NULL, 'benzina', 'Full Hybrid - e:HEV', 1497, 4, 175, 240);
insert into motor_auto values('LEB8', 'Earth Dreams i-VTEC', 'benzina', 'Full Hybrid - e:HEV', 1497, 4, 122, 253);

-- INSERARE MASINI
insert into masini values (auto_seq.nextval, 1, 'Jazz Sport Advance', 1, to_date('2022-11-11', 'yyyy-mm-dd'), 75230, 29440, 'RO', 'LEB8', 'CVT i-MMD', 1, 'FWD', 1244, 'Euro 6');
insert into masini values (auto_seq.nextval, 1, 'HR-V Advance', 9, to_date('2021-07-27', 'yyyy-mm-dd'), 82331, 35040, 'RO', 'L15C1', 'CVT', 1, 'FWD', 1401, 'Euro 6');
insert into masini values (auto_seq.nextval, 1, 'HR-V Advance Style', 9, to_date('2022-09-12', 'yyyy-mm-dd'), 62351, 37540, 'RO', 'L15C1', 'CVT', 1, 'FWD', 1401, 'Euro 6');
insert into masini values (auto_seq.nextval, 1, 'CR-V Elegance', 9, to_date('2020-02-19', 'yyyy-mm-dd'), 139051, 40500, 'RO', 'LFC-H4', 'CVT', 1, 'FWD', 1657, 'Euro 6');
insert into masini values (auto_seq.nextval, 1, 'CR-V Executive', 9, to_date('2023-01-28', 'yyyy-mm-dd'), 13051, 47150, 'RO', 'LFC-H4', 'CVT', 1, 'AWD', 1726, 'Euro 6');
insert into masini values (auto_seq.nextval, 1, 'Civic Advance', 3, to_date('2022-08-20', 'yyyy-mm-dd'), 29347, 39490, 'RO', 'LFC-H4', 'CVT', 1, 'FWD', 1533, 'Euro 6');
insert into masini values (auto_seq.nextval, 1, 'Civic Type R', 3, to_date('2021-03-17', 'yyyy-mm-dd'), 47230, 44890, 'RO', 'K20C', 'manuala', 6, 'FWD', 1429, 'Euro 6');

-- INSERARE ACCESORII AUTO
insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'PRELATA', 1090);
insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'PRELATA', 1090);
insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'PRELATA', 1090);
insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'PRELATA', 1090);
insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'PRELATA', 1090);
insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'PRELATA', 1090);
insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'PRELATA', 1090);
insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'SET PROTECTII NOROI', 238);
insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'SET PROTECTII NOROI', 238);
insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'SET PROTECTII NOROI', 238);
insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'SET PROTECTII NOROI', 238);
insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'SET PROTECTII NOROI', 238);
insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'SET PROTECTII NOROI', 238);
insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'SET PROTECTII NOROI', 238);
insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'PRELATA PARBRIZ', 590);
insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'PRELATA PARBRIZ', 590);
insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'PRELATA PARBRIZ', 590);
insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'PRELATA PARBRIZ', 590);
insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'PRELATA PARBRIZ', 590);
insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'PRELATA PARBRIZ', 590);
insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'PRELATA PARBRIZ', 590);
insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'LUMINI AMBIENTALE', 9750);
insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'LUMINI AMBIENTALE', 9750);
insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'LUMINI AMBIENTALE', 9750);
insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'LUMINI AMBIENTALE', 9750);
insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'LUMINI AMBIENTALE', 9750);
insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'LUMINI AMBIENTALE', 9750);
insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'LUMINI AMBIENTALE', 9750);
insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'PACHET CARGO', 537);
insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'PACHET CARGO', 537);
insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'PACHET CARGO', 537);
insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'PACHET CARGO', 537);
insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'PACHET CARGO', 537);
insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'PACHET CARGO', 537);
insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'PACHET CARGO', 537);
insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'COVORASE ELEGANCE', 440);
insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'COVORASE ELEGANCE', 440);
insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'COVORASE ELEGANCE', 440);
insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'COVORASE ELEGANCE', 440);
insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'COVORASE ELEGANCE', 440);
insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'COVORASE ELEGANCE', 440);
insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'COVORASE ELEGANCE', 440);
insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'SUPORT SKI SI SNOWBOARD', 1045);
insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'SUPORT SKI SI SNOWBOARD', 1045);
insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'SUPORT SKI SI SNOWBOARD', 1045);
insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'SUPORT SKI SI SNOWBOARD', 1045);
insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'SUPORT SKI SI SNOWBOARD', 1045);
insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'SUPORT SKI SI SNOWBOARD', 1045);
insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'SUPORT SKI SI SNOWBOARD', 1045);


-- INSERARE INREGISTRARI SERVICE AUTO
create sequence isa_seq start with 1 increment by 1;
insert into inreg_service_auto
    select isa_seq.nextval, id_auto, current_date, 'Schimb ulei, filtru ulei, filtru aer'
    from masini
    where nr_km >= 1000;
insert into inreg_service_auto
    select isa_seq.nextval, id_auto, current_date, 'Schimb distributie'
    from masini
    where nr_km >= 60000;
insert into inreg_service_auto
    select isa_seq.nextval, id_auto, to_date(data_fabricatie + INTERVAL '30' month ), 'Schimb parbriz'
    from masini 
    where to_char(data_fabricatie, 'MM') = 05;
insert into inreg_service_auto
    select isa_seq.nextval, id_auto, to_date(data_fabricatie + INTERVAL '5' month ), 'Geometrie roti'
    from masini 
    where to_char(data_fabricatie, 'MM') = 03;
select * from inreg_service_auto;

-- INSERARE INREGISTRARI SERVICE MOTO
create sequence ism_seq start with 1 increment by 1;
insert into inreg_service_moto
    select ism_seq.nextval, id_moto, to_date(data_fabricatie + INTERVAL '5' month ), 'Servisare telescoape'
    from motociclete
    where to_char(data_fabricatie, 'YYYY') < 2021;
insert into inreg_service_moto
    select ism_seq.nextval, id_moto, current_date, 'Schimb ulei, filtru ulei, filtru aer'
    from motociclete
    where nr_km >= 5000;
insert into inreg_service_moto
    select ism_seq.nextval, id_moto, to_date(data_fabricatie + INTERVAL '1' year ), 'Schimb placute frana + lichid frana'
    from motociclete
    where to_char(data_fabricatie, 'YYYY') < 2023 and to_char(data_fabricatie, 'MM') = 01;
insert into inreg_service_moto
    select ism_seq.nextval, id_moto, to_date(data_fabricatie + INTERVAL '1' year ), 'Segmentare motor'
    from motociclete
    where to_char(data_fabricatie, 'dd') = 30;
select * from inreg_service_moto;


-- INSERARE CLIENTI
create sequence li_seq start with 1 increment by 1;
create sequence cl_seq start with 1 increment by 1;
create sequence aux start with 3 increment by 1;
insert into login_info values (li_seq.nextval, 'ion.popescu@email.com', 'ion.popescu1985', 'Parola1234!');
insert into clienti values (cl_seq.nextval, 'Ion', 'Popescu', '+40711223344', li_seq.currval, 1);
insert into login_info values (li_seq.nextval, 'maria.ionescu@email.com', 'maria.ionescu1990', 'Parola5678@');
insert into clienti values (cl_seq.nextval, 'Maria', 'Ionescu', '+40722334455', li_seq.currval, 2);
insert into login_info values (li_seq.nextval, 'andrei.popa@email.com', 'andrei.popa1987', 'Parola!9876');
insert into clienti values (cl_seq.nextval, 'Andrei', 'Popa', '+40733445566', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'elena.vasilescu@email.com', 'elena.vasilescu1992', 'Parola4321#');
insert into clienti values (cl_seq.nextval, 'Elena', 'Vasilescu', '+40744556677', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'adrian.radu@email.com', 'adrian.radu1983', 'Parola@2468');
insert into clienti values (cl_seq.nextval, 'Adrian', 'Radu', '+40755667788', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'ana.stanescu@email.com', 'ana.stanescu1995', 'Parola987!' );
insert into clienti values (cl_seq.nextval, 'Ana', 'Stanescu', '+40766778899', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'cristian.dumitru@email.com', 'cristian.dumitru1988', 'Parola654@#' );
insert into clienti values (cl_seq.nextval, 'Cristian', 'Dumitru', '+40777889900', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'laura.georgescu@email.com', 'laura.georgescu1991', 'Parola123@abc' );
insert into clienti values (cl_seq.nextval, 'Laura', 'Georgescu', '+40788990011', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'florin.munteanu@email.com', 'florin.munteanu1986', 'Parolaabc123#' );
insert into clienti values (cl_seq.nextval, 'Florin', 'Munteanu', '+40799001122', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'gabriela.radulescu@email.com', 'gabriela.radulescu1993', 'Parola!4567@' );
insert into clienti values (cl_seq.nextval, 'Gabriela', 'Radulescu', '+40771234567', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'mihai.popovici@email.com', 'mihai.popovici1984', 'Parola789@xyz' );
insert into clienti values (cl_seq.nextval, 'Mihai', 'Popovici', '+40782345678', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'ioana.gheorghe@email.com', 'ioana.gheorghe1997', 'ParolaXYZ!789' );
insert into clienti values (cl_seq.nextval, 'Ioana', 'Gheorghe', '+40793456789', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'stefan.marinescu@email.com', 'stefan.marinescu1989', 'Parola9876@XYZ' );
insert into clienti values (cl_seq.nextval, 'Stefan', 'Marinescu', '+40704567890', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'mihaela.constantinescu@email.com', 'mihaelaconstantinescu1994', 'ParolaXYZ@9876' );
insert into clienti values (cl_seq.nextval, 'Mihaela', 'Constantinescu', '+40715678901', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'alexandru.stoica@email.com', 'alexandru.stoica1982', 'Parola123XYZ@' );
insert into clienti values (cl_seq.nextval, 'Alexandru', 'Stoica', '+40726789012', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'diana.barbu@email.com', 'diana.barbu1996', 'ParolaXYZ!123' );
insert into clienti values (cl_seq.nextval, 'Diana', 'Barbu', '+40737890123', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'robert.chiriac@email.com', 'robert.chiriac1987', 'Parola!XYZ123' );
insert into clienti values (cl_seq.nextval, 'Robert', 'Chiriac', '+40748901234', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'raluca.mihai@email.com', 'raluca.mihai1990', 'Parola123@XYZ' );
insert into clienti values (cl_seq.nextval, 'Raluca', 'Mihai', '+40759012345', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'daniel.iancu@email.com', 'daniel.iancu1985', 'Parola!XYZ1234' );
insert into clienti values (cl_seq.nextval, 'Daniel', 'Iancu', '+40760123456', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'alina.neagu@email.com', 'alina.neagu1992', 'Parola1234@XYZ' );
insert into clienti values (cl_seq.nextval, 'Alina', 'Neagu', '+40771234567', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'marius.constantin@email.com', 'marius.constantin1986', 'Parola789@xyz' );
insert into clienti values (cl_seq.nextval, 'Marius', 'Constantin', '+40782345678', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'simona.radulescu@email.com', 'simona.radulescu1997', 'ParolaXYZ!789' );
insert into clienti values (cl_seq.nextval, 'Simona', 'Radulescu', '+40793456789', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'gabriel.marin@email.com', 'gabriel.marin1989', 'Parola9876@XYZ' );
insert into clienti values (cl_seq.nextval, 'Gabriel', 'Marin', '+40704567890', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'carmen.stoian@email.com', 'carmen.stoian1994', 'ParolaXYZ@9876' );
insert into clienti values (cl_seq.nextval, 'Carmen', 'Stoian', '+40715678901', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'ionut.gavril1982@email.com', 'ionut.gavril1982', 'Parola123XYZ@' );
insert into clienti values (cl_seq.nextval, 'Ionut', 'Gavril', '+40726789012', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'loredana.badea1995@email.com', 'loredana.badea1995', 'ParolaXYZ!123' );
insert into clienti values (cl_seq.nextval, 'Loredana', 'Badea', '+40737890123', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'bogdan.radulescu1988@email.com', 'bogdan.radulescu1988', 'Parola!XYZ123' );
insert into clienti values (cl_seq.nextval, 'Bogdan', 'Radulescu', '+40748901234', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'iulia.enache1991@email.com', 'iulia.enache1991', 'Parola123@XYZ' );
insert into clienti values (cl_seq.nextval, 'Iulia', 'Enache', '+40759012345', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'adrian.ciobanu1986@email.com', 'adrian.ciobanu1986', 'Parola!XYZ1234' );
insert into clienti values (cl_seq.nextval, 'Adrian', 'Ciobanu', '+40760123456', li_seq.currval, aux.nextval);
insert into login_info values (li_seq.nextval, 'daniela.popa1994@email.com', 'daniela.popa1994', 'Parola1234@XYZ' );
insert into clienti values (cl_seq.nextval, 'Daniela', 'Popa', '+40771234567', li_seq.currval, aux.nextval);
select * from clienti;

-- INSERARE ANGAJATI
create sequence ang_seq start with 1 increment by 1;
insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'alex93', 'Parola123!', 'alex93@email.com'); 
insert into angajati values (ang_seq.nextval, 'Alexandrescu', 'Alex', '+40711223344', 2500, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'maria22', 'Parola!456', 'maria22@email.com'); 
insert into angajati values (ang_seq.nextval, 'Popescu', 'Maria', '+40722334455', 3500, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (ang_seq.nextval,'andrei87', 'ParolaXYZ123', 'andrei87@email.com'); 
insert into angajati values (ang_seq.nextval, 'Ionescu', 'Andrei', '+40733445566', 2800, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (ang_seq.nextval,'elena99', 'Parola@789', 'elena99@email.com'); 
insert into angajati values (ang_seq.nextval, 'Radu', 'Elena', '+40744556677', 3200, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (ang_seq.nextval,'mihai76', 'Parola!XYZ123', 'mihai76@email.com'); 
insert into angajati values (ang_seq.nextval, 'Constantin', 'Mihai', '+40755667788', 3000, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (ang_seq.nextval,'alexandra01', 'ParolaXYZ!789', 'alexandra01@email.com'); 
insert into angajati values (ang_seq.nextval, 'Popa', 'Alexandra', '+40766778899', 2800, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (ang_seq.nextval,'cristian82', 'Parola123XYZ@', 'cristian82@email.com'); 
insert into angajati values (ang_seq.nextval, 'Mihai', 'Cristian', '+40777889900', 3200, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (ang_seq.nextval,'laura10', 'Parola!9876@', 'laura10@email.com'); 
insert into angajati values (ang_seq.nextval, 'Andrei', 'Laura', '+40788990011', 3000, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (ang_seq.nextval,'ionut94', 'ParolaXYZ!123', 'ionut94@email.com'); 
insert into angajati values (ang_seq.nextval, 'Popescu', 'Ionut', '+40799001122', 2500, li_seq.currval, aux.nextval);
insert into login_info(id_login, username, parola, email) values (ang_seq.nextval,'ana88', 'Parola123@XYZ', 'ana88@email.com'); 
insert into angajati values (ang_seq.nextval, 'Andrei', 'Ana', '+40770112233', 3500, li_seq.currval, aux.nextval);
select * from angajati;
select * from login_info;

-- INSERARE VANZARI
create sequence vnz_seq start with 1 increment by 1;
insert into vanzari values (vnz_seq.nextval, 33, 1, current_date, 17540);
insert into vanzari values (vnz_seq.nextval, 36, 3, current_date, 38920);
insert into vanzari values (vnz_seq.nextval, 57, 6, current_date, 37625);
insert into vanzari values (vnz_seq.nextval, 65, 9, current_date, 119760);
insert into vanzari values (vnz_seq.nextval, 42, 2, current_date, 31740);
insert into vanzari values (vnz_seq.nextval, 55, 5, current_date, 44300);
insert into vanzari values (vnz_seq.nextval, 35, 8, current_date, 44890);
insert into vanzari values (vnz_seq.nextval, 62, 11, current_date, 1056);
insert into vanzari values (vnz_seq.nextval, 60, 3, current_date, 36850);
insert into vanzari values (vnz_seq.nextval, 33, 7, current_date, 79990);
insert into vanzari values (vnz_seq.nextval, 50, 4, current_date, 28400);
select * from vanzari;

-- INSERARE VANZARI AUTO
insert into v_auto values (2, 32);
insert into v_auto values (3, 1);
insert into v_auto values (4, 65); 
insert into v_auto values (4, 2);
insert into v_auto values (4, 43);
insert into v_auto values (6, 8);
insert into v_auto values (6, 61);
insert into v_auto values (7, 67);
insert into v_auto values (10, 66);
insert into v_auto values (10, 64);
insert into v_auto values (11, 7);
select * from v_auto;

-- INSERARE VANZARI MOTO
insert into v_moto values (1, 12);
insert into v_moto values (2,6);
insert into v_moto values (3, 17);
insert into v_moto values (3,42);
insert into v_moto values (5, 22);
insert into v_moto values (5, 80);
insert into v_moto values (8, 76);
insert into v_moto values (9, 75);
insert into v_moto values (11, 7);
select * from v_moto;      
               
commit;
select * from masini;
select sysdate from dual;
                        
select * from user_sequences;

                        -- CREARE TABELE

-- create table marci (id_marca NUMBER(3, 0),
--                     denumire varchar2(30) not null,
--                     grup varchar2(30), 
--                     constraint brand_pk primary key (id_marca),
--                     CONSTRAINT unq_brand UNIQUE (denumire)
--                     ); 
-- describe marci;
         
-- create table categ_auto (id_categ number(2, 0), 
--                         denumire VARCHAR2(30) not null,
--                         constraint cat_auto_pk primary key(id_categ),
--                         constraint unq_categ_auto unique (denumire)
--                         );
-- describe categ_auto;

-- create table categ_moto (id_categ number(2, 0), 
--                         denumire VARCHAR2(30) not null,
--                         constraint cat_moto_pk primary key(id_categ),
--                         constraint unq_categ_moto unique (denumire)
--                         );
-- describe categ_moto;

-- create table motor_auto (id_motor varchar2(20),
--                         denumire varchar2(30),
--                         combustibil varchar2(20) not null,
--                         hybrid varchar2(20),
--                         capac_cil NUMBER(5, 0),
--                         nr_cil NUMBER(2, 0),
--                         putere NUMBER(5, 0) not null,
--                         cuplu_max NUMBER(5, 0) not null, 
--                         constraint eng_auto_pk primary key(id_motor)
--                         );
-- describe motor_auto;
                        
-- create table tari (id_tara varchar2(3),
--                     denumire varchar2(30) not null,
--                     constraint tara_pk primary key(id_tara)
--                     );
-- describe tari;

-- create table judete (id_judet varchar(2),
--                     denumire varchar2(30) not null,
--                     id_tara varchar2(3),
--                     constraint judet_pk primary key(id_judet),
--                     constraint judet_tara_fk FOREIGN key (id_tara) references tari(id_tara)
--                     );
-- describe judete;
                    
-- create table locatii (id_locatie number(4,0),
--                         strada varchar2(100),
--                         localitate varchar2(30),
--                         id_judet varchar(2),
--                         constraint locatie_pk primary key(id_locatie),
--                         constraint locatie_judet_fk foreign key (id_judet) references judete(id_judet)
--                         );
-- describe locatii;
                    
-- create table motociclete ( id_moto number(5, 0),
--                             id_marca number(3, 0),
--                             model varchar2(30) not null,
--                             id_categ number(2, 0),
--                             data_fabricatie date,
--                             nr_km number(8, 2) not null,
--                             pret number(6, 0) not null,
--                             id_tara_provenienta varchar2(3),
--                             capac_cil NUMBER(5, 0) not null,
--                             nr_cil NUMBER(2, 0),
--                             putere NUMBER(5, 0) not null,
--                             cuplu_max NUMBER(6, 2),
--                             cutie_vit varchar2(50),
--                             nr_trepte number(2, 0),
--                             masa number(7, 2),
--                             capac_rezervor number(3),
--                             inaltime_sa number(3, 0),
--                             constraint moto_pk primary key(id_moto),
--                             constraint moto_marca_fk foreign key(id_marca) references marci(id_marca),
--                             constraint moto_categ_moto_fk foreign key(id_categ) references categ_moto(id_categ),
--                             constraint moto_tara_fk foreign key(id_tara_provenienta) references tari(id_tara)
--                             );
-- describe motociclete;
                            
-- create table masini ( id_auto number(5, 0),
--                     id_marca number(3, 0),
--                     model varchar2(30) not null,
--                     id_categ number(2, 0),
--                     data_fabricatie date,
--                     nr_km number(8, 2) not null,
--                     pret number(7, 0) not null,
--                     id_tara_provenienta varchar2(3),
--                     id_motor varchar2(20) not null,
--                     cutie_vit varchar2(20),
--                     nr_trepte number(2, 0),
--                     tractiune varchar2(20),
--                     masa number(6),
--                     norma_poluare varchar2(7),
--                     constraint auto_pk primary key(id_auto),
--                     constraint auto_marca_fk foreign key(id_marca) references marci(id_marca),
--                     constraint auto_categ_auto_fk foreign key(id_categ) references categ_auto(id_categ),
--                     constraint auto_tara_fk foreign key(id_tara_provenienta) references tari(id_tara),
--                     constraint auto_motor_fk foreign key(id_motor) references motor_auto(id_motor)
--                     );
-- describe masini;
                            
-- create table accesorii_auto(id_accesoriu number(10, 0),
--                             id_auto number(5, 0),
--                             denumire varchar2(100),
--                             pret number(6, 2) not null,
--                             constraint acc_a_pk primary key(id_accesoriu),
--                             constraint acc_a_auto_fk foreign key(id_auto) REFERENCES masini(id_auto)
--                             );
-- describe accesorii_auto;
                            
-- create table inreg_service_auto (id_service number(5, 0),
--                                 id_auto number(5, 0),
--                                 data_service date,
--                                 descriere varchar2(300),
--                                 constraint isa_pk primary key(id_service),
--                                 constraint isa_auto_fk foreign key(id_auto) references masini(id_auto)
--                                 );
-- describe inreg_service_auto;
                                
-- create table accesorii_moto(id_accesoriu number(10, 0),
--                             id_moto number(5, 0),
--                             denumire varchar2(100),
--                             pret number(6, 2) not null,
--                             constraint acc_m_pk primary key(id_accesoriu),
--                             constraint acc_m_moto_fk foreign key(id_moto) REFERENCES motociclete(id_moto)
--                             );
-- describe accesorii_moto;
                            
-- create table inreg_service_moto (id_service number(5, 0),
--                                 id_moto number(5, 0),
--                                 data_service date,
--                                 descriere varchar2(300),
--                                 constraint ism_pk primary key(id_service),
--                                 constraint ism_auto_fk foreign key(id_moto) references motociclete(id_moto)
--                                 );
-- describe inreg_service_moto;
                                
-- create table login_info (id_login number(10, 0),
--                         email varchar2(50) not null,
--                         username varchar2(25) not null,
--                         parola varchar2(50) not null,
--                         constraint li_pk primary key(id_login)
--                         );
-- describe login_info;
                        
-- create table clienti (id_client number(7, 0),
--                         nume varchar2(20) not null,
--                         prenume varchar2(25) not null,
--                         telefon varchar2(20),
--                         id_login number(10, 0),
--                         id_locatie number(4, 0),
--                         constraint cl_pk primary key(id_client),
--                         constraint cl_li_fk foreign key(id_login) references login_info(id_login),
--                         constraint cl_loc_fk foreign key(id_locatie) references locatii(id_locatie)
--                         );
-- describe clienti;
                        
-- create table angajati (id_angajat number(7, 0),
--                         nume varchar2(20) not null,
--                         prenume varchar2(25) not null,
--                         telefon varchar2(20),
--                         salariu number(7, 0) not null,
--                         id_login number(10, 0),
--                         id_locatie number(4, 0),
--                         constraint ang_pk primary key(id_angajat),
--                         constraint ang_li_fk foreign key(id_login) references login_info(id_login),
--                         constraint ang_loc_fk foreign key(id_locatie) references locatii(id_locatie)
--                         );
-- describe angajati;
                        
-- create table vanzari (id_vanzare number(7, 0),
--                         id_client number(7, 0),
--                         id_angajat number(7, 0),
--                         data_vanzare date not null,
--                         suma_totala number(10, 0) not null,
--                         constraint vnz_pk primary key(id_vanzare),
--                         constraint vnz_cl_fk foreign key(id_client) references clienti(id_client),
--                         constraint vnz_ang_fk foreign key(id_angajat) references angajati(id_angajat)
--                         );
-- describe vanzari;
                        
-- create table v_auto (id_vanzare number(7, 0),
--                         id_auto number(5, 0),
--                         constraint v_a_vnz_fk foreign key(id_vanzare) references vanzari(id_vanzare),
--                         constraint v_a_auto_fk foreign key(id_auto) references masini(id_auto),
--                         constraint v_a_pk primary key(id_vanzare, id_auto)
--                         ); 
-- describe v_auto;
                        
-- create table v_moto (id_vanzare number(7, 0),
--                         id_moto number(5, 0),
--                         constraint v_m_vnz_fk foreign key(id_vanzare) references vanzari(id_vanzare),
--                         constraint v_m_moto_fk foreign key(id_moto) references motociclete(id_moto),
--                         constraint v_m_pk primary key(id_vanzare, id_moto)
--                         );
-- describe v_moto;                                             

                            -- INSERARE DATE

-- INSERARE MARCI
-- create sequence marci_seq start with 1 increment by 1;
-- insert into marci values (marci_seq.nextval, 'Honda', 'Honda');
-- insert into marci values (marci_seq.nextval, 'Acura', 'Honda');
-- insert into marci values (marci_seq.nextval, 'Citroen', 'PSA');
-- insert into marci values (marci_seq.nextval, 'Peugeot', 'PSA');
-- insert into marci values (marci_seq.nextval, 'DS Automobiles', 'PSA');
-- insert into marci values (marci_seq.nextval, 'Rolls-Royce', 'BMW Group');
-- insert into marci values (marci_seq.nextval, 'BMW', 'BMW Group');
-- insert into marci values (marci_seq.nextval, 'MINI', 'BMW Group');
-- insert into marci values (marci_seq.nextval, 'Geely', 'Geely');
-- insert into marci values (marci_seq.nextval, 'Volvo', 'Geely');
-- insert into marci values (marci_seq.nextval, 'The London Taxi Company', 'Geely');
-- insert into marci values (marci_seq.nextval, 'Infiniti', 'Nissan');
-- insert into marci values (marci_seq.nextval, 'Datsun', 'Nissan');
-- insert into marci values (marci_seq.nextval, 'Nissan', 'Nissan');
-- insert into marci values (marci_seq.nextval, 'Volkswagen', 'Volkswagen');
-- insert into marci values (marci_seq.nextval, 'Lamborghini', 'Volkswagen');
-- insert into marci values (marci_seq.nextval, 'Porsche', 'Volkswagen');
-- insert into marci values (marci_seq.nextval, 'Bentley', 'Volkswagen');
-- insert into marci values (marci_seq.nextval, 'Bugatti', 'Volkswagen');
-- insert into marci values (marci_seq.nextval, 'Skoda', 'Volkswagen');
-- insert into marci values (marci_seq.nextval, 'Seat', 'Volkswagen');
-- insert into marci values (marci_seq.nextval, 'Audi', 'Volkswagen');
-- insert into marci values (marci_seq.nextval, 'Hyundai', 'Hyundai');
-- insert into marci values (marci_seq.nextval, 'KIA', 'Hyundai');
-- insert into marci values (marci_seq.nextval, 'Buick', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'Baojun', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'Wuling Motors', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'GMC', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'Opel', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'Cadillac', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'Vauxhall', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'Holden', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'Chevrolet', 'General Motors');
-- insert into marci values (marci_seq.nextval, 'Renault', 'Renault');
-- insert into marci values (marci_seq.nextval, 'Dacia', 'Renault');
-- insert into marci values (marci_seq.nextval, 'Samsung', 'Renault');
-- insert into marci values (marci_seq.nextval, 'Jaguar', 'TATA');
-- insert into marci values (marci_seq.nextval, 'Land Rover', 'TATA');
-- insert into marci values (marci_seq.nextval, 'TATA Motors', 'TATA');
-- insert into marci values (marci_seq.nextval, 'Toyota', 'Toyota');
-- insert into marci values (marci_seq.nextval, 'Lexus', 'Toyota');
-- insert into marci values (marci_seq.nextval, 'Daihatsu', 'Toyota');
-- insert into marci values (marci_seq.nextval, 'Ford', 'Ford');
-- insert into marci values (marci_seq.nextval, 'The Lincoln Motor Company', 'Ford');
-- insert into marci values (marci_seq.nextval, 'Mercedes-Benz', 'Daimler');
-- insert into marci values (marci_seq.nextval, 'Smart', 'Daimler');
-- insert into marci values (marci_seq.nextval, 'FIAT', 'FCA');
-- insert into marci values (marci_seq.nextval, 'Maserati', 'FCA');
-- insert into marci values (marci_seq.nextval, 'Alfa Romeo', 'FCA');
-- insert into marci values (marci_seq.nextval, 'Lancia', 'FCA');
-- insert into marci values (marci_seq.nextval, 'Chrysler', 'FCA');
-- insert into marci values (marci_seq.nextval, 'RAM', 'FCA');
-- insert into marci values (marci_seq.nextval, 'Jeep', 'FCA');
-- insert into marci values (marci_seq.nextval, 'Dodge', 'FCA');
-- insert into marci values (marci_seq.nextval, 'Suzuki', NULL);
-- insert into marci values (marci_seq.nextval, 'Kawasaki', 'Kawasaki Heavy Industries');
-- insert into marci values (marci_seq.nextval, 'KTM', 'KTM Group');
-- insert into marci values (marci_seq.nextval, 'Yamaha', 'Yamaha Corporation');
-- select * from marci;

-- INSERARE CATEGORII MOTO
-- create sequence cat_moto_seq start with 1 increment by 1;
-- insert into categ_moto values (cat_moto_seq.nextval, 'Naked');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Cruiser');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Chopper');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Sport');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Touring');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Enduro');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Enduro-touring');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Cross');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Dirt-track');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Superbike');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Supersport');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Supermoto');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Scuter');
-- insert into categ_moto values (cat_moto_seq.nextval, 'Moped');
-- select * from categ_moto;

-- INSERARE CATEGORII AUTO
-- create sequence cat_auto_seq start with 1 increment by 1;
-- insert into categ_auto values (cat_auto_seq.nextval, 'Masina de oras');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Supermini');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Hatchback');
-- insert into categ_auto values (cat_auto_seq.nextval, 'MPV');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Sedan');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Break');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Coupe');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Crossover');
-- insert into categ_auto values (cat_auto_seq.nextval, 'SUV');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Cabriolet');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Roadster');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Limuzina');
-- insert into categ_auto values (cat_auto_seq.nextval, 'Pick-up');
-- select * from categ_auto;

-- INSERARE TARI
-- insert into tari values ('A', 'Austria');
-- insert into tari values ('B', 'Belgia');
-- insert into tari values ('BG', 'Bulgaria');
-- insert into tari values ('CY', 'Cipru');
-- insert into tari values ('DK', 'Danemarca');
-- insert into tari values ('EST', 'Estonia');
-- insert into tari values ('FIN', 'Finlanda');
-- insert into tari values ('F', 'Franta');
-- insert into tari values ('D', 'Germania');
-- insert into tari values ('HR', 'Croatia');
-- insert into tari values ('GR', 'Grecia');
-- insert into tari values ('IRL', 'Irlanda');
-- insert into tari values ('I', 'Italia');
-- insert into tari values ('LV', 'Letonia');
-- insert into tari values ('LT', 'Lituania');
-- insert into tari values ('L', 'Luxemburg');
-- insert into tari values ('M', 'Malta');
-- insert into tari values ('GB', 'Marea Britanie');
-- insert into tari values ('NL', 'Olanda');
-- insert into tari values ('PL', 'Polonia');
-- insert into tari values ('P', 'Portugalia');
-- insert into tari values ('CZ', 'Republica Ceha');
-- insert into tari values ('RO', 'Romania');
-- insert into tari values ('SK', 'Slovacia');
-- insert into tari values ('SLO', 'Slovenia');
-- insert into tari values ('E', 'Spania');
-- insert into tari values ('S', 'Suedia');
-- insert into tari values ('H', 'Ungaria');
-- insert into tari values ('USA', 'Statele Unite ale Americii');
-- select * from tari;

-- INSERARE JUDETE
-- insert into judete values ('AB', 'Alba', 'RO');
-- insert into judete values ('AR', 'Arad', 'RO');
-- insert into judete values ('AG', 'Arges', 'RO');
-- insert into judete values ('BC', 'Bacau', 'RO');
-- insert into judete values ('BH', 'Bihor', 'RO');
-- insert into judete values ('BN', 'Bistrita-Nasaud', 'RO');
-- insert into judete values ('BT', 'Botosani', 'RO');
-- insert into judete values ('BR', 'Braila', 'RO');
-- insert into judete values ('BV', 'Brasov', 'RO');
-- insert into judete values ('BZ', 'Buzau', 'RO');
-- insert into judete values ('CL', 'Calarasi', 'RO');
-- insert into judete values ('CS', 'Caras-Severin', 'RO');
-- insert into judete values ('CJ', 'Cluj', 'RO');
-- insert into judete values ('CT', 'Constanta', 'RO');
-- insert into judete values ('CV', 'Covasna', 'RO');
-- insert into judete values ('DB', 'Dambovita', 'RO');
-- insert into judete values ('DJ', 'Dolj', 'RO');
-- insert into judete values ('GL', 'Galati', 'RO');
-- insert into judete values ('GR', 'Giurgiu', 'RO');
-- insert into judete values ('GJ', 'Gorj', 'RO');
-- insert into judete values ('HR', 'Harghita', 'RO');
-- insert into judete values ('HD', 'Hunedoara', 'RO');
-- insert into judete values ('IL', 'Ialomita', 'RO');
-- insert into judete values ('IS', 'Iasi', 'RO');
-- insert into judete values ('IF', 'Ilfov', 'RO');
-- insert into judete values ('MM', 'Maramures', 'RO');
-- insert into judete values ('MH', 'Mehedinti', 'RO');
-- insert into judete values ('MS', 'Mures', 'RO');
-- insert into judete values ('NT', 'Neamt', 'RO');
-- insert into judete values ('OT', 'Olt', 'RO');
-- insert into judete values ('PH', 'Prahova', 'RO');
-- insert into judete values ('SJ', 'Salaj', 'RO');
-- insert into judete values ('SM', 'Satu Mare', 'RO');
-- insert into judete values ('SB', 'Sibiu', 'RO');
-- insert into judete values ('SV', 'Suceava', 'RO');
-- insert into judete values ('TR', 'Teleorman', 'RO');
-- insert into judete values ('TM', 'Timis', 'RO');
-- insert into judete values ('TL', 'Tulcea', 'RO');
-- insert into judete values ('VL', 'Valcea', 'RO');
-- insert into judete values ('VS', 'Vaslui', 'RO');
-- insert into judete values ('VN', 'Vrancea', 'RO');
-- insert into judete values ('B', 'Bucuresti', 'RO');
-- select * from judete;

-- INSERARE LOCATII
-- delete from locatii;
-- drop sequence loc_seq;
-- create sequence loc_seq start with 1 increment by 1;
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'AB', 'Alba Iulia', 'Strada Mihai Viteazu');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'AR', 'Arad', 'Bulevardul Revolu?iei');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'AG', 'Pite?ti', 'Bulevardul Republicii');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BC', 'Bac?u', 'Strada Mihail Kog?lniceanu');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BH', 'Oradea', 'Bulevardul Decebal');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BN', 'Bistri?a', 'Strada Nicolae Titulescu');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BR', 'Br?ila', 'Bulevardul Independen?ei');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BT', 'Boto?ani', 'Strada Mihai Eminescu');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BV', 'Bra?ov', 'Bulevardul Eroilor');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'BZ', 'Buz?u', 'Strada Alexandru Vlahu??');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CS', 'Cara?-Severin', 'Bulevardul Revolu?iei');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CL', 'C?l?ra?i', 'Strada Mihai Eminescu');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CJ', 'Cluj-Napoca', 'Bulevardul 21 Decembrie 1989');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CT', 'Constan?a', 'Bulevardul Tomis');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'CV', 'Covasna', 'Strada Libert??ii');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'DB', 'Dâmbovi?a', 'Bulevardul Regele Carol I');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'DJ', 'Dolj', 'Bulevardul Victoriei');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'GL', 'Gala?i', 'Bulevardul Dun?rii');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'GR', 'Giurgiu', 'Strada Alexandru Ioan Cuza');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'GJ', 'Gorj', 'Bulevardul 1 Decembrie 1918');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'HR', 'Harghita', 'Strada Libert??ii');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'HD', 'Hunedoara', 'Bulevardul Revolu?iei');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'IL', 'Ialomi?a', 'Bulevardul Independen?ei');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'IS', 'Ia?i', 'Bulevardul ?tefan cel Mare ?i Sfânt');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'IF', 'Ilfov', 'Bulevardul Eroilor');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'MM', 'Maramure?', 'Bulevardul Independen?ei');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'MH', 'Mehedin?i', 'Bulevardul Revolu?iei');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'MS', 'Mure?', 'Bulevardul 1 Decembrie 1918');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'NT', 'Neam?', 'Bulevardul Republicii');
-- insert into locatii(id_locatie, id_judet, localitate, strada) values (loc_seq.nextval, 'OT', 'Olt', 'Bulevardul Nicolae B?lcescu');
-- select * from locatii;

--              GAMA SUZUKI
-- INSERARE MOTOCICLETE
-- create SEQUENCE moto_seq start with 2 increment by 1;
-- insert into motociclete values(moto_seq.nextval, 56, 'Hayabusa', 11, to_date('2023-02-15', 'yyyy-mm-dd'), 87, 16990, 'RO', 1340, 4, 190, 150, 'constant mesh', 6, 264, 20, 800);
-- insert into motociclete values(moto_seq.nextval, 56, 'Katana', 11, to_date('2023-03-25', 'yyyy-mm-dd'), 71, 12290, 'RO', 999, 4, 152, 106, 'mecanic', 6, 215, 12, 825);
-- insert into motociclete values(moto_seq.nextval, 56, 'GSX-R125', 11, to_date('2023-01-30', 'yyyy-mm-dd'), 107, 4690, 'RO', 124, 1, 15, 11.5, 'mecanic', 6, 134, 11, 785);
-- insert into motociclete values(moto_seq.nextval, 56, 'GSX-S1000GT', 1, to_date('2022-12-21', 'yyyy-mm-dd'), 230, 12990, 'RO', 999, 4, 152, 106, 'constant mesh', 6, 226, 19, 810);
-- insert into motociclete values(moto_seq.nextval, 56, 'GSX-S1000', 1, to_date('2023-04-11', 'yyyy-mm-dd'), 190, 11590, 'RO', 999, 4, 152, 106, 'mecanic', 6, 214, 19, 810);
-- insert into motociclete values(moto_seq.nextval, 56, 'GSX-S950', 1, to_date('2023-05-01', 'yyyy-mm-dd'), 29, 9990, 'RO', 999, 4, 94, 92, 'mecanic', 6, 214, 19, 810);
-- insert into motociclete values(moto_seq.nextval, 56, 'GSX-8S', 1, to_date('2022-11-03', 'yyyy-mm-dd'), 528, 8890, 'RO', 776, 2, 83, 78, 'mecanic', 6, 202, 14, 810);
-- insert into motociclete values(moto_seq.nextval, 56, 'SV650X', 1, to_date('2023-01-16', 'yyyy-mm-dd'), 114, 7590, 'RO', 645, 2, 75, 64, 'mecanic', 6, 198, 15, 790);
-- insert into motociclete values(moto_seq.nextval, 56, 'SV650', 1, to_date('2021-06-09', 'yyyy-mm-dd'), 794, 6990, 'RO', 645, 2, 73, 64, 'mecanic', 6, 198, 15, 785);
-- insert into motociclete values(moto_seq.nextval, 56, 'GSX-S125', 1, to_date('2023-02-23', 'yyyy-mm-dd'), 79, 4390, 'RO', 124, 1, 15, 12, 'mecanic', 6, 133, 11, 785);
-- insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 1050DE', 7, to_date('2023-03-17', 'yyyy-mm-dd'), 538, 14990, 'RO', 1037, 2, 106, 101, 'mecanic', 6, 252, 20, 880);
-- insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 1050', 7, to_date('2023-01-29', 'yyyy-mm-dd'), 1078, 13990, 'RO', 1037, 2, 106, 101, 'mecanic', 6, 242, 20, 855);
-- insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 800DE', 7, to_date('2022-11-07', 'yyyy-mm-dd'), 472, 10990, 'RO', 776, 2, 83, 78, 'mecanic', 6, 230, 20, 855);
-- insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 650XT', 7, to_date('2022-08-23', 'yyyy-mm-dd'), 1108, 8890, 'RO', 645, 2, 70, 62, 'mecanic', 6, 216, 20, 835);
-- insert into motociclete values(moto_seq.nextval, 56, 'V-STORM 650', 7, to_date('2021-05-30', 'yyyy-mm-dd'), 2890, 7990, 'RO', 645, 2, 70, 62, 'mecanic', 6, 213, 20, 835);
-- insert into motociclete values(moto_seq.nextval, 56, 'RM-Z450', 8, to_date('2023-03-26', 'yyyy-mm-dd'), 291, 7790, 'RO', 449, 1, 58, 50, 'mecanic', 5, 112, 6, 960);
-- insert into motociclete values(moto_seq.nextval, 56, 'RM-Z250', 8, to_date('2023-04-16', 'yyyy-mm-dd'), 320, 7290, 'RO', 249, 1, 42, 29, 'mecanic', 5, 106, 6, 955);
-- insert into motociclete values(moto_seq.nextval, 56, 'BURGMAN 400', 13, to_date('2021-09-30', 'yyyy-mm-dd'), 1004, 7990, 'RO', 400, 1, 31, 36, 'CVT', 1, 215, 14, 755);
-- insert into motociclete values(moto_seq.nextval, 56, 'BURGMAN 125', 13, to_date('2023-01-22', 'yyyy-mm-dd'), 152, 3290, 'RO', 124, 1, 8, 10, 'CVT', 1, 112, 6, 780);
-- insert into motociclete values(moto_seq.nextval, 56, 'AVENIS 125', 13, to_date('2023-04-16', 'yyyy-mm-dd'), 201, 2990, 'RO', 124, 1, 9, 10, 'CVT', 1, 107, 5, 780);
-- insert into motociclete values(moto_seq.nextval, 56, 'ADDRESS 125', 13, to_date('2022-09-23', 'yyyy-mm-dd'), 740, 2890, 'RO', 124, 1, 9, 10, 'CVT', 1, 105, 5, 770);
-- select * from motociclete;

-- INSERARE ACCESORII MOTO
-- create sequence acc_moto_seq start with 1 increment by 1;
-- insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'PRELATA MOTO GREEN VALLEY 153 921, LUNGIME 250 CM', 112);

-- insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'MANSOANE INCALZITE OXFORD HOTGRIPS PREMIUM, SPORTS CU COMUTATOR V8', 435);

-- insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'PLASA SUPORT OBIECTE', 23);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'PLASA SUPORT OBIECTE', 23);

-- insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'GEANTA, RUCSAC LATERAL MATERIAL NEGRU 45L', 667);

-- insert into accesorii_moto values (acc_moto_seq.nextval, 2, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 3, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 4, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 5, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 6, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 7, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 8, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 9, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 10, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 11, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 12, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 13, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 14, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 15, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 16, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 17, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 18, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 19, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 20, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 21, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 22, 'ALARMA MOTO OXFORD SCREAMER XA7', 145);
-- select * from accesorii_moto;

-- INSERARE MOTOARE AUTO
-- insert into motor_auto values('K6A', NULL, 'benzina', NULL, 658, 3, 63, 108);
-- insert into motor_auto values('K10B', NULL, 'benzina', NULL, 996, 3, 67, 90);
-- insert into motor_auto values('K10C', 'Boosterjet', 'benzina', NULL, 998, 3, 109, 170);
-- insert into motor_auto values('K10A', NULL, 'benzina', NULL, 996, 4, 99, 118);
-- insert into motor_auto values('K12A', NULL, 'benzina', NULL, 1172, 4, 68, 95);
-- insert into motor_auto values('K12B', 'Dualjet', 'benzina', NULL, 1242, 4, 91, 118);
-- insert into motor_auto values('K12C', 'Dualjet', 'benzina', NULL, 1242, 4, 90, 120);
-- insert into motor_auto values('K12D', 'Dualjet', 'benzina', 'Mild Hybrid 12V', 1197, 4, 83, 107);
-- insert into motor_auto values('K12M', 'Dualjet', 'benzina', NULL, 1197, 4, 86, 113);
-- insert into motor_auto values('K12N', 'Dualjet', 'benzina', NULL, 1197, 4, 89, 113);
-- insert into motor_auto values('K14B', 'E-Power EA14', 'benzina', NULL, 1372, 4, 95, 134);
-- insert into motor_auto values('K14C', 'Boosterjet', 'benzina', NULL, 1372, 4, 144, 230);
-- insert into motor_auto values('K14D', 'Boosterjet', 'benzina', 'Mild Hybrid 48V', 1372, 4, 127, 235);
-- insert into motor_auto values('K15B', NULL, 'benzina', NULL, 1462, 4, 105, 138);
-- insert into motor_auto values('K15B-C', NULL, 'benzina', NULL, 1462, 4, 96, 134);
-- insert into motor_auto values('K15C', NULL, 'benzina', 'Strong Hybrid 140V', 1462, 4, 102, 138);
-- insert into motor_auto values('2ZR-FXE', NULL, 'benzina', 'Full Hybrid', 1798, 4, 98, 142);
-- insert into motor_auto values('A25A-FXS', NULL, 'benzina', 'Plug-In Hybrid', 2487, 4, 136, 227);
-- select * from motor_auto;

-- INSERARE MASINI
-- create SEQUENCE auto_seq start with 2 increment by 1;
-- insert into masini values (auto_seq.nextval, 56, 'Ignis Cool', 9, to_date('2023-05-10', 'yyyy-mm-dd'), 1025, 14385, 'RO', 'K12D', 'manuala', 5, '2WD', 1330, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Ignis Passion', 9, to_date('2023-02-28', 'yyyy-mm-dd'), 908, 16070, 'DK', 'K12D', 'manuala', 5, '2WD', 1330, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Ignis Passion', 9, to_date('2022-09-29', 'yyyy-mm-dd'), 15067, 17410, 'HR', 'K12D', 'CVT', 1, '2WD', 1330, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Ignis Spirit', 9, to_date('2023-01-07', 'yyyy-mm-dd'), 7942, 17135, 'RO', 'K12D', 'manuala', 5, '2WD', 1330, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Ignis Spirit', 9, to_date('2023-03-17', 'yyyy-mm-dd'), 2345, 18424, 'F', 'K12D', 'CVT', 1, '2WD', 1330, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Ignis Passion', 9, to_date('2022-12-25', 'yyyy-mm-dd'), 1932, 17610, 'BG', 'K12D', 'manuala', 5, 'ALLGRIP', 1330, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Ignis Spirit', 9, to_date('2023-04-23', 'yyyy-mm-dd'), 509, 18410, 'RO', 'K12D', 'manuala', 5, 'ALLGRIP', 1330, 'Euro 6');

-- insert into masini values (auto_seq.nextval, 56, 'Swift Cool', 2, to_date('2023-05-04', 'yyyy-mm-dd'), 598, 14860, 'BG', 'K12D', 'manuala', 5, '2WB', 991, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Swift Passion', 2, to_date('2022-07-14', 'yyyy-mm-dd'), 23900, 16700, 'GB', 'K12D', 'CVT', 1, '2WB', 991, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Swift Spirit', 2, to_date('2023-01-31', 'yyyy-mm-dd'), 1191, 17540, 'S', 'K12D', 'manuala', 5, '2WB', 991, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Swift Spirit', 2, to_date('2021-02-15', 'yyyy-mm-dd'), 12155, 18435, 'RO', 'K12D', 'CVT', 1, '2WB', 991, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Swift Passion', 2, to_date('2018-10-22', 'yyyy-mm-dd'), 41519, 17540, 'SK', 'K12D', 'manuala', 5, '2WB', 991, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Swift Spirit', 2, to_date('2020-05-19', 'yyyy-mm-dd'), 26287, 19280, 'RO', 'K12D', 'manuala', 5, 'ALLGRIP', 991, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Swift Passion', 2, to_date('2021-01-11', 'yyyy-mm-dd'), 47637, 15890, 'RO', 'K12D', 'manuala', 5, '2WB', 991, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Swift Sport', 2, to_date('2022-03-29', 'yyyy-mm-dd'), 19971, 15890, 'SLO', 'K14D', 'manuala', 6, '2WB', 1021, 'Euro 6');

-- insert into masini values (auto_seq.nextval, 56, 'Vitara Cool', 9, to_date('2023-05-04', 'yyyy-mm-dd'), 7342, 19310, 'SLO', 'K14D', 'manuala', 6, '2WB', 1275, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Passion', 9, to_date('2022-09-06', 'yyyy-mm-dd'), 9927, 20970, 'P', 'K14D', 'manuala', 6, '2WB', 1275, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Spirit', 9, to_date('2020-03-15', 'yyyy-mm-dd'), 36643, 23630, 'I', 'K14D', 'manuala', 6, '2WB', 1275, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Luxus', 9, to_date('2021-03-31', 'yyyy-mm-dd'), 23601, 24330, 'S', 'K14D', 'manuala', 6, '2WB', 1275, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Passion', 9, to_date('2020-08-06', 'yyyy-mm-dd'), 44768, 23300, 'RO', 'K14D', 'manuala', 6, 'ALLGRIP', 1326, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Spirit', 9, to_date('2022-11-04', 'yyyy-mm-dd'), 3146, 25230, 'NL', 'K14D', 'manuala', 6, 'ALLGRIP', 1326, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Luxus', 9, to_date('2021-04-15', 'yyyy-mm-dd'), 25523, 25990, 'BG', 'K14D', 'manuala', 6, 'ALLGRIP', 1326, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Passion', 9, to_date('2023-02-26', 'yyyy-mm-dd'), 12922, 23630, 'D', 'K15C', 'AGS', 6, '2WB', 1268, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Luxus', 9, to_date('2021-07-04', 'yyyy-mm-dd'), 34577, 24330, 'CZ', 'K15C', 'AGS', 6, '2WB', 1268, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Passion', 9, to_date('2020-07-18', 'yyyy-mm-dd'), 41527, 23300, 'M', 'K15C', 'AGS', 6, 'ALLGRIP', 1338, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Vitara Luxus', 9, to_date('2022-06-06', 'yyyy-mm-dd'), 4530, 25230, 'RO', 'K15C', 'AGS', 6, 'ALLGRIP', 1338, 'Euro 6');
                  
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Cool', 9, to_date('2020-01-23', 'yyyy-mm-dd'), 40482, 21420, 'B', 'K14D', 'manuala', 6, '2WB', 1235, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Passion', 9, to_date('2020-09-30', 'yyyy-mm-dd'), 27449, 23830, 'A', 'K14D', 'manuala', 6, '2WB', 1235, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Spirit', 9, to_date('2020-11-28', 'yyyy-mm-dd'), 8907, 25920, 'BG', 'K14D', 'manuala', 6, '2WB', 1235, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Luxus', 9, to_date('2020-12-30', 'yyyy-mm-dd'), 23601, 26320, 'IRL', 'K14D', 'manuala', 6, '2WB', 1235, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Passion', 9, to_date('2021-10-02', 'yyyy-mm-dd'), 16993, 25130, 'RO', 'K14D', 'manuala', 6, 'ALLGRIP', 1305, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Spirit', 9, to_date('2022-10-08', 'yyyy-mm-dd'), 11233, 27330, 'H', 'K14D', 'manuala', 6, 'ALLGRIP', 1305, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Luxus', 9, to_date('2023-02-11', 'yyyy-mm-dd'), 7739, 27620, 'GR', 'K14D', 'manuala', 6, 'ALLGRIP', 1305, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Passion', 9, to_date('2022-12-29', 'yyyy-mm-dd'), 2027, 23630, 'HR', 'K15C', 'AGS', 6, '2WB', 1308, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Spirit', 9, to_date('2021-10-20', 'yyyy-mm-dd'), 17886, 24330, 'RO', 'K15C', 'AGS', 6, '2WB', 1308, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Luxus', 9, to_date('2021-01-19', 'yyyy-mm-dd'), 27475, 24330, 'F', 'K15C', 'AGS', 6, '2WB', 1308, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Passion', 9, to_date('2020-08-13', 'yyyy-mm-dd'), 20284, 23300, 'HR', 'K15C', 'AGS', 6, 'ALLGRIP', 1378, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Spirit', 9, to_date('2020-04-26', 'yyyy-mm-dd'), 32382, 23300, 'I', 'K15C', 'AGS', 6, 'ALLGRIP', 1378, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'S-Cross Luxus', 9, to_date('2020-03-01', 'yyyy-mm-dd'), 36080, 25230, 'FIN', 'K15C', 'AGS', 6, 'ALLGRIP', 1378, 'Euro 6');

-- insert into masini values (auto_seq.nextval, 56, 'Swace Passion', 6, to_date('2020-09-19', 'yyyy-mm-dd'), 39485, 26850, 'NL', '2ZR-FXE', 'CVT', 1, '2WB', 1420, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Swace Spirit', 6, to_date('2022-05-16', 'yyyy-mm-dd'), 9356, 30220, 'D', '2ZR-FXE', 'CVT', 1, '2WB', 1420, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 56, 'Across Luxus', 9, to_date('2023-02-11', 'yyyy-mm-dd'), 2027, 56540, 'RO', 'A25A-FXS', 'E-CVT', 1, 'E-FOUR', 1940, 'Euro 6');
-- select * from masini;

-- INSERARE ACCESORII AUTO
-- create sequence acc_auto_seq start with 1 increment by 1;
-- insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 42, 'SET FUMATORI', 125);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'SET FUMATORI', 125);

-- insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 42, 'ORNAMENT PRAGURI', 540);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'ORNAMENT PRAGURI', 540);

-- insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 42, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'CARLIG REMORCARE CU CAP DEMONTABIL', 1869);

-- insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 42, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'CUTIE PORTBAGAJ DE ACOPERIS CERTO 460', 2719);

-- insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 42, 'SET PRIM AJUTOR', 104);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'SET PRIM AJUTOR', 104);

-- insert into accesorii_auto values (acc_auto_seq.nextval, 2, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 3, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 4, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 5, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 6, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 7, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 8, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 9, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 10, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 11, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 12, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 13, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 14, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 15, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 16, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 17, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 18, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 19, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 20, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 21, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 22, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 23, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 24, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 25, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 26, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 27, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 28, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 29, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 30, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 31, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 32, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 33, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 34, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 35, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 36, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 37, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 38, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 39, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 40, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 41, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 42, 'SET COVORASE CAUCIUC', 365);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 43, 'SET COVORASE CAUCIUC', 365);
-- select * from accesorii_auto;

--              GAMA HONDA
-- INSERARE MOTOCICLETE
-- insert into motociclete values(42, 1, 'Africa Twin', 7, to_date('2023-02-15', 'yyyy-mm-dd'), 108, 15450, 'RO', 1084, 2, 102, 105, 'Multi-disc, umed cu slipper clutch', 6, 226, 19, 870);
-- drop sequence moto_seq;
-- create SEQUENCE moto_seq start with 61 increment by 1;
-- insert into motociclete values(moto_seq.nextval, 1, 'CB 1000R', 1, to_date('2022-03-27', 'yyyy-mm-dd'), 709, 14250, 'RO', 998, 4, 146, 104, 'Multi-disc, umed', 6, 212, 16, 830);
-- insert into motociclete values(moto_seq.nextval, 1, 'CB 750(Hornet)', 1, to_date('2023-01-09', 'yyyy-mm-dd'), 358, 8550, 'RO', 755, 2, 92, 75, 'Multi-disc, umed, slipper clutch', 6, 190, 15, 795);
-- insert into motociclete values(moto_seq.nextval, 1, 'CB 650R(23YM)', 1, to_date('2021-11-15', 'yyyy-mm-dd'), 2714, 9150, 'RO', 649, 4, 95, 63, 'Multi-disc, umed', 6, 202, 15, 810);
-- insert into motociclete values(moto_seq.nextval, 1, 'CB 650R(23YM) - Black Edition', 1, to_date('2023-04-10', 'yyyy-mm-dd'), 235, 9450, 'RO', 649, 4, 95, 63, 'Multi-disc, umed', 6, 202, 15, 810);
-- insert into motociclete values(moto_seq.nextval, 1, 'CB 125F', 1, to_date('2022-11-23', 'yyyy-mm-dd'), 1006, 3650, 'RO', 124, 1, 11, 11, 'Multi-disc, umed', 5, 117, 11, 790);
-- insert into motociclete values(moto_seq.nextval, 1, 'Rebel 1100 T-MT', 3, to_date('2021-06-17', 'yyyy-mm-dd'), 3902, 12650, 'RO', 1084, 2, 87, 98, 'Multi-disc, umed', 6, 223, 14, 700);
-- insert into motociclete values(moto_seq.nextval, 1, 'Rebel 1100 MT', 3, to_date('2022-05-29', 'yyyy-mm-dd'), 1872, 11450, 'RO', 1084, 2, 87, 98, 'Multi-disc, umed', 6, 223, 14, 700);
-- insert into motociclete values(moto_seq.nextval, 1, 'Rebel 500(23YM)', 3, to_date('2023-05-20', 'yyyy-mm-dd'), 97, 7650, 'RO', 471, 2, 46, 43, 'Multi-disc, umed', 6, 191, 11, 690);
-- insert into motociclete values(moto_seq.nextval, 1, 'Rebel 500', 3, to_date('2021-01-13', 'yyyy-mm-dd'), 2904, 7350, 'RO', 471, 2, 46, 43, 'Multi-disc, umed', 6, 191, 11, 690);
-- insert into motociclete values(moto_seq.nextval, 1, 'CBR 1000RR-R Fireblade SP', 11, to_date('2022-05-18', 'yyyy-mm-dd'), 82510, 27250, 'RO', 999, 4, 218, 113, 'Multi-disc, umed, arc diafragma', 6, 201, 16, 830);
-- insert into motociclete values(moto_seq.nextval, 1, 'CBR 650R', 11, to_date('2021-12-10', 'yyyy-mm-dd'), 54230, 9750, 'RO', 649, 4, 96, 63, 'Multi-disc, umed', 6, 207, 15, 810);
-- insert into motociclete values(moto_seq.nextval, 1, 'CBR 500R', 11, to_date('2022-03-29', 'yyyy-mm-dd'), 23230, 7950, 'RO', 471, 2, 48, 43, 'Multi-disc, umed, cu alunecare asistata', 6, 192, 17, 785);
-- insert into motociclete values(moto_seq.nextval, 1, 'NT 1100 - MT', 5, to_date('2021-02-09', 'yyyy-mm-dd'), 40482, 14650, 'RO', 1084, 2, 102, 104, 'Automatic, multi-disc, umed, dublu ambreiaj', 6, 238, 20, 820);
-- insert into motociclete values(moto_seq.nextval, 1, 'Gold Wing (DCT)', 5, to_date('2020-04-17', 'yyyy-mm-dd'), 132830, 28850, 'RO', 1833, 6, 127, 170, 'Automatic, multi-disc, umed, dublu ambreiaj', 7, 367, 21, 745);
-- insert into motociclete values(moto_seq.nextval, 1, 'GL 1800 GoldWing', 5, to_date('2021-06-22', 'yyyy-mm-dd'), 99230, 36850, 'RO', 1833, 6, 127, 170, 'Automatic, multi-disc, umed, dublu ambreiaj', 7, 383, 21, 745);
-- insert into motociclete values(moto_seq.nextval, 1, 'SH Mode 125', 13, to_date('2023-02-26', 'yyyy-mm-dd'), 99230, 1056, 'RO', 125, 1, 11, 12, 'Automatic, centrifugal', 1, 118, 6, 765);
-- insert into motociclete values(moto_seq.nextval, 1, 'Forza 350', 13, to_date('2020-08-30', 'yyyy-mm-dd'), 101890, 7150, 'RO', 330, 1, 29, 32, 'Automatic, centrifugal', 1, 184, 12, 780);
-- insert into motociclete values(moto_seq.nextval, 1, 'Forza 750', 13, to_date('2021-08-30', 'yyyy-mm-dd'), 57025, 11950, 'RO', 745, 2, 59, 69, 'Automatic, dublu disc, umed, hidraulic', 6, 235, 13, 790);
-- select * from motociclete where id_marca = 1 order by 1;

-- INSERARE ACCESORII MOTO
-- insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'SEZUT PIELE NEAGRA CUSTOM', 430);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'SET TANK PADS', 270);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'SET GENTI PIELE', 2535);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'PORTBAGAJ', 1378);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 42, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 61, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 62, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 63, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 64, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 65, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 66, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 67, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 68, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 69, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 70, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 71, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 72, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 73, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 74, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 75, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 76, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 77, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 78, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 79, 'SPATAR PASAGER', 776);
-- insert into accesorii_moto values (acc_moto_seq.nextval, 80, 'SPATAR PASAGER', 776);

-- INSERARE MOTOARE AUTO
-- insert into motor_auto values('K20C', 'Earth Dreams VTEC Turbo', 'benzina', NULL, 1996, 4, 320, 420);
-- insert into motor_auto values('LFC-H4', NULL, 'benzina', 'Full Hybrid - e:HEV', 1993, 4, 184, 315);
-- insert into motor_auto values('L15C1', NULL, 'benzina', 'Full Hybrid - e:HEV', 1497, 4, 175, 240);
-- insert into motor_auto values('LEB8', 'Earth Dreams i-VTEC', 'benzina', 'Full Hybrid - e:HEV', 1497, 4, 122, 253);

-- INSERARE MASINI
-- drop sequence auto_seq;
-- create SEQUENCE auto_seq start with 61 increment by 1;
-- insert into masini values (auto_seq.nextval, 1, 'Jazz Sport Advance', 1, to_date('2022-11-11', 'yyyy-mm-dd'), 75230, 29440, 'RO', 'LEB8', 'CVT i-MMD', 1, 'FWD', 1244, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 1, 'HR-V Advance', 9, to_date('2021-07-27', 'yyyy-mm-dd'), 82331, 35040, 'RO', 'L15C1', 'CVT', 1, 'FWD', 1401, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 1, 'HR-V Advance Style', 9, to_date('2022-09-12', 'yyyy-mm-dd'), 62351, 37540, 'RO', 'L15C1', 'CVT', 1, 'FWD', 1401, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 1, 'CR-V Elegance', 9, to_date('2020-02-19', 'yyyy-mm-dd'), 139051, 40500, 'RO', 'LFC-H4', 'CVT', 1, 'FWD', 1657, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 1, 'CR-V Executive', 9, to_date('2023-01-28', 'yyyy-mm-dd'), 13051, 47150, 'RO', 'LFC-H4', 'CVT', 1, 'AWD', 1726, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 1, 'Civic Advance', 3, to_date('2022-08-20', 'yyyy-mm-dd'), 29347, 39490, 'RO', 'LFC-H4', 'CVT', 1, 'FWD', 1533, 'Euro 6');
-- insert into masini values (auto_seq.nextval, 1, 'Civic Type R', 3, to_date('2021-03-17', 'yyyy-mm-dd'), 47230, 44890, 'RO', 'K20C', 'manuala', 6, 'FWD', 1429, 'Euro 6');

-- INSERARE ACCESORII AUTO
-- insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'PRELATA', 1090);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'PRELATA', 1090);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'PRELATA', 1090);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'PRELATA', 1090);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'PRELATA', 1090);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'PRELATA', 1090);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'PRELATA', 1090);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'SET PROTECTII NOROI', 238);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'SET PROTECTII NOROI', 238);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'SET PROTECTII NOROI', 238);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'SET PROTECTII NOROI', 238);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'SET PROTECTII NOROI', 238);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'SET PROTECTII NOROI', 238);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'SET PROTECTII NOROI', 238);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'PRELATA PARBRIZ', 590);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'PRELATA PARBRIZ', 590);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'PRELATA PARBRIZ', 590);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'PRELATA PARBRIZ', 590);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'PRELATA PARBRIZ', 590);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'PRELATA PARBRIZ', 590);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'PRELATA PARBRIZ', 590);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'LUMINI AMBIENTALE', 9750);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'LUMINI AMBIENTALE', 9750);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'LUMINI AMBIENTALE', 9750);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'LUMINI AMBIENTALE', 9750);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'LUMINI AMBIENTALE', 9750);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'LUMINI AMBIENTALE', 9750);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'LUMINI AMBIENTALE', 9750);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'PACHET CARGO', 537);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'PACHET CARGO', 537);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'PACHET CARGO', 537);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'PACHET CARGO', 537);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'PACHET CARGO', 537);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'PACHET CARGO', 537);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'PACHET CARGO', 537);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'COVORASE ELEGANCE', 440);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'COVORASE ELEGANCE', 440);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'COVORASE ELEGANCE', 440);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'COVORASE ELEGANCE', 440);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'COVORASE ELEGANCE', 440);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'COVORASE ELEGANCE', 440);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'COVORASE ELEGANCE', 440);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 61, 'SUPORT SKI SI SNOWBOARD', 1045);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 62, 'SUPORT SKI SI SNOWBOARD', 1045);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 63, 'SUPORT SKI SI SNOWBOARD', 1045);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 64, 'SUPORT SKI SI SNOWBOARD', 1045);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 65, 'SUPORT SKI SI SNOWBOARD', 1045);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 66, 'SUPORT SKI SI SNOWBOARD', 1045);
-- insert into accesorii_auto values (acc_auto_seq.nextval, 67, 'SUPORT SKI SI SNOWBOARD', 1045);


-- INSERARE INREGISTRARI SERVICE AUTO
-- create sequence isa_seq start with 1 increment by 1;
-- insert into inreg_service_auto
--     select isa_seq.nextval, id_auto, current_date, 'Schimb ulei, filtru ulei, filtru aer'
--     from masini
--     where nr_km >= 1000;
-- insert into inreg_service_auto
--     select isa_seq.nextval, id_auto, current_date, 'Schimb distributie'
--     from masini
--     where nr_km >= 60000;
-- insert into inreg_service_auto
--     select isa_seq.nextval, id_auto, to_date(data_fabricatie + INTERVAL '30' month ), 'Schimb parbriz'
--     from masini 
--     where to_char(data_fabricatie, 'MM') = 05;
-- insert into inreg_service_auto
--     select isa_seq.nextval, id_auto, to_date(data_fabricatie + INTERVAL '5' month ), 'Geometrie roti'
--     from masini 
--     where to_char(data_fabricatie, 'MM') = 03;
-- select * from inreg_service_auto;

-- INSERARE INREGISTRARI SERVICE MOTO
-- create sequence ism_seq start with 1 increment by 1;
-- insert into inreg_service_moto
--     select ism_seq.nextval, id_moto, to_date(data_fabricatie + INTERVAL '5' month ), 'Servisare telescoape'
--     from motociclete
--     where to_char(data_fabricatie, 'YYYY') < 2021;
-- insert into inreg_service_moto
--     select ism_seq.nextval, id_moto, current_date, 'Schimb ulei, filtru ulei, filtru aer'
--     from motociclete
--     where nr_km >= 5000;
-- insert into inreg_service_moto
--     select ism_seq.nextval, id_moto, to_date(data_fabricatie + INTERVAL '1' year ), 'Schimb placute frana + lichid frana'
--     from motociclete
--     where to_char(data_fabricatie, 'YYYY') < 2023 and to_char(data_fabricatie, 'MM') = 01;
-- insert into inreg_service_moto
--     select ism_seq.nextval, id_moto, to_date(data_fabricatie + INTERVAL '1' year ), 'Segmentare motor'
--     from motociclete
--     where to_char(data_fabricatie, 'dd') = 30;
-- select * from inreg_service_moto;


-- INSERARE CLIENTI
-- drop sequence li_seq;
-- drop sequence cl_seq;
-- drop sequence ang_seq;
-- drop sequence aux;
-- create sequence li_seq start with 1 increment by 1;
-- create sequence cl_seq start with 1 increment by 1;
-- create sequence aux start with 3 increment by 1;
-- insert into login_info values (li_seq.nextval, 'ion.popescu@email.com', 'ion.popescu1985', 'Parola1234!');
-- insert into clienti values (cl_seq.nextval, 'Ion', 'Popescu', '+40711223344', li_seq.currval, 1);
-- insert into login_info values (li_seq.nextval, 'maria.ionescu@email.com', 'maria.ionescu1990', 'Parola5678@');
-- insert into clienti values (cl_seq.nextval, 'Maria', 'Ionescu', '+40722334455', li_seq.currval, 2);
-- insert into login_info values (li_seq.nextval, 'andrei.popa@email.com', 'andrei.popa1987', 'Parola!9876');
-- insert into clienti values (cl_seq.nextval, 'Andrei', 'Popa', '+40733445566', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'elena.vasilescu@email.com', 'elena.vasilescu1992', 'Parola4321#');
-- insert into clienti values (cl_seq.nextval, 'Elena', 'Vasilescu', '+40744556677', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'adrian.radu@email.com', 'adrian.radu1983', 'Parola@2468');
-- insert into clienti values (cl_seq.nextval, 'Adrian', 'Radu', '+40755667788', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'ana.stanescu@email.com', 'ana.stanescu1995', 'Parola987!' );
-- insert into clienti values (cl_seq.nextval, 'Ana', 'Stanescu', '+40766778899', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'cristian.dumitru@email.com', 'cristian.dumitru1988', 'Parola654@#' );
-- insert into clienti values (cl_seq.nextval, 'Cristian', 'Dumitru', '+40777889900', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'laura.georgescu@email.com', 'laura.georgescu1991', 'Parola123@abc' );
-- insert into clienti values (cl_seq.nextval, 'Laura', 'Georgescu', '+40788990011', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'florin.munteanu@email.com', 'florin.munteanu1986', 'Parolaabc123#' );
-- insert into clienti values (cl_seq.nextval, 'Florin', 'Munteanu', '+40799001122', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'gabriela.radulescu@email.com', 'gabriela.radulescu1993', 'Parola!4567@' );
-- insert into clienti values (cl_seq.nextval, 'Gabriela', 'Radulescu', '+40771234567', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'mihai.popovici@email.com', 'mihai.popovici1984', 'Parola789@xyz' );
-- insert into clienti values (cl_seq.nextval, 'Mihai', 'Popovici', '+40782345678', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'ioana.gheorghe@email.com', 'ioana.gheorghe1997', 'ParolaXYZ!789' );
-- insert into clienti values (cl_seq.nextval, 'Ioana', 'Gheorghe', '+40793456789', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'stefan.marinescu@email.com', 'stefan.marinescu1989', 'Parola9876@XYZ' );
-- insert into clienti values (cl_seq.nextval, 'Stefan', 'Marinescu', '+40704567890', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'mihaela.constantinescu@email.com', 'mihaelaconstantinescu1994', 'ParolaXYZ@9876' );
-- insert into clienti values (cl_seq.nextval, 'Mihaela', 'Constantinescu', '+40715678901', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'alexandru.stoica@email.com', 'alexandru.stoica1982', 'Parola123XYZ@' );
-- insert into clienti values (cl_seq.nextval, 'Alexandru', 'Stoica', '+40726789012', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'diana.barbu@email.com', 'diana.barbu1996', 'ParolaXYZ!123' );
-- insert into clienti values (cl_seq.nextval, 'Diana', 'Barbu', '+40737890123', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'robert.chiriac@email.com', 'robert.chiriac1987', 'Parola!XYZ123' );
-- insert into clienti values (cl_seq.nextval, 'Robert', 'Chiriac', '+40748901234', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'raluca.mihai@email.com', 'raluca.mihai1990', 'Parola123@XYZ' );
-- insert into clienti values (cl_seq.nextval, 'Raluca', 'Mihai', '+40759012345', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'daniel.iancu@email.com', 'daniel.iancu1985', 'Parola!XYZ1234' );
-- insert into clienti values (cl_seq.nextval, 'Daniel', 'Iancu', '+40760123456', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'alina.neagu@email.com', 'alina.neagu1992', 'Parola1234@XYZ' );
-- insert into clienti values (cl_seq.nextval, 'Alina', 'Neagu', '+40771234567', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'marius.constantin@email.com', 'marius.constantin1986', 'Parola789@xyz' );
-- insert into clienti values (cl_seq.nextval, 'Marius', 'Constantin', '+40782345678', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'simona.radulescu@email.com', 'simona.radulescu1997', 'ParolaXYZ!789' );
-- insert into clienti values (cl_seq.nextval, 'Simona', 'Radulescu', '+40793456789', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'gabriel.marin@email.com', 'gabriel.marin1989', 'Parola9876@XYZ' );
-- insert into clienti values (cl_seq.nextval, 'Gabriel', 'Marin', '+40704567890', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'carmen.stoian@email.com', 'carmen.stoian1994', 'ParolaXYZ@9876' );
-- insert into clienti values (cl_seq.nextval, 'Carmen', 'Stoian', '+40715678901', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'ionut.gavril1982@email.com', 'ionut.gavril1982', 'Parola123XYZ@' );
-- insert into clienti values (cl_seq.nextval, 'Ionut', 'Gavril', '+40726789012', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'loredana.badea1995@email.com', 'loredana.badea1995', 'ParolaXYZ!123' );
-- insert into clienti values (cl_seq.nextval, 'Loredana', 'Badea', '+40737890123', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'bogdan.radulescu1988@email.com', 'bogdan.radulescu1988', 'Parola!XYZ123' );
-- insert into clienti values (cl_seq.nextval, 'Bogdan', 'Radulescu', '+40748901234', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'iulia.enache1991@email.com', 'iulia.enache1991', 'Parola123@XYZ' );
-- insert into clienti values (cl_seq.nextval, 'Iulia', 'Enache', '+40759012345', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'adrian.ciobanu1986@email.com', 'adrian.ciobanu1986', 'Parola!XYZ1234' );
-- insert into clienti values (cl_seq.nextval, 'Adrian', 'Ciobanu', '+40760123456', li_seq.currval, aux.nextval);
-- insert into login_info values (li_seq.nextval, 'daniela.popa1994@email.com', 'daniela.popa1994', 'Parola1234@XYZ' );
-- insert into clienti values (cl_seq.nextval, 'Daniela', 'Popa', '+40771234567', li_seq.currval, aux.nextval);
-- select * from clienti;


-- INSERARE ANGAJATI
-- drop sequence aux;
-- create sequence aux start with 1 increment by 1;
-- create sequence ang_seq start with 1 increment by 1;
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'alex93', 'Parola123!', 'alex93@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Alexandrescu', 'Alex', '+40711223344', 2500, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'maria22', 'Parola!456', 'maria22@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Popescu', 'Maria', '+40722334455', 3500, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'andrei87', 'ParolaXYZ123', 'andrei87@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Ionescu', 'Andrei', '+40733445566', 2800, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'elena99', 'Parola@789', 'elena99@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Radu', 'Elena', '+40744556677', 3200, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'mihai76', 'Parola!XYZ123', 'mihai76@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Constantin', 'Mihai', '+40755667788', 3000, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'alexandra01', 'ParolaXYZ!789', 'alexandra01@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Popa', 'Alexandra', '+40766778899', 2800, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'cristian82', 'Parola123XYZ@', 'cristian82@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Mihai', 'Cristian', '+40777889900', 3200, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'laura10', 'Parola!9876@', 'laura10@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Andrei', 'Laura', '+40788990011', 3000, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'ionut94', 'ParolaXYZ!123', 'ionut94@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Popescu', 'Ionut', '+40799001122', 2500, li_seq.currval, aux.nextval);
-- insert into login_info(id_login, username, parola, email) values (li_seq.nextval,'ana88', 'Parola123@XYZ', 'ana88@email.com'); 
-- insert into angajati values (ang_seq.nextval, 'Andrei', 'Ana', '+40770112233', 3500, li_seq.currval, aux.nextval);
-- select * from angajati;
-- select * from login_info;


-- INSERARE VANZARI
-- create sequence vnz_seq start with 1 increment by 1;
-- insert into vanzari values (vnz_seq.nextval, 1, 1, current_date, 17540);
-- insert into vanzari values (vnz_seq.nextval, 3, 3, current_date, 38920);
-- insert into vanzari values (vnz_seq.nextval, 7, 6, current_date, 37625);
-- insert into vanzari values (vnz_seq.nextval, 5, 9, current_date, 119760);
-- insert into vanzari values (vnz_seq.nextval, 12, 2, current_date, 31740);
-- insert into vanzari values (vnz_seq.nextval, 25, 5, current_date, 44300);
-- insert into vanzari values (vnz_seq.nextval, 15, 8, current_date, 44890);
-- insert into vanzari values (vnz_seq.nextval, 22, 10, current_date, 1056);
-- insert into vanzari values (vnz_seq.nextval, 30, 3, current_date, 36850);
-- insert into vanzari values (vnz_seq.nextval, 1, 7, current_date, 79990);
-- insert into vanzari values (vnz_seq.nextval, 20, 4, current_date, 28400);
-- select * from vanzari;

-- INSERARE VANZARI AUTO
-- insert into v_auto values (2, 32);
-- insert into v_auto values (3, 4);
-- insert into v_auto values (4, 65); 
-- insert into v_auto values (4, 2);
-- insert into v_auto values (4, 43);
-- insert into v_auto values (6, 8);
-- insert into v_auto values (6, 61);
-- insert into v_auto values (7, 67);
-- insert into v_auto values (10, 66);
-- insert into v_auto values (10, 64);
-- insert into v_auto values (11, 7);
-- select * from v_auto;

-- INSERARE VANZARI MOTO
-- insert into v_moto values (1, 12);
-- insert into v_moto values (2,6);
-- insert into v_moto values (3, 17);
-- insert into v_moto values (3,42);
-- insert into v_moto values (5, 22);
-- insert into v_moto values (5, 80);
-- insert into v_moto values (8, 76);
-- insert into v_moto values (9, 75);
-- insert into v_moto values (11, 7);
-- select * from v_moto;     