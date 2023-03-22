-------CASE WHEN THEN--------
--Ko�ula g�re kolonu �ekillendirir.
--case - end blo�u aras�na when ile ko�ul yaz�l�r.
-- when ' den sonra ko�ul gelir.
--Ko�ul bitti�inde else ifadesiyle ko�ula uymayanlar� alabiliriz.

--YAPISI:
-- CASE
         
--		WHEN 'Ko�ul' THEN 'ko�ul gecerli ise ne yaz�lacak' // then'den sona illa string bir ifade gelcek diye bir �ey yok !!!

--      ELSE 'Belirtilen k�ul gecerli de�ilse yaz�lacak'

-- END

-----------------------------------------------------------------------------------------------------

--�RNEK: Her sat�r i�in discount > 0 ise indirimli de�ilse indirimsiz yazan kolon olu�tural�m
use NORTHWND
select * ,
case
when od.Discount > 0 then 'indirimli'
else 'indirimsiz' 
end [�ndirim Durumu] --end case ifadesini bitti�ini belirtmek i�in
from [Order Details] od (nolock)

--�RNEK: Sipari� detay tablosundaki her sat�rdaki �r�n i�in e�er quentitiy < 3 ise stok t�keniyor , 
--10 ile 50 aras�nda ise Kampanyaya uygun , 50den b�y�k isem�d�r onay� gerekli yazs�n.Hi�birine uymuyorsa ---- yazs�n

select od.OrderID,od.ProductID,od.Quantity ,
case
when od.Quantity <3 then 'Stok t�keniyor'
when od.Quantity between 10 and 50 then 'Kampanyaya uygun'
when od.Quantity >50 then 'M�d�r onay� gerekli'
else '---'
end
from [Order Details] od

--�RNEK : Sipari� tablosundaki  shipcountry alan�na bakal�m. ��inde cc gecen kolonlara puan verelim

select o.OrderId , o.ShipCountry,
case
when o.ShipCountry like '%an%' or o.ShipVia=3 then 100
else 0
end [Kargo �lke puan�]
from Orders o



