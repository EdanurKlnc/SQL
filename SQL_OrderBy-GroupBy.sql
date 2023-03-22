--ORDER BY--
--Artan yada azalan s�ralama yapar
--ORDER BY ifadesinden Tek bir kolon varsa tek kolona g�re,birden �ok kolon varsa �nce ilki sonra di�erine g�re s�ralar

use OduncKitapDB
select * from Kitaplar order by StokAdeti --Stok adetine g�re s�ralama

select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi

select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc --desc =tersten s�ralama 


select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc , SayfaSayisi asc --asc = d�z s�ralama

select * from Kitaplar order by StokAdeti ,KitapAdi desc ,TurId --yazma s�ras�na g�re s�ralar

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

----GROUP BY-----
--ama� * kullanmamak
--nereyi gruplayack isek oray� ca��r�yoruz
--Genellikle aggregate fonksiyonlar ile kullan�l�r.

--�RNEK : Hangi �lkede ka� m��teri var?
use NORTHWND
select top 10 * from Customers c(nolock)

select c.Country,c.City, count (*) [M��teri say�s�]
from Customers c(nolock)
group by c.Country ,c.City
order by [M��teri say�s�] desc

--�RNEK :Kitaplar tablosunda yazar�n ka� adet kitab� var ?
use OduncKitapDB
select k.YazarId,y.YazarAdi,y.YazarSoyadi, count (*) [Kitap say�s�]
from Kitaplar k (nolock)
join Yazarlar y (nolock) on k.YazarId = y.Id
group by k.YazarId, y.YazarAdi,y.YazarSoyadi

----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

----HAVING----
-- Having ile Group by ile gruplad���n�z kolonu ya da agregate func i�leminin sonucunu ko�ula tabi tutabilirsiniz.
--Gruplanan veriler �zerinde fonksiyonlar ile yaz�lacak ko�ul ifadelerinin ger�ekle�tirilebilmesi i�in HAVING ifadesi kullan�l�r.
--!!!D�PNOT =  
--�RNEK : Hangi �lkede 5'ten fazla m��teri var?
use NORTHWND
select c.Country, count (*) [M��teri say�s�]
from Customers c(nolock)
group by c.Country 
having count(*) > 5 and c.Country !='USA'
order by c.Country desc

----Performan ac�s�ndan a�a��daki daha iyi
--Neden? ��nk� �nce datadan USA 'y� ��kartt� daha sonra gruplad�
select c.Country, count (*) [M��teri say�s�]
from Customers c(nolock)
where c.Country !='USA'
group by c.Country 
having count(*) > 5 
order by c.Country desc

--�RNEK: �r�n baz�nda ciro
select od.ProductID, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) [Ciro]
from [Order Details] od
group by od.ProductID

--�RNEK: �r�n baz�nda ciro, �r�n ismi 
select od.ProductID,p.ProductName, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) [Ciro]
from [Order Details] od
join Products p(nolock) on p.ProductID = od.ProductID
group by od.ProductID, p.ProductName

--�RNEK : En �ok(order by) al��veri� yapan m��teri
select top 1  o.CustomerID,c.CompanyName,count (*) [Al��veri� say�s�]
from Orders o (nolock)
join Customers c (nolock) on c.CustomerID = o.CustomerID
group by o.CustomerID , c.CompanyName
order by [Al��veri� say�s�] desc


--�RNEK: En �ok sat�� yapan �al��an
select top 1 o.EmployeeID, e.FirstName, e.LastName,
count(*) [Sat�� Say�s�]
from Orders (nolock) o
join Employees e (nolock) on e.EmployeeID= o.EmployeeID
where e.City='London'
group by o.EmployeeID, e.FirstName, e.LastName
order by [Sat�� Say�s�] desc

--�RNEK:T�re g�re �d�n� i�lem say�s� 
use OduncKitapDB
select t.TurAdi, count(*) [�d�n� al�nma say�s�]
from OduncIslemler o
join Kitaplar k on o.KitapId= k.Id
join Turler t on t.Id= k.TurId
group by t.TurAdi