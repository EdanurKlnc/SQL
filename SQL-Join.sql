
------------JOIN ��lemleri------------
--Join birle�tirmek anlam�na gelir
--En az 2 tablonun birle�tirilmesi i�in kullan�l�r
--JOIN �e�itleri--
--inner join(kesis�im)
--left join
--right join
--outter (d��) join
--cross join (kartezyen)
--self join (joinin ayn� tablolar �zerinden yap�lm�� hali)
--composite join

--inner join
use OduncKitapDB
select * from Kitaplar k(nolock)
inner join Turler t(nolock) on k.TurId=t.Id -- on => hangi alanla �zerinden kesi�im yap�lacak

select  k.KitapAdi,k.SayfaSayisi, t.TurAdi from 
Kitaplar k(nolock)--tablo 1
inner join Turler t(nolock) --tablo 2
on k.TurId=t.Id --kesi�im sa�lanacak kolon

--Bir kitab�n ad�,t�r� ve yazar�n ad� soyad�
select k.KitapAdi,t.TurAdi,y.YazarAdi+''+y.YazarSoyadi as Yazar --yazar ad� soyad� tek sat�rda birle�ik yazma +
from Kitaplar k(nolock)
inner join Turler  t(nolock) on t.Id= k.TurId
join Yazarlar Y(nolock) on k.YazarId=y.Id
where k.SayfaSayisi >300

-- left join 
-- Kitaplar�n �d�n� al�nma durumu
select * from Kitaplar k (nolock)  -- table 1
 join OduncIslemler oi (nolock)  -- table 2
on k.Id=oi.KitapId

select * from OduncIslemler
--53 camdaki -- 2 �eker 
insert into OduncIslemler (KayitTarihi, KitapId, OduncAlinmaTarihi, OduncBitisTarihi, PersonelId, TeslimEttigiTarih, TeslimEttiMi, UyeId) values 
(getdate(), 53, getdate(), '2023-04-21 13:50:58.903',1,null,0,5),
(getdate(), 2, getdate(), '2023-05-21 13:50:58.903',1,null,0,2)

--�RNEK :10248 numaral� sipari�i kim satm�� ve hangi kargo g�ndermi�
use NORTHWND
SELECT top 5 * FROM Orders (nolock)
SELECT o.OrderID[Sipari� no ],e.FirstName +''+e.LastName[sat��� yapan �al��an], s.CompanyName [kargo firmas�] FROM Orders o(nolock) 
join Employees e on e.EmployeeID = O.EmployeeID
join Shippers s on o.ShipVia = s.ShipperID
where o.OrderID = 10248
--------------------------------------------------------------------------------
--�RNEK: Hi� sipari� verilmemi� �r�nler
--1.c�z�m :LEFT JOIN
select * from Products p (nolock)
left join [Order Details] od (nolock) on p.ProductID = od.ProductID
where od.OrderID is null

--2.c�z�m :RIGHT JOIN (Ana tabloyu 2.s�raya yaz�yoruz)
select * from   [Order Details] od  (nolock)
right join   Products p(nolock) on p.ProductID = od.ProductID
where od.OrderID is null
-----------------------------------------------------------------------------------
--�RNEK: Hi� �d�nc al�nmayan kitaplar
--1.c�z�m :RIGHT JOIN
use OduncKitapDB
select * from OduncIslemler oi(nolock)
right join Kitaplar k on k.Id = oi.KitapId
where oi.Id is null

--2.c�z�m :LEFT JOIN
select * from  Kitaplar k (nolock)
left join  OduncIslemler oi on k.Id = oi.KitapId
where oi.Id is null
---------------------------------------------------------------------------------------
--SELF JOIN :Join i�leminde ayn� tablo kullan�ld���nda �zel isim al�r
use NORTHWND
select clsn.FirstName +''+clsn.LastName [�al��an],
mdr.FirstName+''+mdr.LastName [ba�l� oldu�u �st�]
from Employees clsn (nolock)
join Employees mdr (nolock) on clsn.ReportsTo = mdr.EmployeeID

select *
from Employees clsn (nolock)
 left join Employees mdr(nolock) 
on clsn.ReportsTo = mdr.EmployeeID

select *
from Employees mdr (nolock)
 right join Employees clsn(nolock) 
on clsn.ReportsTo = mdr.EmployeeID
----------------------------------------------------------------------------------
--FULL OUTHER JOIN----
--left ve right joinin birle�imidir.
-- �ki tablodaki e�le�en kay�tlar ve (,) e�le�meyen sol ve sa� kay�tlar i�in kullan�l�r.
use OduncKitapDB
select * from Kitaplar k (nolock)
full outer join Turler t (nolock) on t.Id = k.TurId

select * from Kitaplar k (nolock)
full outer join  OduncIslemler oi on oi.KitapId =k.Id
--------------------------------------------------------------------------------------

--COMPOSITE JOIN---
--�RNEK : �al��anlar�mla ayn� �ehirde olan m��teriler
use NORTHWND
select * from Customers c 
join Employees e on e.Country=c.Country and e.City = c.City and e.PostalCode= c.PostalCode

