-------CASE WHEN THEN--------
--Koþula göre kolonu þekillendirir.
--case - end bloðu arasýna when ile koþul yazýlýr.
-- when ' den sonra koþul gelir.
--Koþul bittiðinde else ifadesiyle koþula uymayanlarý alabiliriz.

--YAPISI:
-- CASE
         
--		WHEN 'Koþul' THEN 'koþul gecerli ise ne yazýlacak' // then'den sona illa string bir ifade gelcek diye bir þey yok !!!

--      ELSE 'Belirtilen kþul gecerli deðilse yazýlacak'

-- END

-----------------------------------------------------------------------------------------------------

--ÖRNEK: Her satýr için discount > 0 ise indirimli deðilse indirimsiz yazan kolon oluþturalým
use NORTHWND
select * ,
case
when od.Discount > 0 then 'indirimli'
else 'indirimsiz' 
end [Ýndirim Durumu] --end case ifadesini bittiðini belirtmek için
from [Order Details] od (nolock)

--ÖRNEK: Sipariþ detay tablosundaki her satýrdaki ürün için eðer quentitiy < 3 ise stok tükeniyor , 
--10 ile 50 arasýnda ise Kampanyaya uygun , 50den büyük isemüdür onayý gerekli yazsýn.Hiçbirine uymuyorsa ---- yazsýn

select od.OrderID,od.ProductID,od.Quantity ,
case
when od.Quantity <3 then 'Stok tükeniyor'
when od.Quantity between 10 and 50 then 'Kampanyaya uygun'
when od.Quantity >50 then 'Müdür onayý gerekli'
else '---'
end
from [Order Details] od

--ÖRNEK : Sipariþ tablosundaki  shipcountry alanýna bakalým. Ýçinde cc gecen kolonlara puan verelim

select o.OrderId , o.ShipCountry,
case
when o.ShipCountry like '%an%' or o.ShipVia=3 then 100
else 0
end [Kargo ülke puaný]
from Orders o



