-- EXERCITIUL 12
-- 1. Afi?eaz? numele ?i prenumele clien?ilor împreun? cu gradul de uzura al masinilor
-- lor ordonate crescator in functie de gradul de uzura. Pentru fiecare 
-- client, verific? kilometrajul fiecarei ma?ini pe care o de?ine ?i atribuie 
-- nivelul de uzura în func?ie de valoarea kilometrajului.

-- subcereri nesincronizate în clauza FROM
-- a cel pu?in unei expresii CASE
-- ordon?ri 
select c.id_client, c.nume, m.id_auto, m.model, m.grad_uzura
from (select id_auto, model, nr_km, case
                                        when nr_km < 10000 then 'noua'
                                        when nr_km < 100000 then 'mediu uzata'
                                        when nr_km > 100000 then 'uzata'
                                        when nr_km > 150000 then 'foarte uzata'
                                    end as grad_uzura
        from masini) m, v_auto va, vanzari v, clienti c
where m.id_auto = va.id_auto
    and va.id_vanzare = v.id_vanzare
    and v.id_client = c.id_client
order by m.nr_km;

-- 2. Pentru fiecare masina fabricata in luna curenta, oferiti-i proprietarului 
-- cel mai ieftin accesoriu auto. Daca masina a fost cumparata tot in luna curenta
-- atunci proprietarul va primi cel mai scump accesoriu pentru masina sa. 
-- Daca masina nu are niciun accesoriu disponibil, se va afisa -1

-- utilizarea a cel pu?in 1 bloc de cerere(clauza WITH)
-- utilizarea func?iilor NVL ?i DECODE (in cadrul aceleiasi cereri)
-- subcereri sincronizate în care intervin cel pu?in 3 tabele
-- 2 func?ii pe date calendaristice
with aux as(select m.id_auto, min(acc.pret) pmin, max(acc.pret) pmax
        from masini m, accesorii_auto acc
        where m.id_auto = acc.id_auto
        group by m.id_auto) ,
minmax as(select aux.id_auto, 
                (select aa.id_accesoriu
                from accesorii_auto aa
                where aa.id_auto = aux.id_auto
                and aa.pret = aux.pmin)idaccmin, 
                aux.pmin, 
                (select aa.id_accesoriu 
                from accesorii_auto aa
                where aa.id_auto = aux.id_auto
                and aa.pret = aux.pmax)idaccmax, 
                aux.pmax
            from aux),
mlunacur as(select * 
            from masini
            where to_char(data_fabricatie, 'MM') = to_char((select sysdate from dual), 'MM')),
cntrlunacur as (select *
                from vanzari
                where to_char(data_vanzare, 'MM') = to_char((select sysdate from dual), 'MM'))
select c.nume, va.id_auto, nvl(decode(nvl((select 'x'
                                           from cntrlunacur clc
                                           where clc.id_vanzare = va.id_vanzare), 'o'), 
                                           'x', 
                                           (select idaccmax
                                            from minmax mm
                                            where va.id_auto = mm.id_auto),
                                           (select idaccmin
                                            from minmax mm
                                            where va.id_auto = mm.id_auto)), -1)accesoriu_cadou
from v_auto va, vanzari v, clienti c
where va.id_auto in (select id_auto from mlunacur)
    and va.id_vanzare = v.id_vanzare
    and v.id_client = c.id_client;

-- 3. Afiseaza id-ul, numele clientilor, numarul de motociclete cumparate si 
-- pretul mediu al motocicletelor cumparate, pentru clientii care au cumparat
-- cel putin 2 motociclete si au avut o valoare medie a motocicletelor cumparate
-- mai mare de 10000 euro.

-- grup?ri de date cu  subcereri  nesincronizate  in  care  intervin  cel  
-- putin  3  tabele, func?ii grup, filtrare la nivel degrupuri(in cadrul 
-- aceleiasi cereri)
select c.id_client, c.nume, count(vm.id_moto) nr_moto, avg(m.pret) pret_mediu
from clienti c
    left join vanzari v on c.id_client = v.id_client
    left join v_moto vm on v.id_vanzare = vm.id_vanzare
    left join motociclete m on vm.id_moto = m.id_moto
group by c.id_client, c.nume
having count(vm.id_moto) >= 2
        and avg(m.pret) > 10000;
        
-- 4. Afiseaza clientii a caror prenume contine litera 'a' si care au cumparat
-- de la angajati al caror nume e mai lung de 5 caractere.

-- utilizarea a cel pu?in 2 func?ii pe ?iruri de caractere
select distinct c.nume nume_client, c.prenume prenume_client, a.nume nume_angajat
from clienti c, angajati a, vanzari v
where v.id_client = c.id_client
    and v.id_angajat = a.id_angajat
    and lower(c.prenume) like '%a%'
    and length(a.nume) > 5;

-- 5. Afiseaza cea mai scumpa motocicleta cumparata in ziua lunii in care s-au
-- realizat cele mai multe achizitii de motociclete

