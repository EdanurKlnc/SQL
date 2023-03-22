----FUNCTION----
--Matematik fonksiyonlar�
select PI()
select pi() Sonuc
select power(2,3) Sonuc --power => kuvvet al�r. 2'nin 3. kuvveti
select SQRT(81) -- sqrt => karek�k 
select ceiling(9.0000001) --ceiling => verilen say�y� yukar� yuvarlar
select round(9.20125,2) --round ka� basamak istersek(, den sonra yazd���m�z kadar) .'dan sonra o kadar basama�� yazd�r�p kalan�n� 00 yapar
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

----DateTime Function----
select getdate()
select year(getdate()) --sadece y�l 
select month(getdate())
select day(getdate()) 
select dateadd(day,3,getdate()) -- 3 g�n eklenmi� (�uandan 3 g�n sonras�)
select dateadd(year,-3,getdate()) -- 3 y�l �ncesi
select dateadd(day,3,'20230322') -- bu tarihten 3 g�n sonras�


--�RNEK: Sipari�ler verildi�i tarihden itibaren tahmini 3 g�n sonra kargolanacakt�r

use NORTHWND
select o.OrderID, o.OrderDate, 
DATEADD (day,3,o.OrderDate) TahminiKargoTarihi
from Orders o (nolock)

--dateddift 2 tarih aras�ndaki fark� al�r
select DATEDIFF(day,'20220322','20230322') -- �nce k�c�k tarih , daha sonra b�y�k tarih
select DATEDIFF(MONTH,'20220322','20230322') 
select DATEDIFF(year,'20220322','20230322') 

--�RNEK : Sipari�i verildi�i ve kargoland��� tarih aras�nda ka� g�n ge�mi�tir? 20 g�n� a�an kargolar� g�ster
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day,o.OrderDate,o.ShippedDate) [Ka� g�nde kargolanm��t�r?]
from Orders (nolock)o
where o.ShipVia = 3  and DATEDIFF(day,o.OrderDate,o.ShippedDate) > 20


select o.OrderID, o.OrderDate, o.ShippedDate,
c.CompanyName, c.ContactName, c.Phone,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Ka� G�nde Kargolanm��t�r? ]
from Orders (nolock) o
join Customers c on c.CustomerID=o.CustomerID
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

----String Function----
select ASCII ('a') --a'n�n ilk bulundu� yerin indexsini al�r (sql'De indexs 1den ba�lar)
select char (97)

select CHARINDEX('a' ,'ali ata bak') -- 1.indexs
select left ('bet�l',1) --soldan ba�lay�p ka� harf istersek o kadar�n� yazar
select left ('bet�l',3) --c�kt� = bet
select left ('bet�l',4) --c�kt� = bet�
select right ('bet�l',3) --c�kt� = t�l

--trim ifadedeki sa� ve soldaki bo�luklar� siler
select trim  ('    edanur   ')
select ltrim ('    edanur   ') --sadece soldaki bo�lu�u siler
select rtrim ('    edanur   ') --sadece sa�daki bo�lu�u siler

--substring ifadenin i�inden bir k�sm� keser/al�r
select SUBSTRING ('edanur k�l�n�',1,4) --c�kt� =edan (1.indexsinden itibaren 4 harf yazd�r)
select SUBSTRING ('edanur k�l�n�',3,7) 

--replace yerine ba�ka de�er koymak
select replace ('edanur k�l�n�' ,'e','a') -- verilenin i�indeki e'leri a ile de�i�tir c�kt� = adanur k�l�n�
select replace ('edanur k�l�n�' ,'nur','eda')  --c�kt� = edaeda k�l�n�


select len('e d a n u r') -- bo�luklar�da sayarak ka� karakter oldu�unu sayar .c�kt�=11

--concat birle�tirme
select concat ('eda',' ','nur') --c�kt� = eda nur

--str i�inde yaz�lan ifadeyi stringe ceviri
select str(GETDATE())
select str(12)
--fonk. i�erisinde fonk. kullan�labilir
select trim(str(GETDATE()))

--�RNEK:22/03/2023
select trim(str(day(o.OrderDate))),trim(str(month(o.OrderDate))),trim(str(year(o.OrderDate))) from Orders o  --c�kt� 22   03   2023
select concat(trim(str(day(o.OrderDate))),trim(str(month(o.OrderDate))),trim(str(year(o.OrderDate)))) from Orders o --c�kt� =22032023
select concat(trim(str(day(o.OrderDate))),'/',trim(str(month(o.OrderDate))),'/',trim(str(year(o.OrderDate)))) from Orders o --c�kt� =22/03/2023
-----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

---Aggregate Function ---
--Tek ba��na veya group by ile berber kullan�l�r
--SUM :Bir sut�ndaki verileri toplar.
--MAX : Bir kolondaki veriler aras�ndan en b�y�k olan� verir.
--MIN : Bir kolondaki veriler aras�ndan en k�c�k olan� verir.
--AVG : Bir kolondaki verilerin ortalamas�n� al�r.
--COUNT : Bir kolondaki verilerin say�s�n� verir.

--!!!D�PNOT : Hesaplama fonk. null olan de�erleri dikkate almaz !!!

use NORTHWND
select count (*) from Customers  c(nolock)
select count (Region) from Customers  c(nolock)

select max (UnitPrice) [En pahal� �r�n fiyat�] from  Products
select sum (UnitPrice) [Toplam �r�n fiyat�] from  Products
select avg(UnitPrice) [Ortalama �r�n fiyat�] from  Products

--null de�er ile i�le yap�labiliyor mu ?
create table DenemeNull(
id int identity (1,1) primary key,
Deger int null
)
insert into DenemeNull (Deger) values(100),(null), (150), (200), (null),(50)
select * from DenemeNull

insert into DenemeNull (Deger) values(100),(null), (150), (200), (null),(50)
select avg (deger) from DenemeNull --null de�erleri dikkate almaz

select avg(isnull(Deger,0)) Sonuc from DenemeNull -- null degerleri 0 olarak alacak
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

-----ROWNUMBER()----
--Veriye sat�r numaras� ekleyen fonksiyon
use NORTHWND
select ROW_NUMBER () over (order by p.ProductName) S�raNo,
p.ProductName, p.CategoryID ,p.UnitPrice
from Products p (nolock)

use OduncKitapDB
select ROW_NUMBER () over (order by k.SayfaSayisi desc) S�raNo, *
from Kitaplar k (nolock)

select ROW_NUMBER () over (order by k.SayfaSayisi desc) S�raNo, k.KitapAdi,t.TurAdi,
*
from Kitaplar k (nolock)
join Turler t on t.Id = k.TurId
join Yazarlar y on y.Id = k.YazarId

