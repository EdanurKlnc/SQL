--ORDER BY--
--Artan yada azalan sýralama yapar
--ORDER BY ifadesinden Tek bir kolon varsa tek kolona göre,birden çok kolon varsa önce ilki sonra diðerine göre sýralar

use OduncKitapDB
select * from Kitaplar order by StokAdeti --Stok adetine göre sýralama

select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi

select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc --desc =tersten sýralama 


select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc , SayfaSayisi asc --asc = düz sýralama

select * from Kitaplar order by StokAdeti ,KitapAdi desc ,TurId --yazma sýrasýna göre sýralar

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

----GROUP BY-----
--amaç * kullanmamak
--nereyi gruplayack isek orayý caðýrýyoruz
--Genellikle aggregate fonksiyonlar ile kullanýlýr.

--ÖRNEK : Hangi ülkede kaç müþteri var?
use NORTHWND
select top 10 * from Customers c(nolock)

select c.Country,c.City, count (*) [Müþteri sayýsý]
from Customers c(nolock)
group by c.Country ,c.City
order by [Müþteri sayýsý] desc

--ÖRNEK :Kitaplar tablosunda yazarýn kaç adet kitabý var ?
use OduncKitapDB
select k.YazarId,y.YazarAdi,y.YazarSoyadi, count (*) [Kitap sayýsý]
from Kitaplar k (nolock)
join Yazarlar y (nolock) on k.YazarId = y.Id
group by k.YazarId, y.YazarAdi,y.YazarSoyadi

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

----HAVING----
-- Having ile Group by ile grupladýðýnýz kolonu ya da agregate func iþleminin sonucunu koþula tabi tutabilirsiniz.
--Gruplanan veriler üzerinde fonksiyonlar ile yazýlacak koþul ifadelerinin gerçekleþtirilebilmesi için HAVING ifadesi kullanýlýr.
--!!!DÝPNOT =  
--ÖRNEK : Hangi ülkede 5'ten fazla müþteri var?
use NORTHWND
select c.Country, count (*) [Müþteri sayýsý]
from Customers c(nolock)
group by c.Country 
having count(*) > 5 and c.Country !='USA'
order by c.Country desc

----Performan acýsýndan aþaðýdaki daha iyi
--Neden? çünkü önce datadan USA 'yý çýkarttý daha sonra grupladý
select c.Country, count (*) [Müþteri sayýsý]
from Customers c(nolock)
where c.Country !='USA'
group by c.Country 
having count(*) > 5 
order by c.Country desc

--ÖRNEK: Ürün bazýnda ciro
select od.ProductID, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) [Ciro]
from [Order Details] od
group by od.ProductID

--ÖRNEK: Ürün bazýnda ciro, ürün ismi 
select od.ProductID,p.ProductName, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) [Ciro]
from [Order Details] od
join Products p(nolock) on p.ProductID = od.ProductID
group by od.ProductID, p.ProductName

--ÖRNEK : En çok(order by) alýþveriþ yapan müþteri
select top 1  o.CustomerID,c.CompanyName,count (*) [Alýþveriþ sayýsý]
from Orders o (nolock)
join Customers c (nolock) on c.CustomerID = o.CustomerID
group by o.CustomerID , c.CompanyName
order by [Alýþveriþ sayýsý] desc


--ÖRNEK: En çok satýþ yapan çalýþan
select top 1 o.EmployeeID, e.FirstName, e.LastName,
count(*) [Satýþ Sayýsý]
from Orders (nolock) o
join Employees e (nolock) on e.EmployeeID= o.EmployeeID
where e.City='London'
group by o.EmployeeID, e.FirstName, e.LastName
order by [Satýþ Sayýsý] desc

--ÖRNEK:Türe göre ödünç iþlem sayýsý 
use OduncKitapDB
select t.TurAdi, count(*) [Ödünç alýnma sayýsý]
from OduncIslemler o
join Kitaplar k on o.KitapId= k.Id
join Turler t on t.Id= k.TurId
group by t.TurAdi