-- 2 func?ii pe date calendaristice
-- grup?ri de date cu  subcereri  nesincronizate  in  care  intervin  cel  
-- putin  3  tabele, func?ii grup, filtrare la nivel degrupuri(in cadrul 
-- aceleiasi cereri)
select m.id_moto, b.denumire || ' ' || m.model motocicleta, m.pret, v.data_vanzare
from motociclete m, v_moto vm, vanzari v, marci b
where m.id_marca = b.id_marca
    and m.pret = (select max(m.pret)
                from vanzari v, v_moto vm, motociclete m
                where v.id_vanzare = vm.id_vanzare
                    and vm.id_moto = m.id_moto
                    and to_char(v.data_vanzare, 'DD') in (select to_char(v.data_vanzare, 'DD')
                                                          from vanzari v, v_moto vm
                                                          where vm.id_vanzare = v.id_vanzare
                                                          group by to_char(v.data_vanzare, 'DD')
                                                          having count(vm.id_moto) = (select max(count(vm.id_moto))
                                                                                      from vanzari v, v_moto vm
                                                                                      where vm.id_vanzare = v.id_vanzare
                                                                                      group by to_char(v.data_vanzare, 'DD'))))
    and v.id_vanzare = vm.id_vanzare
    and vm.id_moto = m.id_moto
    and to_char(v.data_vanzare, 'DD') in (select to_char(v.data_vanzare, 'DD')
                                          from vanzari v, v_moto vm
                                          where vm.id_vanzare = v.id_vanzare
                                          group by to_char(v.data_vanzare, 'DD')
                                          having count(vm.id_moto) = (select max(count(vm.id_moto))
                                                                      from vanzari v, v_moto vm
                                                                      where vm.id_vanzare = v.id_vanzare
                                                                      group by to_char(v.data_vanzare, 'DD')));

-- EXERCITIUL 13
-- marirea salariului angajatilor cu 10% din fiecare vanzare efectuata
update angajati a set a.salariu = a.salariu+ 0.1*(select sum(v.suma_totala)
                                            from vanzari v
                                            where a.id_angajat = v.id_angajat);

-- stergem toti clientii care nu au facut nicio achizitie
delete from clienti
where id_client not in (select id_client
                        from vanzari);
                        
                    
-- marim pretul masinilor din gama Honda cu 5%
update masini m set m.pret = m.pret * 1.05
where m.id_marca in (select id_marca
                    from marci
                    where lower(denumire) = 'honda');

-- EXERCITIUL 15        
-- top 3 angajati in functie de suma totala a vehiculelor vandute
select *
from (select aux.id_angajat, a.nume, a.prenume, aux.total
        from (select a.id_angajat, sum(v.suma_totala) total
                from angajati a, vanzari v
                where a.id_angajat = v.id_angajat
                group by a.id_angajat) aux, angajati a
        where aux.id_angajat = a.id_angajat
        order by aux.total desc)
where ROWNUM < 4;

-- 2. S? se afi?eze ma?inile cu un motor mai mare de 1300 cmc, 
-- care nu sunt produse în România, care au fost cump?rate de o persoan? 
-- din Bacau ?i care au fost vândute de un angajat cu un salariu 
-- mai mare de 3500 lei.
select mrc.denumire || ' ' || m.model masini_cerute
from marci mrc, masini m, tari t, motor_auto ma, v_auto va, vanzari v, clienti c, locatii l, judete j, angajati a
where m.id_marca = mrc.id_marca(+)
    and m.id_tara_provenienta(+) = t.id_tara
    and m.id_motor(+) = ma.id_motor
    and va.id_auto = m.id_auto
    and va.id_vanzare = v.id_vanzare
    and v.id_client = c.id_client
    and c.id_locatie(+) = l.id_locatie
    and v.id_angajat = a.id_angajat
    and lower(t.denumire) != 'romania'
    and ma.capac_cil > 1300
    and l.id_judet = j.id_judet
    and lower(j.denumire) like 'bacau'
    and a.salariu > 3500;
    
-- 3. S? se afi?eze grupurile auto din care nu s-a înregistrat nicio vânzare.
select denumire
from marci
where grup in (select grup
                from marci
                minus
                select distinct mrc.grup
                from marci mrc, v_auto va, masini m
                where va.id_auto = m.id_auto
                    and mrc.id_marca = m.id_marca
                minus
                select distinct mrc.grup
                from marci mrc, v_moto vm, motociclete m
                where vm.id_moto = m.id_moto
                    and mrc.id_marca = m.id_marca);
                



create table vauto2 (id_vanzare number(7),
                    id_auto number(5),
                    constraint va2_pk2 primary key (id_vanzare,id_auto),
                    constraint va2_idv_fk2 foreign key (id_vanzare) references vanzari(id_vanzare),
                    constraint va2_ida_fk2 foreign key (id_auto) references masini(id_auto));
                    
describe vauto2;                    
                    
                    
                    
                    