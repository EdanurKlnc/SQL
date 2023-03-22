
------------JOIN Ýþlemleri------------
--Join birleþtirmek anlamýna gelir
--En az 2 tablonun birleþtirilmesi için kullanýlýr
--JOIN Çeþitleri--
--inner join(kesisþim)
--left join
--right join
--outter (dýþ) join
--cross join (kartezyen)
--self join (joinin ayný tablolar üzerinden yapýlmýþ hali)
--composite join

--inner join
use OduncKitapDB
select * from Kitaplar k(nolock)
inner join Turler t(nolock) on k.TurId=t.Id -- on => hangi alanla üzerinden kesiþim yapýlacak

select  k.KitapAdi,k.SayfaSayisi, t.TurAdi from 
Kitaplar k(nolock)--tablo 1
inner join Turler t(nolock) --tablo 2
on k.TurId=t.Id --kesiþim saðlanacak kolon

--Bir kitabýn adý,türü ve yazarýn adý soyadý
select k.KitapAdi,t.TurAdi,y.YazarAdi+''+y.YazarSoyadi as Yazar --yazar adý soyadý tek satýrda birleþik yazma +
from Kitaplar k(nolock)
inner join Turler  t(nolock) on t.Id= k.TurId
join Yazarlar Y(nolock) on k.YazarId=y.Id
where k.SayfaSayisi >300

-- left join 
-- Kitaplarýn ödünç alýnma durumu
select * from Kitaplar k (nolock)  -- table 1
 join OduncIslemler oi (nolock)  -- table 2
on k.Id=oi.KitapId

select * from OduncIslemler
--53 camdaki -- 2 þeker 
insert into OduncIslemler (KayitTarihi, KitapId, OduncAlinmaTarihi, OduncBitisTarihi, PersonelId, TeslimEttigiTarih, TeslimEttiMi, UyeId) values 
(getdate(), 53, getdate(), '2023-04-21 13:50:58.903',1,null,0,5),
(getdate(), 2, getdate(), '2023-05-21 13:50:58.903',1,null,0,2)

--ÖRNEK :10248 numaralý sipariþi kim satmýþ ve hangi kargo göndermiþ
use NORTHWND
SELECT top 5 * FROM Orders (nolock)
SELECT o.OrderID[Sipariþ no ],e.FirstName +''+e.LastName[satýþý yapan çalýþan], s.CompanyName [kargo firmasý] FROM Orders o(nolock) 
join Employees e on e.EmployeeID = O.EmployeeID
join Shippers s on o.ShipVia = s.ShipperID
where o.OrderID = 10248
--------------------------------------------------------------------------------
--ÖRNEK: Hiç sipariþ verilmemiþ ürünler
--1.cözüm :LEFT JOIN
select * from Products p (nolock)
left join [Order Details] od (nolock) on p.ProductID = od.ProductID
where od.OrderID is null

--2.cözüm :RIGHT JOIN (Ana tabloyu 2.sýraya yazýyoruz)
select * from   [Order Details] od  (nolock)
right join   Products p(nolock) on p.ProductID = od.ProductID
where od.OrderID is null
-----------------------------------------------------------------------------------
--ÖRNEK: Hiç ödünc alýnmayan kitaplar
--1.cözüm :RIGHT JOIN
use OduncKitapDB
select * from OduncIslemler oi(nolock)
right join Kitaplar k on k.Id = oi.KitapId
where oi.Id is null

--2.cözüm :LEFT JOIN
select * from  Kitaplar k (nolock)
left join  OduncIslemler oi on k.Id = oi.KitapId
where oi.Id is null
---------------------------------------------------------------------------------------
--SELF JOIN :Join iþleminde ayný tablo kullanýldýðýnda özel isim alýr
use NORTHWND
select clsn.FirstName +''+clsn.LastName [Çalýþan],
mdr.FirstName+''+mdr.LastName [baðlý olduðu üstü]
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
--left ve right joinin birleþimidir.
-- Ýki tablodaki eþleþen kayýtlar ve (,) eþleþmeyen sol ve sað kayýtlar için kullanýlýr.
use OduncKitapDB
select * from Kitaplar k (nolock)
full outer join Turler t (nolock) on t.Id = k.TurId

select * from Kitaplar k (nolock)
full outer join  OduncIslemler oi on oi.KitapId =k.Id
--------------------------------------------------------------------------------------

--COMPOSITE JOIN---
--ÖRNEK : Çalýþanlarýmla ayný þehirde olan müþteriler
use NORTHWND
select * from Customers c 
join Employees e on e.Country=c.Country and e.City = c.City and e.PostalCode= c.PostalCode

